# Quick Start Guide - Running the Project

This guide will help you get the Somnia Workflow Automation Platform running on your local machine.

---

## Prerequisites

Before starting, make sure you have these installed:

1. **Node.js** (v18 or higher)
   ```bash
   node --version  # Should be v18.0.0 or higher
   ```
   Download from: https://nodejs.org/

2. **Yarn** (package manager)
   ```bash
   npm install -g yarn
   yarn --version
   ```

3. **PostgreSQL** (database)
   ```bash
   psql --version  # Should be v14 or higher
   ```
   Download from: https://www.postgresql.org/download/

4. **Git** (version control)
   ```bash
   git --version
   ```

---

## Step 1: Clone the Repository

```bash
# Clone the project
git clone https://github.com/crushrrr007/Somnia-agent.git

# Navigate into the project
cd Somnia-agent
```

---

## Step 2: Install Dependencies

```bash
# Install all project dependencies
yarn install

# This will take 2-5 minutes
# You should see "success" at the end
```

---

## Step 3: Set Up Database

### Option A: Local PostgreSQL (Recommended for development)

**On Mac:**
```bash
# Install PostgreSQL via Homebrew
brew install postgresql@14

# Start PostgreSQL
brew services start postgresql@14

# Create database
createdb somnia_agent
```

**On Ubuntu/Linux:**
```bash
# Install PostgreSQL
sudo apt update
sudo apt install postgresql postgresql-contrib

# Start PostgreSQL
sudo systemctl start postgresql

# Create database
sudo -u postgres createdb somnia_agent
```

**On Windows:**
```bash
# Download installer from postgresql.org
# After installation, create database using pgAdmin or:
psql -U postgres
CREATE DATABASE somnia_agent;
\q
```

### Option B: Use a Cloud Database (Easier)

**Neon.tech** (Free tier available):
1. Go to https://neon.tech/
2. Sign up for free account
3. Create a new database
4. Copy the connection string

**Supabase** (Free tier available):
1. Go to https://supabase.com/
2. Create new project
3. Go to Settings → Database
4. Copy the connection string

---

## Step 4: Configure Environment Variables

### Create .env file

```bash
# Copy the example file
cp .env.example .env

# Open .env in your text editor
nano .env
# or
code .env
# or
vim .env
```

### Minimal Configuration (to get started quickly)

Edit `.env` and add these **required** values:

```env
# 1. DATABASE (REQUIRED)
DATABASE_URL="postgresql://username:password@localhost:5432/somnia_agent"
# If using Neon/Supabase, paste their connection string here

# 2. CLERK AUTHENTICATION (REQUIRED)
# Get free account at https://clerk.com/
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY="pk_test_your-key-here"
CLERK_SECRET_KEY="sk_test_your-key-here"

# 3. AI MODELS (REQUIRED)
# Get free key at https://ai.google.dev/
GOOGLE_GENERATIVE_AI_API_KEY="your-gemini-key-here"

# Get key at https://platform.openai.com/
OPENAI_API_KEY="sk-your-openai-key-here"

# 4. SECURITY (REQUIRED)
# Generate random strings:
ENCRYPTION_KEY="$(openssl rand -hex 16)"
API_SECRET="$(openssl rand -base64 32)"

# 5. APP URL (REQUIRED for local)
NEXT_PUBLIC_APP_URL="http://localhost:3000"
```

### Get Clerk API Keys (Free - Takes 5 minutes)

1. Go to https://clerk.com/
2. Sign up for free account
3. Create new application
4. Choose "Next.js" as framework
5. Copy the API keys and paste into `.env`

### Get Google Gemini API Key (Free)

1. Go to https://ai.google.dev/
2. Click "Get API Key"
3. Create new project or select existing
4. Copy key and paste into `.env`

### Get OpenAI API Key (Paid - but has free credits)

1. Go to https://platform.openai.com/
2. Sign up and add payment method
3. Go to API Keys section
4. Create new key
5. Copy and paste into `.env`

### Optional Keys (can skip for now)

These are optional - the app will work without them but some features will be limited:

```env
# DeFi Plugins (optional)
COINGECKO_API_KEY=""
BIRDEYE_API_KEY=""
ONEINCH_API_KEY=""

# Payments (optional - only if using marketplace)
STRIPE_SECRET_KEY=""
```

---

## Step 5: Set Up Database Schema

```bash
# Generate Prisma client
npx prisma generate

# Push database schema (creates all tables)
npx prisma db push

# You should see "Your database is now in sync with your schema"
```

**Optional:** Seed with sample data
```bash
npx prisma db seed
```

**Optional:** Open database GUI to view tables
```bash
npx prisma studio
# Opens at http://localhost:5555
```

---

## Step 6: Run the Development Server

```bash
# Start the Next.js development server
yarn dev

# You should see:
# ✓ Ready in X seconds
# ○ Local: http://localhost:3000
```

---

## Step 7: Access the Application

Open your browser and go to:

**http://localhost:3000**

You should see the landing page!

### First Time Setup

1. Click **Sign Up**
2. Create account via Clerk (email or OAuth)
3. You'll be redirected to the dashboard
4. Start creating workflows!

---

## Testing the Platform

### Test 1: Create a Simple Workflow

1. Go to **Workflows** → **Create New**
2. Name it "Test Workflow"
3. Drag an **INPUT_TEXT** task from the left panel
4. Click **Publish**
5. Click **Run**
6. Enter some text and see it work!

### Test 2: Test Somnia Integration

