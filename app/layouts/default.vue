<template>
  <div class="min-h-screen bg-default text-default">
    <AppNavbar />

    <main>
      <UContainer class="py-8">
        <slot />
      </UContainer>
    </main>
  </div>
</template>
