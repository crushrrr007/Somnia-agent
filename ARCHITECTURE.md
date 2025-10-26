# Somnia Workflow Automation Platform - Architecture Documentation

## Project Overview

**Somnia Workflow Automation Platform** is a no-code infrastructure built specifically for the Somnia blockchain, enabling developers and creators to build autonomous AI agents without writing code. Created for the Somnia AI Hackathon (Infra Agents Track), this platform leverages Somnia's high-performance capabilities to enable:

- **AI-Powered DeFi Operations**: Autonomous agents executing on Somnia's 10,000+ TPS blockchain
- **Browser Automation**: Web scraping and data extraction integrated with on-chain actions
- **Multi-Chain Compatibility**: Primary support for Somnia with 20+ EVM chain compatibility
- **Real-Time Automation**: Telegram integration, webhooks, and cron scheduling
- **On-Chain Marketplace**: Smart contract deployed on Somnia for workflow trading

## Tech Stack

### Blockchain Layer
- **Primary**: Somnia Testnet (Chain ID: 50312, Shannon)
- **Smart Contracts**: Solidity 0.8.20, Hardhat deployment
- **Web3 Integration**: Viem for EVM interactions
- **DeFi Tools**: GOAT SDK with 23+ protocol plugins
- **Multi-Chain**: Support for NEAR Protocol and 20+ EVM chains

### Application Layer
- **Frontend**: Next.js 14, React 18, TypeScript
- **UI Components**: Radix UI, TailwindCSS, XYFlow (visual workflow editor)
- **Backend**: Next.js Server Actions, API Routes
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: Clerk OAuth
- **Payments**: Stripe + On-chain STT tokens

### AI & Automation
- **Primary AI**: Google Gemini 2.0 Flash (autonomous reasoning)
- **Secondary AI**: OpenAI GPT-4o-mini (data extraction)
- **Browser Automation**: Puppeteer
- **Workflow Engine**: Custom phase-based execution system

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                      USER INTERFACE                          │
│  (Next.js Dashboard, Visual Workflow Editor with XYFlow)    │
└───────────────────────┬─────────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────────┐
│                   WORKFLOW ENGINE                            │
│  - Execution Planning & Validation                           │
│  - Phase-based Sequential Execution                          │
│  - Environment & State Management                            │
│  - Credit/Billing System                                     │
└───────────┬─────────────┬──────────────┬────────────────────┘
            │             │              │
    ┌───────▼─────┐  ┌────▼──────┐  ┌───▼──────────┐
    │   Browser   │  │  AI Agent │  │ Integration  │
    │  Automation │  │ Executors │  │  Executors   │
    │  Executors  │  │           │  │              │
    │ (Puppeteer) │  │  (Gemini) │  │ (Webhook,    │
    └──────┬──────┘  └────┬──────┘  │  Telegram)   │
           │              │          └───┬──────────┘
           │              │              │
           │       ┌──────▼──────┐       │
           │       │   GOAT SDK  │       │
           │       │  (DeFi Tool │       │
           │       │  Integration)│      │
           │       └──────┬──────┘       │
           │              │              │
    ┌──────▼──────────────▼──────────────▼─────┐
    │        BLOCKCHAIN NETWORKS                │
    │  (20+ EVM Chains + NEAR Protocol)        │
    └──────────────────────────────────────────┘
```

---

## Core Components

### 1. Workflow System

**Definition Structure:**
```typescript
Workflow = {
  nodes: AppNode[],      // Visual elements (tasks)
  edges: Edge[],         // Data flow connections
  executionPlan: {       // Computed execution phases
    phases: AppNode[][]
  },
  creditsCost: number,   // Total execution cost
  cron?: string,         // Optional scheduling
  webhookKey?: string    // Optional webhook trigger
}
```

**Execution Flow:**
```
User Creates → Validates → Publishes → Triggers (Manual/Cron/Webhook)
  → Phases Execute → Results Stored → Credits Deducted
