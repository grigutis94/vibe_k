Here is a step-by-step plan to build the VibeHub app. We based it on your group exercise and tech stack - Mac, Node.js, Cursor Pro (Grok-powered), Nuxt/Vue, Nuxt UI, Grok API, GitHub, and Vercel. The plan includes AI agent prompts you can use in tools like Cursor Pro or Grok to speed up tasks. We assume a two-person team (you as Edvinas and a collaborator). Follow these steps in order.
Step 1: Agree on Tech Stack and Overall Architecture
Discuss and finalise tools to ensure everyone aligns. Use Nuxt/Vue for the frontend, Supabase for the database (easy SDK for client-side ops), and the specified external APIs.
AI Agent Prompt: "As a Vue/Nuxt expert, suggest a simple architecture for a two-page app (Prompts and Tools sections) using Nuxt 3, Nuxt UI for components, and Supabase for real-time data. Include basic routing and a shared navbar. Output in bullet points with code snippets for setup."
Step 2: Divide Tasks Between Team Members
Split work as per the exercise: Person A (e.g., you) handles Prompts section with avatars; Person B handles Tools section with jokes/tips. Both contribute to shared elements like navbar.
Assign roles via quick call or chat.
AI Agent Prompt: "Act as a project manager for a small dev team. Based on this app description [paste exercise details], divide tasks into two roles (A for Prompts, B for Tools). List responsibilities, including DB tables, UI, API integrations, and Git branches. Suggest how to handle shared code like navbar to avoid conflicts."
Step 3: Set Up the GitHub Repository
One person creates the repo. Add collaborators, include a .gitignore for Node.js (ignore node_modules, .env, etc.).
Use GitHub's web interface or CLI on your Mac.
AI Agent Prompt: "Generate a .gitignore file for a Nuxt.js project using Node.js, Supabase, and Vercel. Include common ignores for logs, builds, and env files. Also, provide Git commands to init the repo, add remote, and invite a collaborator."
Step 4: Clone Repo and Create Development Branch
Both team members clone the repo. Create a 'dev' branch from main for ongoing work.
Commands: git clone [repo-url]; git checkout -b dev; git push origin dev.
AI Agent Prompt: "As a Git expert, list step-by-step commands for two devs to clone a GitHub repo, create a dev branch, and set it as default. Include tips for resolving common clone issues on Mac with Node.js."
Step 5: Initialise the Project Base
In the dev branch, set up the core Nuxt project with navbar and routing.
Use npx nuxi init to start, add Nuxt UI via yarn add @nuxt/ui.
Create pages: /prompts and /tools, plus a layout with navbar.
Commit and push to dev.
AI Agent Prompt: "Using Nuxt 3 and Nuxt UI, generate code for a basic app setup: install dependencies, create a navbar component with links to /prompts and /tools, and set up routing. Provide full code files like app.vue and layouts/default.vue."
Step 6: Create Feature Branches and Build Individually
Each person checks out from dev, creates their feature branch (e.g., feature/prompts, feature/tools), and builds their section.
For Prompts: Connect Supabase table (prompts: name, prompt_text), build form and list UI, fetch avatars from DiceBear API.
For Tools: Connect Supabase table (tools: title, url, description), build form and list UI, fetch jokes from JokeAPI.
Use fetch() for APIs; test locally.
AI Agent Prompt (for Prompts): "In Nuxt/Vue, write code for a Prompts page: connect to Supabase to create/insert into 'prompts' table (fields: name, prompt_text), display list with auto-generated avatars from DiceBear API using user name as seed. Include form component with Nuxt UI."
AI Agent Prompt (for Tools): "In Nuxt/Vue, code a Tools page: use Supabase to manage 'tools' table (title, url, description), show card list, add form for new entries. Fetch and display a random programming joke from JokeAPI at the top on page load."
Step 7: Test Locally and Commit
Run the app locally (yarn dev), test forms, DB saves, API fetches, and navigation.
Fix bugs before pushing.
AI Agent Prompt: "Suggest debugging steps for a Nuxt app with Supabase and external APIs. Focus on common errors like CORS, auth, or fetch failures. Include console.log examples."
Step 8: Create Pull Requests to Dev Branch
Push feature branches, open PRs to dev. Review each other's code, test merges locally.
Resolve conflicts (e.g., in shared files like routes or layouts) via git merge/rebase.
AI Agent Prompt: "Explain how to resolve Git merge conflicts in a Nuxt project, especially for shared Vue components. Provide example commands and a sample conflict resolution in code."
Step 9: Merge to Dev and Test Together
Approve and merge PRs to dev. Both pull updates, test the full app.
Connect to Vercel for preview deploys on dev pushes.
AI Agent Prompt: "Guide setting up Vercel for a Nuxt app from GitHub. Include steps for env vars (e.g., Supabase keys) and auto-deploys on dev branch."
Step 10: Final PR to Main and Deploy
Once dev works, create a PR from dev to main. Merge after final checks.
Vercel auto-deploys to production.
Verify: Data saves/shows, APIs work, at least 4 functionalities (forms, lists, navigations, API displays).
AI Agent Prompt: "As a QA tester, list 5-10 test cases for this app: cover DB ops, API integrations, UI responsiveness on mobile, and error handling."
This plan covers your exercise fully. It ensures collaboration, uses your stack, and hits the criteria like external APIs and Git workflow.
As an unconventional solution, integrate Grok API directly into the app for real-time prompt suggestions - users input a rough idea, and Grok generates refined AI prompts on the fly, stored in DB. This adds AI smarts without extra backend.