1. Go to **Credentials** page
2. Click **Add Credential**
3. Add a test wallet:
   - Name: "Test Wallet"
   - Value: A test private key (get from MetaMask)
4. Create new workflow with **AGENT** task
5. Select **Somnia Testnet (50312)** as chain
6. Add your credential
7. Try running it!

---

## Common Issues & Solutions

### Issue 1: "Port 3000 already in use"

```bash
# Kill the process using port 3000
# On Mac/Linux:
lsof -ti:3000 | xargs kill -9

# On Windows:
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Or use a different port:
PORT=3001 yarn dev
```

### Issue 2: "Database connection failed"

```bash
# Check PostgreSQL is running
# Mac:
brew services list

# Linux:
sudo systemctl status postgresql

# If not running, start it:
brew services start postgresql@14
# or
sudo systemctl start postgresql
```

### Issue 3: "Prisma client not generated"

```bash
# Regenerate Prisma client
npx prisma generate

# Then restart the dev server
yarn dev
```

### Issue 4: "Module not found" errors

```bash
# Delete node_modules and reinstall
rm -rf node_modules
yarn install

# Clear Next.js cache
rm -rf .next

# Restart
yarn dev
```

### Issue 5: Clerk authentication not working

1. Check `.env` has correct Clerk keys
2. Make sure keys start with `pk_test_` and `sk_test_`
3. Restart dev server after adding keys
4. Clear browser cookies and try again

### Issue 6: "Cannot find module 'next'"

```bash
# Install missing dependencies
yarn install

# If still fails, try:
rm yarn.lock
yarn install
```

---

## Project Structure Overview

```
Somnia-agent/
├── app/                    # Next.js pages & routes
│   ├── (auth)/            # Login/signup pages
│   ├── (dashboard)/       # Main dashboard pages
│   ├── workflow/          # Workflow editor
│   └── api/               # API endpoints
├── lib/                   # Core business logic
│   ├── workflow/          # Workflow execution engine
│   ├── goat-plugins/      # DeFi integrations
│   └── chains.ts          # Blockchain configs (Somnia here!)
├── components/            # Reusable UI components
├── prisma/                # Database schema
│   └── schema.prisma      # Database models
├── contracts/             # Smart contracts
│   └── WorkflowMarketplace.sol
├── types/                 # TypeScript types
└── public/                # Static assets
```

---

## Development Workflow

### Making Changes

1. **Edit code** in your favorite editor (VS Code recommended)
2. **Save files** - Next.js will auto-reload
3. **Check browser** - changes appear instantly
4. **Check terminal** - for any errors

### Viewing Database

```bash
# Open Prisma Studio
npx prisma studio

# View/edit data at http://localhost:5555
```

### Running Database Migrations

```bash
# After changing schema.prisma:
npx prisma db push

# Or create a migration:
npx prisma migrate dev --name your-change-name
```

---

## Useful Commands Cheat Sheet

```bash
# Development
yarn dev              # Start dev server
yarn build            # Build for production
yarn start            # Run production build
yarn lint             # Check for errors

# Database
npx prisma studio     # Open database GUI
npx prisma generate   # Generate Prisma client
npx prisma db push    # Update database schema
npx prisma db seed    # Seed with sample data

# Contracts (if deploying)
cd contracts
npm install           # Install contract dependencies
npm run compile       # Compile contracts
npm run deploy:testnet # Deploy to Somnia testnet

# Git
git status            # Check changes
git add .             # Stage all changes
git commit -m "msg"   # Commit changes
git push              # Push to GitHub
```

---

## Next Steps After Running Locally

### 1. Explore the Platform
- Create workflows
- Test AI agents
- Try different task types
- Explore the marketplace

### 2. Get Somnia Testnet Tokens
- Visit: https://testnet.somnia.network/
- Request STT tokens for testing
- Add wallet to credentials page

### 3. Deploy Smart Contract
```bash
cd contracts
npm install
npm run deploy:testnet
```

### 4. Create Demo Workflows
- Follow examples in DEPLOYMENT_GUIDE.md
- Test on Somnia testnet
- Share with community!

---

## Getting Help

### Documentation
- `README.md` - Project overview
- `ARCHITECTURE.md` - Technical details
- `DEPLOYMENT_GUIDE.md` - Production deployment
- `HACKATHON_SUBMISSION.md` - Submission checklist

### Community Support
- **Somnia Telegram**: https://t.me/+XHq0F0JXMyhmMzM0
- **GitHub Issues**: https://github.com/crushrrr007/Somnia-agent/issues

### Debug Mode

If something isn't working, check:
1. Terminal output for errors
2. Browser console (F12) for errors
3. Network tab in DevTools for failed requests
4. Database with `npx prisma studio`

---

## Quick Troubleshooting Checklist

- [ ] Node.js v18+ installed?
- [ ] PostgreSQL running?
- [ ] `.env` file created with all keys?
- [ ] `yarn install` completed successfully?
- [ ] `npx prisma generate` ran successfully?
- [ ] `npx prisma db push` completed?
- [ ] Port 3000 not in use?
- [ ] Clerk keys are correct?
- [ ] API keys are valid?

If all checked, it should work! 🚀

---

## Video Tutorial (Coming Soon)

We'll create a video walkthrough showing:
1. Installation from scratch
2. Configuration
3. Creating first workflow
4. Deploying to Somnia testnet

---

**Happy coding!** 🎉

If you get stuck, don't hesitate to ask for help!
