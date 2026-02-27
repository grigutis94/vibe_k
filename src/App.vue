<template>
  <div class="app-shell">
    <header class="topbar">
      <div class="container topbar-inner">
        <RouterLink to="/prompts" class="brand">VibeHub</RouterLink>
        <nav class="nav">
          <RouterLink to="/prompts" class="nav-link" active-class="nav-link-active">Prompts</RouterLink>
          <RouterLink to="/tools" class="nav-link" active-class="nav-link-active">Tools</RouterLink>
        </nav>
      </div>
    </header>

    <main class="container content">
      <RouterView />
    </main>
  </div>
</template>