```

### 2. Task Types (17 Total)

#### Browser Automation (8 tasks)
- `LAUNCH_BROWSER` - Start Puppeteer instance (5 credits)
- `NAVIGATE_URL` - Navigate to URL
- `FILL_INPUT` - Fill form fields
- `CLICK_ELEMENT` - Click DOM elements
- `WAIT_FOR_ELEMENT` - Wait for element visibility
- `SCROLL_TO_ELEMENT` - Scroll to element
- `EXTRACT_TEXT_FROM_ELEMENT` - Extract text content
- `PAGE_TO_HTML` - Get full page HTML

#### Data Processing (4 tasks)
- `INPUT_TEXT` - Manual text input
- `EXTRACT_DATA_WITH_AI` - Parse with GPT-4o-mini
- `ADD_PROPERTY_TO_JSON` - Modify JSON
- `READ_PROPERTY_FROM_JSON` - Extract JSON values

#### Integration (3 tasks)
- `DELIVER_VIA_WEBHOOK` - HTTP POST delivery
- `TELEGRAM` - Send Telegram messages
- `TELEGRAM_AGENT` - AI-powered Telegram bot

#### AI & DeFi (2 tasks)
- `AGENT` - DeFi agent with wallet (2 credits)
- `AGENT_WITH_SAFE_WALLET` - Multi-sig DeFi agent (2 credits)

### 3. AI Agent System

**Agent Architecture:**
```
User Prompt + System Instructions
         ↓
  Google Gemini 2.0 Flash
         ↓
    Tool Calling (GOAT SDK)
         ↓
  Blockchain Transactions
         ↓
    AI Response
```

**Agent Configuration:**
- **Model**: Google Gemini 2.0 Flash
- **Max Steps**: 5 reasoning iterations
- **Wallet**: User-provided encrypted private key
- **Chain**: Selectable from 20+ networks
- **Plugins**: User-selectable DeFi tools

**Available GOAT Plugins (23+):**
- **DEX**: Jupiter, 1inch, 0x, Uniswap, Orca, KIM, Avnu
- **Analytics**: CoinGecko, Birdeye, CoinMarketCap, Dexscreener
- **Lending**: Lulo, Ionic, Ironclad
- **NFTs**: ERC721, ERC1155, OpenSea, Crossmint
- **Governance**: Mode Voting
- **Social**: Farcaster
- **Tokens**: sendETH, ERC20

### 4. Blockchain Integration

**Supported Networks (20+):**

**Mainnet:**
- Ethereum, Base, Arbitrum, Polygon, Optimism
- Avalanche, Celo, Linea, Gnosis, Sei

**Testnet:**
- Sepolia, Base Sepolia, Arbitrum Sepolia
- Polygon Mumbai, Optimism Sepolia
- Avalanche Fuji, Celo Alfajores, Linea Sepolia

**Special Integrations:**
- **NEAR Protocol**: Custom plugin with Ref Finance swaps
- **Cross-chain**: Defuse Protocol for NEAR ↔ EVM swaps
- **Multi-sig**: Safe Wallet support

**Wallet Management:**
```typescript
// Credentials stored encrypted (AES-256-CBC)
Credential {
  name: string;
  value: string; // Format: "iv:encrypted_private_key"
  userId: string;
}

