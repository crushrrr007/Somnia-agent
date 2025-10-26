# Somnia Workflow Automation Platform

> An AI-powered, blockchain-integrated workflow automation platform for the Somnia AI Hackathon

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Next.js](https://img.shields.io/badge/Next.js-14-black)
![TypeScript](https://img.shields.io/badge/TypeScript-5-blue)

## Overview

**Somnia Agent** is an advanced workflow automation platform that enables users to create visual, no-code workflows combining AI agents, blockchain interactions, and web automation. Built for the Somnia AI Hackathon, it demonstrates the power of autonomous on-chain AI agents.

### Key Features

- **Visual Workflow Editor**: Drag-and-drop interface for creating complex automation workflows
- **AI-Powered Agents**: Google Gemini 2.0 Flash agents with access to 23+ DeFi tools
- **Multi-Chain Support**: 20+ EVM-compatible blockchains + NEAR Protocol
- **Browser Automation**: Puppeteer-powered web scraping and interaction
- **DeFi Integration**: GOAT SDK plugins for swaps, lending, NFTs, and more
- **Flexible Triggers**: Manual execution, cron scheduling, or webhook triggers
- **Marketplace**: Buy/sell workflows with on-chain payments
- **Safe Wallet Support**: Multi-signature transaction execution

---

## Quick Start

### Prerequisites

- Node.js 18+ or Bun
- PostgreSQL database
- Clerk account (for authentication)
- OpenAI API key
- Google AI API key

### Installation

```bash
# Clone the repository
git clone https://github.com/crushrrr007/Somnia-agent.git
cd Somnia-agent

# Install dependencies
yarn install
# or
npm install

# Set up environment variables
cp .env.example .env
# Edit .env with your configuration
```

### Environment Variables

Create a `.env` file with:

```env
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/somnia_agent"

# Clerk Authentication
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY="pk_test_..."
CLERK_SECRET_KEY="sk_test_..."

# AI Models
GOOGLE_GENERATIVE_AI_API_KEY="..."
OPENAI_API_KEY="sk-..."

# DeFi Plugins (Optional)
COINGECKO_API_KEY="..."
BIRDEYE_API_KEY="..."
ONEINCH_API_KEY="..."

# Security
ENCRYPTION_KEY="your-32-character-encryption-key"
API_SECRET="your-api-secret-for-webhooks"

# Stripe (Optional)
STRIPE_SECRET_KEY="sk_test_..."
STRIPE_WEBHOOK_SECRET="whsec_..."
```

### Database Setup

```bash
# Generate Prisma client
npx prisma generate

# Push schema to database
npx prisma db push

# Seed database (optional)
npx prisma db seed
```

### Run Development Server

```bash
yarn dev
# or
npm run dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) to see the app.

---

## Architecture

### Technology Stack

- **Frontend**: Next.js 14, React 18, TypeScript
- **UI**: Radix UI, TailwindCSS, XYFlow (React Flow)
- **Backend**: Next.js Server Actions, API Routes
- **Database**: PostgreSQL with Prisma ORM
- **AI**: Google Gemini 2.0 Flash, OpenAI GPT-4o-mini
- **Blockchain**: Viem, GOAT SDK, NEAR Protocol
- **Authentication**: Clerk
- **Payments**: Stripe
- **Automation**: Puppeteer

### Core Components

1. **Workflow Engine**: Phase-based execution with credit tracking
2. **AI Agents**: Autonomous DeFi agents powered by Gemini
3. **Task Executors**: 17 task types from browser automation to blockchain interactions
4. **Plugin System**: 23+ DeFi integrations via GOAT SDK
5. **Marketplace**: Workflow sharing with on-chain payments

See [ARCHITECTURE.md](./ARCHITECTURE.md) for detailed documentation.

---

## Task Types

### Browser Automation (8 tasks)
- Launch Browser
- Navigate URL
- Fill Input
- Click Element
- Wait for Element
- Scroll to Element
- Extract Text
- Page to HTML

### Data Processing (4 tasks)
- Input Text
- Extract Data with AI
- Add Property to JSON
- Read Property from JSON

### Integration (3 tasks)
- Deliver via Webhook
- Telegram
- Telegram Agent

### AI & DeFi (2 tasks)
- Agent (DeFi operations)
- Agent with Safe Wallet (Multi-sig)

---

## Supported Blockchains

### Mainnet
- Ethereum
- Base
- Arbitrum
- Polygon
- Optimism
- Avalanche
- Celo
- Linea
- Gnosis
- Sei

### Testnet
- Sepolia
- Base Sepolia
- Arbitrum Sepolia
- Polygon Mumbai
- Optimism Sepolia
- Avalanche Fuji
- Celo Alfajores
- Linea Sepolia
- And more...

### Special Integrations
- **NEAR Protocol**: Custom plugin with Ref Finance swaps
- **Cross-chain**: Defuse Protocol for NEAR ↔ EVM bridging

---

## DeFi Plugins (GOAT SDK)

Available integrations:
- **DEX**: Jupiter, 1inch, 0x, Uniswap, Orca, KIM, Avnu
- **Analytics**: CoinGecko, Birdeye, CoinMarketCap, Dexscreener
- **Lending**: Lulo, Ionic, Ironclad
- **NFTs**: ERC721, ERC1155, OpenSea, Crossmint
- **Social**: Farcaster
- **Governance**: Mode Voting

---

## Usage Examples

### Example 1: Price Monitoring Bot

Create a workflow that:
1. Checks token price via CoinGecko plugin
2. Sends Telegram alert if threshold crossed
3. Runs every 5 minutes via cron

### Example 2: Automated Trading

Create a workflow that:
1. Monitors mempool for opportunities
2. AI agent analyzes with market data plugins
3. Executes swap via 1inch if profitable
4. Logs results to webhook

### Example 3: NFT Minting Automation

Create a workflow that:
1. Scrapes NFT project website for mint status
2. Extracts mint data with AI
3. Executes mint transaction when live
4. Notifies via Telegram

---

## API Endpoints

### Workflow Execution

```bash
# Manual Execution
GET /api/workflows/execute?workflowId=xxx&executionId=yyy
Authorization: Bearer YOUR_API_SECRET

# Webhook Trigger
POST /api/workflows/webhook?key=xxx&workflowId=yyy
Content-Type: application/json
{ "your": "data" }

# Cron Trigger (automated)
GET /api/workflows/cron
Authorization: Bearer YOUR_API_SECRET
```

### Marketplace

```bash
# Get marketplace listings
GET /api/workflows?search=...&category=...&sortBy=...

# Create listing
POST /api/workflows/marketplace
Authorization: Bearer (Clerk token)
```

---

## Somnia AI Hackathon Submission

### Hackathon Track: Infra Agents

This project is built for the **Somnia AI Hackathon** (Sep 29 - Oct 28, 2025) in the **Infra Agents** track.

### Why Infra Agents?

Our platform provides infrastructure for developers to build AI agents without coding:
- Visual workflow builder (SDK-like platform)
- 17 pre-built task types
- 23+ DeFi plugin integrations
- Multi-chain support (21 networks)
- On-chain marketplace for sharing workflows

### Submission Status

- [x] Public GitHub repository
- [x] Minimum 2 commits (3+ commits)
- [x] Detailed README
- [x] Open-source license (MIT)
- [x] Somnia Testnet integration complete
- [ ] Smart contract deployed (ready to deploy)
- [ ] Demo video (script ready)
- [ ] Pitch deck (outline ready)

See [HACKATHON_SUBMISSION.md](./HACKATHON_SUBMISSION.md) for complete checklist.

### Somnia Blockchain Integration

**Somnia Testnet (Shannon) is now fully integrated!**

**Network Details:**
- **Chain ID**: 50312
- **RPC URL**: https://dream-rpc.somnia.network
- **Explorer**: https://shannon-explorer.somnia.network
- **Symbol**: STT
- **Faucet**: https://testnet.somnia.network/

**Integration Status:**
- ✅ Somnia chain added to `/lib/chains.ts`
- ✅ Available in workflow editor chain selector
- ✅ AI agents can execute on Somnia testnet
- ✅ Wallet credentials support Somnia
- ✅ All DeFi plugins compatible with Somnia

### Deployed Smart Contracts

**WorkflowMarketplace** (Ready for deployment)
- **Contract**: `contracts/WorkflowMarketplace.sol`
- **Network**: Somnia Testnet (Chain ID: 50312)
- **Address**: [To be added after deployment]
- **Explorer**: [To be added after deployment]
- **Features**: On-chain workflow marketplace, STT payments, revenue sharing

**Deploy Instructions:**
```bash
cd contracts
npm install
npm run deploy:testnet
```

See [contracts/README.md](./contracts/README.md) for details.

---

## Development

### Project Structure

```
/
├── app/                    # Next.js pages
│   ├── (auth)/             # Authentication
│   ├── (dashboard)/        # Main dashboard
│   ├── workflow/           # Editor & runs
│   └── api/                # API routes
├── lib/                    # Core logic
│   ├── workflow/           # Execution engine
│   ├── goat-plugins/       # DeFi plugins
│   └── near-plugin/        # NEAR integration
├── actions/                # Server actions
├── components/             # UI components
├── prisma/                 # Database
└── types/                  # TypeScript types
```

### Key Files

- `/lib/workflow/executeWorkflow.ts` - Execution orchestrator
- `/lib/workflow/executor/AgentExecutor.ts` - AI agent logic
- `/lib/chains.ts` - Blockchain configs
- `/prisma/schema.prisma` - Database schema

### Commands

```bash
# Development
yarn dev

# Build
yarn build
yarn start

# Database
npx prisma generate
npx prisma db push
npx prisma studio

# Linting
yarn lint
```

---

## Security

- **Authentication**: Clerk OAuth + email
- **Credential Encryption**: AES-256-CBC for private keys
- **API Protection**: Bearer token authentication
- **User Isolation**: All queries scoped by userId

---

## Credits & Pricing

| Task | Credits |
|------|---------|
| Launch Browser | 5 |
| Agent (DeFi) | 2 |
| Agent (Safe) | 2 |
| Others | 0 |

---

## Deployment

### Vercel (Recommended)

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel
```

### Docker

```dockerfile
# Coming soon
```

---

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push and create a Pull Request

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Support

- **Telegram**: [Somnia Hackathon Group](https://t.me/+XHq0F0JXMyhmMzM0)
- **Issues**: [GitHub Issues](https://github.com/crushrrr007/Somnia-agent/issues)

---

## Acknowledgments

- Built for the [Somnia AI Hackathon](https://somnia.network)
- Powered by [GOAT SDK](https://github.com/goat-sdk)
- AI models by Google Gemini and OpenAI
- Blockchain infrastructure by Viem

---

## Screenshots

### Visual Workflow Editor
![Editor](docs/editor.png)

### AI Agent Configuration
![Agent](docs/agent.png)

### Execution Dashboard
![Dashboard](docs/dashboard.png)

---

Made with ❤️ for the Somnia AI Hackathon
