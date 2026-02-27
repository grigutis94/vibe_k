<template>
  <section class="panel">
    <h1>Tools</h1>
    <p class="section-subtitle">Store and browse useful tool links here.</p>

    <form class="form-grid" @submit.prevent="addTool">
      <label class="field">
        <span>Title</span>
        <input v-model.trim="form.title" type="text" required placeholder="Tool name" />
      </label>

      <label class="field">
        <span>URL</span>
        <input v-model.trim="form.url" type="url" required placeholder="https://example.com" />
      </label>

      <label class="field field-full">
        <span>Description</span>
        <textarea
          v-model.trim="form.description"
          rows="3"
          required
          placeholder="Short practical note"
        />
      </label>

      <button class="btn" type="submit" :disabled="isSaving">
        {{ isSaving ? 'Saving...' : 'Save tool' }}
      </button>
    </form>

    <p v-if="errorMessage" class="status-error">{{ errorMessage }}</p>

    <div class="list-block">
      <h2>Saved tools</h2>
      <p v-if="isLoading">Loading...</p>
      <p v-else-if="tools.length === 0">No tools yet.</p>

      <ul v-else class="simple-list">
        <li v-for="tool in tools" :key="tool.id">
          <a :href="tool.url" target="_blank" rel="noreferrer" class="list-title list-link">
            {{ tool.title }}
          </a>
          <p>{{ tool.description }}</p>
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

const form = reactive({
  title: '',
  url: '',
  description: ''
})

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

onMounted(fetchTools)
</script>