// Decrypted at runtime for agent execution
```

### 5. Database Schema

**Core Models:**
- `Workflow` - Workflow definitions
- `WorkflowExecution` - Execution records
- `ExecutionPhase` - Individual task executions
- `ExecutionLog` - Detailed logs
- `Credential` - Encrypted secrets
- `UserBalance` - Credit balance
- `UserPurchase` - Payment history

**Marketplace Models:**
- `MarketplaceWorkflow` - Listed workflows
- `MarketplaceReview` - User ratings
- `MarketplacePurchase` - On-chain purchases

---

## Key Features

### 1. Visual Workflow Editor
- Drag-and-drop interface powered by XYFlow
- Real-time validation
- Connection drawing with type safety
- Plugin configuration modal

### 2. Multi-Trigger Support
- **Manual**: User clicks "Run" button
- **Cron**: Scheduled execution with cron expressions
- **Webhook**: External HTTP triggers with unique keys

### 3. Credit System
- Tasks cost 0-5 credits
- Pre-execution validation
- Stripe integration for purchases
- Usage tracking per execution

### 4. Marketplace
- List/sell workflows
- On-chain payment support (blockchain transactions)
- Ratings & reviews
- Category filtering

### 5. Security
- Clerk authentication (OAuth + email)
- AES-256-CBC encryption for credentials
- API secret for webhook protection
- User data isolation (userId in all queries)

---

## Project Structure

```
/home/user/Somnia-agent/
├── app/                          # Next.js App Router
│   ├── (auth)/                   # Auth pages
│   ├── (dashboard)/              # Main dashboard
│   │   ├── (home)/               # Analytics
│   │   ├── billing/              # Credits & payments
│   │   ├── credentials/          # API key management
│   │   ├── marketplace/          # Workflow store
│   │   └── workflows/            # Workflow list
│   ├── workflow/                 # Workflow editor & runs
│   │   ├── editor/[workflowId]/  # Visual editor
│   │   └── runs/[...]/           # Execution viewer
│   └── api/                      # API routes
│       ├── workflows/execute/    # Manual execution
│       ├── workflows/webhook/    # Webhook trigger
│       ├── workflows/cron/       # Scheduled execution
│       └── webhooks/stripe/      # Payment webhooks
├── lib/                          # Core logic
│   ├── workflow/                 # Workflow engine
│   │   ├── executor/             # Task executors (17 types)
│   │   ├── task/                 # Task registry
│   │   ├── executionPlan.ts      # Validation & planning
│   │   └── executeWorkflow.ts    # Main orchestrator
│   ├── goat-plugins/             # DeFi plugin registry
│   ├── near-plugin/              # NEAR integration
│   ├── telegram-plugin/          # Telegram tools
│   ├── chains.ts                 # Blockchain configs
│   ├── encryption.ts             # Credential encryption
│   └── stripe/                   # Payment processing
├── actions/                      # Server actions
│   ├── workflows/                # Workflow CRUD
│   ├── analytics/                # Stats calculations
│   ├── billing/                  # Credit management
│   └── credentials/              # Credential CRUD
├── types/                        # TypeScript types
├── prisma/                       # Database schema
└── components/                   # UI components
```

---

## Execution Engine Deep Dive

### Phase-Based Execution

```typescript
// 1. Convert workflow graph to execution phases
FlowToExecutionPlan(workflow) {
  - Find entry point (isEntryPoint: true)
  - Validate all inputs are provided
  - Build phases via topological sort
  - Return: { phases: AppNode[][] }
}

// 2. Execute phases sequentially
for (const phase of executionPlan.phases) {
  // All nodes in phase can run in parallel
  for (const node of phase) {
    // Setup inputs from edges or direct values
    setupEnvironmentForPhase(node, environment, edges);

    // Check & deduct credits
    canExecute = await decrementCredits(userId, creditsRequired);

    // Execute task
    if (canExecute) {
      executor = ExecutorRegistry[node.data.type];
      result = await executor(environment);
    }

    // Store outputs for downstream nodes
    environment.phases[node.id].outputs = result.outputs;
  }
}

// 3. Cleanup resources (close browser, etc.)
await cleanupEnvironment(environment);
```

### Environment & State

```typescript
type Environment = {
  browser?: Browser;           // Shared Puppeteer instance
  page?: Page;                 // Current page
  phases: Record<string, {
    inputs: Record<string, string>;
    outputs: Record<string, string>;
  }>;
};

type ExecutionEnvironment<T> = {
  executionId: string;
  getInput(name: string): string;
  setOutput(name: string, value: string): void;
  getPlugins(): string[];
  getBrowser(): Browser;
  setBrowser(browser: Browser): void;
  getPage(): Page;
  setPage(page: Page): void;
  log: LogCollector;
};
```

---

## Integration Points for Somnia Blockchain

### 1. Add Somnia Chain Support

**File**: `/lib/chains.ts`

```typescript
import { defineChain } from "viem";

// Add Somnia chain definition
export const somnia = defineChain({
  id: [SOMNIA_CHAIN_ID],
  name: "Somnia",
  network: "somnia",
  nativeCurrency: {
    decimals: 18,
    name: "SOMI",
    symbol: "SOMI",
  },
  rpcUrls: {
    default: { http: ["https://rpc.somnia.network"] },
    public: { http: ["https://rpc.somnia.network"] },
  },
  blockExplorers: {
    default: { name: "Explorer", url: "https://explorer.somnia.network" },
  },
});

// Add to chains object
export const chains = {
  somnia: somnia,
  // ... existing chains
};
```

### 2. Create Somnia-Specific GOAT Plugin

**File**: `/lib/goat-plugins/somnia-plugin/`

```typescript
import { PluginBase, Tool } from "@goat-sdk/core";

class SomniaService extends Tool {
  @Tool({
    description: "Interact with Somnia-specific DeFi protocols",
  })
  async interactWithSomniaProtocol(params: SomniaParams) {
    // Implementation
  }
}

