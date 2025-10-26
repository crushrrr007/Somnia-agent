# Somnia Workflow Platform - Deployment Guide

Complete guide for deploying the Somnia Workflow Automation Platform on Somnia Testnet for the AI Hackathon.

## Prerequisites

### 1. Required Accounts & API Keys

- [ ] **GitHub Account** (for repository)
- [ ] **Clerk Account** (authentication) - https://clerk.com/
- [ ] **Google AI Account** (Gemini API) - https://ai.google.dev/
- [ ] **OpenAI Account** (GPT-4) - https://platform.openai.com/
- [ ] **PostgreSQL Database** (local or cloud)
- [ ] **Somnia Testnet Wallet** with STT tokens

### 2. Software Requirements

```bash
Node.js >= 18.0.0
PostgreSQL >= 14
Git
Yarn or npm
```

---

## Part 1: Local Development Setup

### Step 1: Clone Repository

```bash
git clone https://github.com/crushrrr007/Somnia-agent.git
cd Somnia-agent
```

### Step 2: Install Dependencies

```bash
# Install main app dependencies
yarn install

# Install contract dependencies
cd contracts
npm install
cd ..
```

### Step 3: Configure Environment

```bash
# Copy example environment file
cp .env.example .env
```

Edit `.env` with your credentials:

```env
# Database
DATABASE_URL="postgresql://username:password@localhost:5432/somnia_agent"

# Clerk (get from https://dashboard.clerk.com/)
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY="pk_test_..."
CLERK_SECRET_KEY="sk_test_..."

# AI APIs
GOOGLE_GENERATIVE_AI_API_KEY="your-gemini-key"
OPENAI_API_KEY="sk-your-openai-key"

# Security (generate these)
ENCRYPTION_KEY="$(openssl rand -hex 16)"
API_SECRET="$(openssl rand -base64 32)"

# Optional: DeFi Plugin APIs
COINGECKO_API_KEY="your-key"
BIRDEYE_API_KEY="your-key"
ONEINCH_API_KEY="your-key"

# For contract deployment
DEPLOYER_PRIVATE_KEY="your-wallet-private-key"
```

### Step 4: Setup Database

```bash
# Generate Prisma client
npx prisma generate

# Push schema to database
npx prisma db push

# (Optional) Seed with sample data
npx prisma db seed
```

### Step 5: Run Development Server

```bash
yarn dev
```

Visit http://localhost:3000

---

## Part 2: Somnia Testnet Setup

### Step 1: Get Somnia Testnet Wallet

1. Install MetaMask (if not already installed)
2. Add Somnia Testnet network:
   - **Network Name**: Somnia Testnet
   - **RPC URL**: https://dream-rpc.somnia.network
   - **Chain ID**: 50312
   - **Currency Symbol**: STT
   - **Block Explorer**: https://shannon-explorer.somnia.network

Or use this quick add link: https://chainlist.org/chain/50312

### Step 2: Get STT Test Tokens

1. Visit: https://testnet.somnia.network/
2. Enter your wallet address
3. Request STT tokens (for gas and testing)
4. Wait for confirmation

### Step 3: Setup Wallet in Platform

1. Log into the platform at http://localhost:3000
2. Navigate to **Credentials** page
3. Click **Add Credential**
4. Add your wallet:
   - **Name**: "My Somnia Wallet"
   - **Type**: Private Key
   - **Value**: Your wallet private key (encrypted automatically)

---

## Part 3: Smart Contract Deployment

### Step 1: Deploy Marketplace Contract

```bash
cd contracts

# Deploy to Somnia Testnet
npm run deploy:testnet
```

**Expected Output:**
```
🚀 Starting WorkflowMarketplace deployment...
📡 Network: somniaTestnet
⛓️  Chain ID: 50312
👤 Deployer address: 0x...
💰 Deployer balance: 10.0 STT

📝 Deploying WorkflowMarketplace contract...
✅ WorkflowMarketplace deployed to: 0xYourContractAddress...

📊 Contract Configuration:
   Platform Wallet: 0x...
   Platform Fee: 5%

💾 Deployment info saved to: deployment.json
🎉 Deployment completed successfully!
```

### Step 2: Save Contract Address

Copy the contract address and add to `.env`:

```env
NEXT_PUBLIC_MARKETPLACE_CONTRACT_ADDRESS="0xYourContractAddress"
```

