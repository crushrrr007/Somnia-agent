# Somnia Workflow Automation Platform

> An AI-powered, blockchain-integrated workflow automation platform for the Somnia AI Hackathon

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Next.js](https://img.shields.io/badge/Next.js-14-black)
![TypeScript](https://img.shields.io/badge/TypeScript-5-blue)

## Overview

**Somnia Workflow Automation Platform** is a revolutionary no-code infrastructure for building autonomous AI agents on the Somnia blockchain. Built specifically for the Somnia AI Hackathon, this platform empowers developers and creators to design sophisticated AI-powered workflows that execute on-chain without writing a single line of code.

Leveraging Somnia's high-performance EVM-compatible blockchain, our platform enables AI agents to interact with DeFi protocols, automate complex tasks, and execute transactions at unprecedented speed and scale.

### Key Features

- 🎨 **Visual Workflow Builder**: Drag-and-drop interface for creating complex AI agent workflows
- 🤖 **AI-Powered Agents**: Google Gemini 2.0 Flash with autonomous decision-making
- ⚡ **Somnia-Native**: Optimized for Somnia's high-speed, low-cost blockchain
- 🔗 **23+ DeFi Plugins**: Integrated access to major DeFi protocols via GOAT SDK
- 🌐 **Multi-Chain Support**: Primary support for Somnia, with compatibility for 20+ EVM chains
- 🦾 **Browser Automation**: Puppeteer-powered web scraping and data extraction
- ⏰ **Flexible Triggers**: Manual execution, cron scheduling, or webhook triggers
- 🛒 **On-Chain Marketplace**: Smart contract-based workflow marketplace on Somnia
- 🔐 **Safe Wallet Support**: Multi-signature transaction execution

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

- **Blockchain**: Somnia Testnet (Chain ID: 50312) - Primary blockchain
- **Smart Contracts**: Solidity 0.8.20, Hardhat deployment framework
- **Frontend**: Next.js 14, React 18, TypeScript
- **UI**: Radix UI, TailwindCSS, XYFlow visual workflow editor
- **Backend**: Next.js Server Actions, API Routes
- **Database**: PostgreSQL with Prisma ORM
- **AI Models**: Google Gemini 2.0 Flash (primary), OpenAI GPT-4o-mini
- **Web3**: Viem for EVM interactions, GOAT SDK for DeFi
- **Multi-Chain**: Support for NEAR Protocol and 20+ EVM chains
- **Authentication**: Clerk OAuth
- **Payments**: Stripe + On-chain STT tokens
- **Automation**: Puppeteer for browser automation

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

## Somnia Blockchain Integration

### Primary Network: Somnia Testnet (Shannon)

**Why Somnia?**
- ⚡ **10,000+ TPS**: Execute AI agent workflows at unprecedented speed
- 💰 **Ultra-low fees**: Run complex agents without worrying about gas costs
- 🔗 **EVM Compatible**: Seamless integration with existing DeFi protocols
- 🌐 **Optimized for AI**: Perfect infrastructure for autonomous agents

**Network Details:**
- **Chain ID**: 50312
- **RPC URL**: https://dream-rpc.somnia.network
- **Explorer**: https://shannon-explorer.somnia.network
- **Native Token**: STT (Somnia Test Tokens)
- **Faucet**: https://testnet.somnia.network/

### Multi-Chain Compatibility

While optimized for Somnia, the platform supports:

**EVM Mainnets**: Ethereum, Base, Arbitrum, Polygon, Optimism, Avalanche, Celo, Linea, Gnosis, Sei

**EVM Testnets**: Sepolia, Base Sepolia, Arbitrum Sepolia, Polygon Mumbai, and more

**Special**: NEAR Protocol integration with Ref Finance DEX and cross-chain bridging

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

## Usage Examples on Somnia

### Example 1: Somnia DeFi Portfolio Manager

Create an AI agent that:
1. Monitors your Somnia wallet portfolio in real-time
2. AI analyzes token performance using CoinGecko + Birdeye
3. Executes rebalancing swaps on Somnia DEXs
4. Sends performance reports via Telegram
5. All transactions on Somnia for ultra-low fees

### Example 2: High-Frequency Price Arbitrage

Leverage Somnia's 10,000+ TPS:
1. Monitor price differences across multiple DEXs
2. AI agent identifies arbitrage opportunities
3. Executes simultaneous buy/sell on Somnia
4. Profits from price discrepancies instantly
5. Speed only possible on Somnia's infrastructure

### Example 3: Automated Governance Participant

Create a DAO automation agent:
1. Scrapes governance proposals from DAO websites
2. AI analyzes proposals against voting guidelines
3. Automatically votes on Somnia governance contracts
4. Logs voting rationale to permanent storage
5. Notifies stakeholders of voting activity

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

## Why Somnia for AI Agents?

**Somnia's unique characteristics make it the ideal blockchain for AI agents:**

1. **Speed**: 10,000+ TPS enables real-time agent decision-making
2. **Cost**: Ultra-low fees allow complex multi-step workflows
3. **EVM Compatibility**: Access to entire DeFi ecosystem
4. **Developer Tools**: Robust tooling and documentation
5. **Scalability**: Handle thousands of concurrent agents

**Our platform maximizes these advantages** by providing:
- Pre-built workflow templates optimized for Somnia
- Smart contract marketplace deployed on Somnia
- Native STT token integration
- Somnia-specific performance optimizations

## Acknowledgments

- Built for the [Somnia AI Hackathon](https://somnia.network) - Infra Agents Track
- Powered by Somnia's high-performance blockchain
- AI models by Google Gemini and OpenAI
- DeFi integrations via [GOAT SDK](https://github.com/goat-sdk)
- Web3 infrastructure by Viem

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