export class SomniaPlugin extends PluginBase {
  constructor() {
    super("somnia", [new SomniaService()]);
  }

  supportsChain = (chain) => chain.id === [SOMNIA_CHAIN_ID];
}
```

### 3. Register Somnia Plugin

**File**: `/lib/goat-plugins/pluginRegistry.ts`

```typescript
import { somnia } from "./somnia-plugin";

export const pluginRegistry = {
  somnia: somnia(),
  // ... existing plugins
};
```

### 4. Add Somnia to UI

**File**: `app/workflow/_components/nodes/param/ChainParam.tsx`

```typescript
const chains = [
  { id: [SOMNIA_CHAIN_ID], name: "Somnia Mainnet" },
  // ... existing chains
];
```

---

## Environment Variables

```bash
# Database
DATABASE_URL="postgresql://..."

# Authentication
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY="..."
CLERK_SECRET_KEY="..."

# AI Models
GOOGLE_GENERATIVE_AI_API_KEY="..."
OPENAI_API_KEY="..."

# DeFi Plugins
COINGECKO_API_KEY="..."
BIRDEYE_API_KEY="..."
ONEINCH_API_KEY="..."

# Payments
STRIPE_SECRET_KEY="..."
STRIPE_WEBHOOK_SECRET="..."

# Security
ENCRYPTION_KEY="..." # 32-character key for AES-256-CBC
API_SECRET="..."     # For webhook/cron authentication
```

---

## Deployment Checklist

### For Somnia Testnet:
1. ✅ Add Somnia chain to `/lib/chains.ts`
2. ✅ Deploy smart contracts (if any custom logic)
3. ✅ Fund test wallet with SOMI tokens
4. ✅ Add test credentials to platform
5. ✅ Test agent execution on Somnia testnet
6. ✅ Create demo workflows
7. ✅ Record demo video (≤5 minutes)
8. ✅ Prepare pitch deck (5-10 slides)

### Submission Requirements:
- [ ] Public GitHub repository (this repo)
- [ ] Minimum 2 commits
- [ ] Detailed README
- [ ] Open-source license (MIT already included)
- [ ] Working dApp on Somnia Testnet
- [ ] Contract addresses documented
- [ ] Demo video (≤5 minutes)
- [ ] Pitch deck (5-10 slides)

---

## Use Cases for Hackathon

### DeFi Track:
- Automated yield farming strategies
- Portfolio rebalancing agents
- Price monitoring & alert systems
- Liquidity provision automation

### Gaming Track:
- In-game asset trading bots
- NFT minting automation
- Tournament prize distribution
- Player behavior analytics

### Infra Track:
- Multi-chain monitoring dashboard
- Gas optimization workflows
- Contract interaction recorder
- Developer toolkit for agent creation

### Open Track:
- Social media integration with on-chain actions
- DAO governance automation
- Cross-chain arbitrage detection
- Telegram trading bots

---

## Key Files for Development

| File | Purpose |
|------|---------|
| `/lib/workflow/executeWorkflow.ts` | Main execution orchestrator |
| `/lib/workflow/executor/AgentExecutor.ts` | AI agent implementation |
| `/lib/chains.ts` | Blockchain configuration |
| `/lib/goat-plugins/pluginRegistry.ts` | DeFi tool registry |
| `/prisma/schema.prisma` | Database schema |
| `/app/workflow/editor/[workflowId]/page.tsx` | Visual editor |
| `/app/api/workflows/execute/route.ts` | Execution API |

---

## Development Commands

```bash
# Install dependencies
yarn install

# Database setup
npx prisma generate
npx prisma db push
npx prisma db seed

# Run development server
yarn dev

# Build for production
yarn build
yarn start

# Type checking
tsc --noEmit
```

---

## Credits & Pricing

| Task Type | Credits |
|-----------|---------|
| Launch Browser | 5 |
| Agent (DeFi) | 2 |
| Agent (Safe Wallet) | 2 |
| Other Tasks | 0 |

**Minimum Credit Purchase**: Configurable via Stripe

---

## Support & Resources

- **Telegram**: [Somnia Hackathon Group](https://t.me/+XHq0F0JXMyhmMzM0)
- **Documentation**: This file + inline code comments
- **Issues**: GitHub Issues tab

---

## License

MIT License - See LICENSE file for details
