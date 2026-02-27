<template>
  <section class="panel">
    <!-- Joke card -->
    <div class="joke-card">
      <div class="joke-card-header">
        <span class="joke-badge">😄 Programuotojų juokelis</span>
        <button class="btn-ghost" :disabled="isLoadingJoke" @click="fetchJoke">
          {{ isLoadingJoke ? 'Kraunama...' : '↻ Kitas juokelis' }}
        </button>
      </div>

      <div v-if="isLoadingJoke" class="joke-loading">Kraunamas juokelis…</div>
      <div v-else-if="jokeError" class="joke-error">{{ jokeError }}</div>
      <div v-else-if="jokeTranslated">
        <template v-if="jokeTranslated.type === 'twopart'">
          <p class="joke-setup">{{ jokeTranslated.setup }}</p>
          <p class="joke-punchline">{{ jokeTranslated.delivery }}</p>
        </template>
        <p v-else class="joke-text">{{ jokeTranslated.joke }}</p>
      </div>
    </div>

    <h1>Įrankiai</h1>
    <p class="section-subtitle">Išsaugokite ir naršykite naudingus įrankių nuorodas.</p>

    <form class="form-grid" @submit.prevent="addTool">
      <label class="field">
        <span>Pavadinimas</span>
        <input v-model.trim="form.title" type="text" required placeholder="Įrankio pavadinimas" />
      </label>

      <label class="field">
        <span>URL nuoroda</span>
        <input v-model.trim="form.url" type="url" required placeholder="https://example.com" />
      </label>

      <label class="field field-full">
        <span>Aprašymas</span>
        <textarea
          v-model.trim="form.description"
          rows="3"
          required
          placeholder="Trumpas aprašymas"
        />
      </label>

      <button class="btn btn-primary" type="submit" :disabled="isSaving">
        {{ isSaving ? 'Saugoma...' : '+ Išsaugoti įrankį' }}
      </button>
    </form>

    <p v-if="errorMessage" class="status-error">{{ errorMessage }}</p>

    <div class="list-block">
      <h2>Išsaugoti įrankiai</h2>
      <p v-if="isLoading" class="list-empty">Kraunama…</p>
      <p v-else-if="tools.length === 0" class="list-empty">Įrankių dar nėra.</p>

      <ul v-else class="tools-list">
        <li v-for="tool in tools" :key="tool.id" class="tool-card">
          <div class="tool-card-body">
            <a :href="tool.url" target="_blank" rel="noreferrer" class="tool-title">
              {{ tool.title }}
            </a>
            <p class="tool-desc">{{ tool.description }}</p>
          </div>
          <a :href="tool.url" target="_blank" rel="noreferrer" class="tool-link-btn">
            Atidaryti ↗
          </a>
        </li>
      </ul>
    </div>
  </section>
</template>

<script setup>
import { onMounted, reactive, ref } from 'vue'
import { supabase, supabaseConfigError } from '../lib/supabase'

const tools = ref([])
const isLoading = ref(true)
const isSaving = ref(false)
const errorMessage = ref('')

const jokeTranslated = ref(null)
const isLoadingJoke = ref(false)
const jokeError = ref('')

const form = reactive({
  title: '',
  url: '',
  description: ''
})

const translate = async (text) => {
  const res = await fetch(
    `https://api.mymemory.translated.net/get?q=${encodeURIComponent(text)}&langpair=en|lt`
  )
  const json = await res.json()
  if (json.responseStatus !== 200) throw new Error('Vertimas nepavyko')
  return json.responseData.translatedText
}

const fetchJoke = async () => {
  isLoadingJoke.value = true
  jokeError.value = ''
  try {
    const res = await fetch('https://v2.jokeapi.dev/joke/Programming?lang=en&safe-mode')
    const data = await res.json()
    if (data.error) throw new Error('Juokelio gauti nepavyko')

    if (data.type === 'twopart') {
      jokeTranslated.value = {
        type: 'twopart',
        setup: await translate(data.setup),
        delivery: await translate(data.delivery)
      }
    } else {
      jokeTranslated.value = {
        type: 'single',
        joke: await translate(data.joke)
      }
    }
  } catch (err) {
    jokeError.value = err.message || 'Klaida gaunant juokelį'
  } finally {
    isLoadingJoke.value = false
  }
}

const fetchTools = async () => {
  if (supabaseConfigError) {
    errorMessage.value = supabaseConfigError
    isLoading.value = false
    return
  }

  isLoading.value = true
  errorMessage.value = ''

  const { data, error } = await supabase
    .from('tools')
    .select('id, title, url, description, created_at')
    .order('created_at', { ascending: false })

  if (error) {
    errorMessage.value = error.message
    isLoading.value = false
    return
  }

  tools.value = data ?? []
  isLoading.value = false
}

const addTool = async () => {
  if (supabaseConfigError) {
    errorMessage.value = supabaseConfigError
    return
  }

  isSaving.value = true
  errorMessage.value = ''

  const payload = {
    title: form.title,
    url: form.url,
    description: form.description
  }

  const { data, error } = await supabase
    .from('tools')
    .insert([payload])
    .select('id, title, url, description, created_at')
    .single()

  if (error) {
    errorMessage.value = error.message
    isSaving.value = false
    return
  }

  tools.value = [data, ...tools.value]
  form.title = ''
  form.url = ''
  form.description = ''
  isSaving.value = false
}

onMounted(() => {
  fetchTools()
  fetchJoke()
})
</script>
