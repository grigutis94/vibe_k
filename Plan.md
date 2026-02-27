# VibeHub Implementation Plan

This is a step-by-step plan to build the VibeHub app based on your group exercise and tech stack:

- Mac
- Node.js
- Cursor Pro (Grok-powered)
- Nuxt/Vue
- Nuxt UI
- Grok API
- GitHub
- Vercel

The plan includes AI agent prompts you can use in tools like Cursor Pro or Grok to speed up tasks.

Assumption: two-person team (you as Edvinas and one collaborator).

---

## Step 1: Agree on Tech Stack and Overall Architecture

Discuss and finalize tools so everyone aligns.

- Frontend: Nuxt/Vue
- Database: Supabase (easy SDK for client-side operations)
- External APIs: as required by the exercise

**AI Agent Prompt**

```text
As a Vue/Nuxt expert, suggest a simple architecture for a two-page app (Prompts and Tools sections) using Nuxt 3, Nuxt UI for components, and Supabase for real-time data. Include basic routing and a shared navbar. Output in bullet points with code snippets for setup.
```

## Step 2: Divide Tasks Between Team Members

Split work according to the exercise:

- Person A (e.g., you): Prompts section with avatars
- Person B: Tools section with jokes/tips
- Both: shared elements like navbar

Assign roles via quick call or chat.

**AI Agent Prompt**

```text
Act as a project manager for a small dev team. Based on this app description [paste exercise details], divide tasks into two roles (A for Prompts, B for Tools). List responsibilities, including DB tables, UI, API integrations, and Git branches. Suggest how to handle shared code like navbar to avoid conflicts.
```

## Step 3: Set Up the GitHub Repository

One person creates the repo.

- Add collaborators
- Include a `.gitignore` for Node.js (`node_modules`, `.env`, etc.)
- Use GitHub web interface or CLI on Mac

**AI Agent Prompt**

```text
Generate a .gitignore file for a Nuxt.js project using Node.js, Supabase, and Vercel. Include common ignores for logs, builds, and env files. Also, provide Git commands to init the repo, add remote, and invite a collaborator.
```

## Step 4: Clone Repo and Create Development Branch

Both team members clone the repo and create a `dev` branch from `main`.

Commands:

```bash
git clone [repo-url]
git checkout -b dev
git push origin dev
```

**AI Agent Prompt**

```text
As a Git expert, list step-by-step commands for two devs to clone a GitHub repo, create a dev branch, and set it as default. Include tips for resolving common clone issues on Mac with Node.js.
```

## Step 5: Initialize the Project Base

In the `dev` branch, set up the core Nuxt project with navbar and routing.

- Use `npx nuxi init` to start
- Add Nuxt UI via `yarn add @nuxt/ui`
- Create pages: `/prompts` and `/tools`
- Add a layout with navbar
- Commit and push to `dev`

**AI Agent Prompt**

```text
Using Nuxt 3 and Nuxt UI, generate code for a basic app setup: install dependencies, create a navbar component with links to /prompts and /tools, and set up routing. Provide full code files like app.vue and layouts/default.vue.
```

## Step 6: Create Feature Branches and Build Individually

Each person checks out from `dev`, creates a feature branch (e.g., `feature/prompts`, `feature/tools`), and builds their section.

- **Prompts:** connect Supabase table `prompts` (`name`, `prompt_text`), build form + list UI, fetch avatars from DiceBear API
- **Tools:** connect Supabase table `tools` (`title`, `url`, `description`), build form + list UI, fetch jokes from JokeAPI
- Use `fetch()` for APIs and test locally

**AI Agent Prompt (Prompts)**

```text
In Nuxt/Vue, write code for a Prompts page: connect to Supabase to create/insert into 'prompts' table (fields: name, prompt_text), display list with auto-generated avatars from DiceBear API using user name as seed. Include form component with Nuxt UI.
```

**AI Agent Prompt (Tools)**

```text
In Nuxt/Vue, code a Tools page: use Supabase to manage 'tools' table (title, url, description), show card list, add form for new entries. Fetch and display a random programming joke from JokeAPI at the top on page load.
```

## Step 7: Test Locally and Commit

Run the app locally (`yarn dev`), then test:

- Forms
- DB saves
- API fetches
- Navigation

Fix bugs before pushing.

**AI Agent Prompt**

```text
Suggest debugging steps for a Nuxt app with Supabase and external APIs. Focus on common errors like CORS, auth, or fetch failures. Include console.log examples.
```

## Step 8: Create Pull Requests to Dev Branch

- Push feature branches
- Open PRs to `dev`
- Review each other's code
- Test merges locally

Resolve conflicts (especially in shared files like routes/layouts) via `git merge`/`git rebase`.

**AI Agent Prompt**

```text
Explain how to resolve Git merge conflicts in a Nuxt project, especially for shared Vue components. Provide example commands and a sample conflict resolution in code.
```

## Step 9: Merge to Dev and Test Together

- Approve and merge PRs to `dev`
- Both pull updates and test full app
- Connect to Vercel for preview deploys on `dev` pushes

**AI Agent Prompt**

```text
Guide setting up Vercel for a Nuxt app from GitHub. Include steps for env vars (e.g., Supabase keys) and auto-deploys on dev branch.
```

## Step 10: Final PR to Main and Deploy

- Create PR from `dev` to `main`
- Merge after final checks
- Vercel auto-deploys to production

Verify at least 4 functionalities:

- Forms
- Lists
- Navigation
- API displays

**AI Agent Prompt**

```text
As a QA tester, list 5-10 test cases for this app: cover DB ops, API integrations, UI responsiveness on mobile, and error handling.
```

---

## Notes

This plan covers the exercise requirements, supports collaboration, uses your stack, and includes external APIs + Git workflow.

### Optional Unconventional Enhancement

Integrate Grok API directly into the app for real-time prompt suggestions:

- User inputs a rough idea
- Grok generates refined AI prompts on the fly
- Save generated prompts to DB

This adds AI capabilities without requiring an extra backend.