### Step 3: Verify Contract (Optional)

```bash
npx hardhat verify --network somniaTestnet 0xYourContractAddress
```

### Step 4: View on Explorer

Visit: https://shannon-explorer.somnia.network/address/0xYourContractAddress

---

## Part 4: Create Demo Workflows

### Demo Workflow 1: Price Monitoring Bot

**Purpose**: Monitor token prices and send alerts

**Steps**:
1. Go to **Workflows** → **Create New**
2. Add tasks:
   - **AGENT** task
     - System Prompt: "You are a price monitoring agent"
     - Prompt: "Check the current price of Ethereum"
     - Chain: Somnia Testnet (50312)
     - Wallet: Select your credential
     - Plugins: CoinGecko
   - **TELEGRAM** task (connected from AGENT output)
     - Bot Token: Your telegram bot token (credential)
     - Chat ID: Your chat ID
     - Message: Connect from AGENT "Response" output
3. **Publish** the workflow
4. Set **Cron**: `*/5 * * * *` (every 5 minutes)
5. **Test Run**

### Demo Workflow 2: DeFi Portfolio Agent

**Purpose**: AI agent that analyzes portfolio and executes swaps

**Steps**:
1. Create new workflow
2. Add tasks:
   - **INPUT_TEXT** task
     - Label: "Wallet Address"
   - **AGENT** task
     - System Prompt: "You are a DeFi portfolio analyst"
     - Prompt: "Analyze wallet {Wallet Address} and suggest optimal portfolio allocation"
     - Chain: Somnia Testnet
     - Plugins: Birdeye, CoinGecko, 1inch
   - **DELIVER_VIA_WEBHOOK** task
     - Webhook URL: Your webhook endpoint
     - Body: Connect from AGENT "Response"
3. **Publish** and test

### Demo Workflow 3: Web Scraping to Blockchain

**Purpose**: Scrape data and store on-chain

**Steps**:
1. Create new workflow
2. Add tasks:
   - **LAUNCH_BROWSER** (Entry point)
     - URL: "https://example.com/crypto-prices"
   - **EXTRACT_TEXT_FROM_ELEMENT**
     - Selector: ".price-container"
   - **EXTRACT_DATA_WITH_AI**
     - Content: Connect from previous output
     - Instructions: "Extract token prices as JSON"
   - **AGENT** task
     - Prompt: "Store this price data on-chain: {JSON}"
     - Chain: Somnia Testnet
3. **Publish** workflow
4. Set webhook trigger
5. Test via API call

---

## Part 5: Production Deployment

### Option A: Deploy to Vercel

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy
vercel
```

**Configure Environment Variables in Vercel:**
1. Go to Project Settings → Environment Variables
2. Add all variables from `.env`
3. Redeploy

### Option B: Deploy to Custom Server

```bash
# Build production bundle
yarn build

# Start production server
yarn start
```

**Use PM2 for process management:**
```bash
npm install -g pm2
pm2 start npm --name "somnia-agent" -- start
pm2 save
```

---

## Part 6: Testing Checklist

### Functional Tests

- [ ] User can sign up and log in
- [ ] User can create workflows in visual editor
- [ ] User can add Somnia wallet credentials
- [ ] Workflows validate correctly
- [ ] Workflows execute on Somnia testnet
- [ ] AI agents can call DeFi plugins
- [ ] Transactions appear on Somnia Explorer
- [ ] Cron jobs trigger automatically
- [ ] Webhook triggers work
- [ ] Marketplace contract interaction works

### Integration Tests

- [ ] Agent can swap tokens on Somnia (if DEX available)
- [ ] Agent can check prices via CoinGecko
- [ ] Browser automation works
- [ ] Telegram integration works
- [ ] Webhook delivery works
- [ ] Credits are deducted correctly
- [ ] Execution logs are captured

---

## Part 7: Hackathon Submission

### Required Deliverables

1. **GitHub Repository** ✅
   - Public repository
   - Minimum 2 commits
   - Detailed README
   - Open-source license (MIT)

2. **Deployed dApp** ✅
   - Working on Somnia Testnet
   - Accessible URL

3. **Contract Addresses** ✅
   - WorkflowMarketplace: `0x...` (from deployment.json)
   - Add to README.md

4. **Demo Video** (≤5 minutes)
   - See DEMO_VIDEO_SCRIPT.md
   - Upload to YouTube/Loom
   - Add link to README

5. **Pitch Deck** (5-10 slides)
   - See PITCH_DECK.md for outline
   - Export as PDF
   - Add to repository

### Contract Addresses to Document

After deployment, add to README.md:

```markdown
## Deployed Contracts (Somnia Testnet)

