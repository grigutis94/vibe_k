<template>
  <header class="border-b border-default">
    <UContainer class="py-4">
      <div class="flex items-center justify-between gap-4">
        <NuxtLink to="/" class="text-lg font-semibold">VibeHub</NuxtLink>

        <nav class="flex items-center gap-2">
          <UButton to="/prompts" variant="ghost" color="neutral">Prompts</UButton>
          <UButton to="/tools" variant="ghost" color="neutral">Tools</UButton>
        </nav>
      </div>
    </UContainer>
  </header>
</template>
