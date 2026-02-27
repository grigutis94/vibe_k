<template>
  <section class="panel">
    <h1>Prompts</h1>
    <p class="section-subtitle">Create and manage AI prompts here.</p>

    <form class="form-grid" @submit.prevent="addPrompt">
      <label class="field">
        <span>Name</span>
        <input v-model.trim="form.name" type="text" required placeholder="Your name" />
      </label>

      <label class="field field-full">
        <span>Prompt text</span>
        <textarea
          v-model.trim="form.promptText"
          rows="4"
          required
          placeholder="Write your prompt..."
        />
      </label>

      <button class="btn" type="submit" :disabled="isSaving">
        {{ isSaving ? 'Saving...' : 'Save prompt' }}
      </button>
    </form>

    <p v-if="errorMessage" class="status-error">{{ errorMessage }}</p>

    <div class="list-block">
      <h2>Saved prompts</h2>
      <p v-if="isLoading">Loading...</p>
      <p v-else-if="prompts.length === 0">No prompts yet.</p>

      <ul v-else class="simple-list">
        <li v-for="prompt in prompts" :key="prompt.id" class="prompt-item">
          <div class="prompt-item-header">
            <img
              class="prompt-avatar"
              :src="getAuthorAvatarUrl(prompt.name)"
              :alt="`Author avatar for ${prompt.name || 'Unknown'}`"
              loading="lazy"
              decoding="async"
              referrerpolicy="no-referrer"
            />
            <p class="list-title">{{ prompt.name }}</p>
          </div>
          <p>{{ prompt.prompt_text }}</p>
        </li>
      </ul>
    </div>
  </section>
</template>

<script setup>
import { onMounted, reactive, ref } from 'vue'
import { supabase, supabaseConfigError } from '../lib/supabase'
import { getAuthorAvatarUrl } from '../lib/avatar'

const prompts = ref([])
const isLoading = ref(true)
const isSaving = ref(false)
const errorMessage = ref('')

const form = reactive({
  name: '',
  promptText: ''
})

const fetchPrompts = async () => {
  if (supabaseConfigError) {
    errorMessage.value = supabaseConfigError
    isLoading.value = false
    return
  }

  isLoading.value = true
  errorMessage.value = ''

  const { data, error } = await supabase
    .from('prompts')
    .select('id, name, prompt_text, created_at')
    .order('created_at', { ascending: false })

  if (error) {
    errorMessage.value = error.message
    isLoading.value = false
    return
  }

  prompts.value = data ?? []
  isLoading.value = false
}

const addPrompt = async () => {
  if (supabaseConfigError) {
    errorMessage.value = supabaseConfigError
    return
  }

  isSaving.value = true
  errorMessage.value = ''

  const payload = {
    name: form.name,
    prompt_text: form.promptText
  }

  const { data, error } = await supabase
    .from('prompts')
    .insert([payload])
    .select('id, name, prompt_text, created_at')
    .single()

  if (error) {
    errorMessage.value = error.message
    isSaving.value = false
    return
  }

  prompts.value = [data, ...prompts.value]
  form.name = ''
  form.promptText = ''
  isSaving.value = false
}

onMounted(fetchPrompts)
</script>