- **WorkflowMarketplace**: `0xYourContractAddress`
- **Network**: Somnia Testnet (Chain ID: 50312)
- **Explorer**: https://shannon-explorer.somnia.network/address/0xYourContractAddress
```

---

## Troubleshooting

### Database Connection Issues

```bash
# Check PostgreSQL is running
sudo systemctl status postgresql

# Create database if doesn't exist
createdb somnia_agent
```

### Prisma Errors

```bash
# Reset database
npx prisma migrate reset

# Regenerate client
npx prisma generate
```

### Contract Deployment Fails

**Issue**: Insufficient funds
```bash
# Check balance
# Visit faucet: https://testnet.somnia.network/
```

**Issue**: Gas estimation failed
```bash
# Try increasing gas limit in hardhat.config.js
gas: 5000000
```

### RPC Connection Issues

```bash
# Test RPC endpoint
curl -X POST https://dream-rpc.somnia.network \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'
```

### AI Agent Not Working

1. Check API keys are valid
2. Verify credentials are encrypted correctly
3. Check wallet has STT tokens
4. Review execution logs in UI

---

## Performance Optimization

### For Production

1. **Enable caching**:
```typescript
// In next.config.mjs
module.exports = {
  swcMinify: true,
  compress: true,
}
```

2. **Database indexing**:
```sql
CREATE INDEX idx_workflow_userid ON "Workflow"("userId");
CREATE INDEX idx_execution_workflowid ON "WorkflowExecution"("workflowId");
```

3. **CDN for static assets**:
- Use Vercel Edge Network
- Or configure Cloudflare CDN

---

## Security Best Practices

### Production Checklist

- [ ] Rotate all API keys
- [ ] Use strong ENCRYPTION_KEY (32+ characters)
- [ ] Enable Clerk production mode
- [ ] Set up rate limiting
- [ ] Enable CORS properly
- [ ] Use environment-specific RPC URLs
- [ ] Never commit .env file
- [ ] Use secrets management (Vercel/AWS Secrets Manager)
- [ ] Enable 2FA on all accounts
- [ ] Regular security audits

---

## Monitoring & Maintenance

### Setup Monitoring

1. **Vercel Analytics** (if using Vercel)
2. **Sentry** for error tracking
3. **LogRocket** for user sessions
4. **Database monitoring** via Prisma Pulse

### Backup Strategy

```bash
# Backup database daily
pg_dump somnia_agent > backup_$(date +%Y%m%d).sql

# Backup to cloud storage
aws s3 cp backup_$(date +%Y%m%d).sql s3://your-bucket/
```

---

## Support & Resources

- **Somnia Docs**: https://docs.somnia.network/
- **Telegram**: https://t.me/+XHq0F0JXMyhmMzM0
- **Somnia Faucet**: https://testnet.somnia.network/
- **Somnia Explorer**: https://shannon-explorer.somnia.network
- **GitHub Issues**: https://github.com/crushrrr007/Somnia-agent/issues

---

## Quick Reference

### Important URLs

| Service | URL |
|---------|-----|
| App (Local) | http://localhost:3000 |
| Somnia RPC | https://dream-rpc.somnia.network |
| Somnia Explorer | https://shannon-explorer.somnia.network |
| Somnia Faucet | https://testnet.somnia.network/ |
| ChainList | https://chainlist.org/chain/50312 |

### Important Commands

```bash
# Development
yarn dev                    # Start dev server
yarn build                  # Build for production
yarn start                  # Start production server

# Database
npx prisma generate         # Generate Prisma client
npx prisma db push          # Push schema changes
npx prisma studio           # Open database GUI

# Contracts
cd contracts
npm run deploy:testnet      # Deploy to Somnia testnet
npm run compile             # Compile contracts

# Git
git add .
git commit -m "message"
git push origin main
```

---

**Last Updated**: 2025-10-26
**Version**: 1.0.0
**For**: Somnia AI Hackathon (Sep 29 - Oct 28, 2025)
