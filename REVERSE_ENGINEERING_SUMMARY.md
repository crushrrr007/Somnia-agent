# Reverse Engineering Summary

## Project: Somnia Workflow Automation Platform

**Date**: October 26, 2025
**Purpose**: Somnia AI Hackathon Entry
**Status**: Functional codebase ready for Somnia blockchain integration

---

## What This Project Does

This is a **visual workflow automation platform** that combines:
1. **AI Agents** (Google Gemini 2.0 Flash) that can perform DeFi operations
2. **Browser Automation** (Puppeteer) for web scraping
3. **Multi-Chain Support** (20+ EVM chains + NEAR)
4. **DeFi Integrations** (23+ plugins via GOAT SDK)
5. **Flexible Triggers** (Manual, Cron, Webhook)

Users create workflows by dragging and dropping visual nodes, configure AI agents with specific DeFi tools, and automate complex tasks.

---

## Core Technology Breakdown

### 1. Workflow System
- **Visual Editor**: XYFlow (React Flow) drag-and-drop interface
- **Execution Model**: Phase-based sequential execution
- **Task Types**: 17 different task types (browser automation, AI agents, data processing)
- **Validation**: Pre-execution validation ensures all inputs are satisfied
- **State Management**: Environment object tracks browser, pages, and data flow between nodes

### 2. AI Agent System
**Location**: `/lib/workflow/executor/AgentExecutor.ts`

```
User Prompt → Google Gemini 2.0 Flash → GOAT SDK Tools → Blockchain TX → Response
```

**How it works**:
1. User selects plugins (e.g., CoinGecko, 1inch, Birdeye)
2. Agent receives encrypted wallet private key from database
3. Creates Viem wallet client for selected blockchain
4. GOAT SDK converts plugins into AI tools (functions Gemini can call)
5. Gemini makes up to 5 reasoning steps, calling tools autonomously
6. Returns text response + execution logs

**Supported Operations**:
- Token swaps (1inch, 0x, Jupiter, etc.)
- Price lookups (CoinGecko, Birdeye)
- Lending (Lulo, Ionic)
- NFT operations (OpenSea, ERC721)
- Cross-chain swaps (NEAR Defuse Protocol)

### 3. Blockchain Integration
**Location**: `/lib/chains.ts`, `/lib/workflow/executor/AgentExecutor.ts`

- **Wallet Management**: Private keys stored encrypted (AES-256-CBC) in database
- **Multi-Chain**: Viem library supports 20+ EVM chains dynamically
- **Transaction Signing**: Automated via wallet client
- **Safe Wallet**: Multi-sig support via @goat-sdk/wallet-safe

**Chains Supported**:
- Mainnet: Ethereum, Base, Arbitrum, Polygon, Optimism, Avalanche, Celo, Linea, Gnosis, Sei
- Testnet: Sepolia, Base Sepolia, Arbitrum Sepolia, etc.
- Special: NEAR Protocol with Ref Finance DEX

### 4. Database Schema
**Location**: `/prisma/schema.prisma`

**Key Models**:
- `Workflow` - Workflow definitions (nodes, edges, execution plan)
- `WorkflowExecution` - Execution records with trigger type
- `ExecutionPhase` - Individual task execution details
- `Credential` - Encrypted private keys and API keys
- `UserBalance` - Credit balance for billing
- `MarketplaceWorkflow` - Listed workflows for sale

### 5. Task Executors (17 Types)
**Location**: `/lib/workflow/executor/`

**Browser Automation**:
- LaunchBrowserExecutor (5 credits)
- NavigateUrlExecutor
- FillInputExecutor
- ClickElementExecutor
- WaitForElementExecutor
- ScrollToElementExecutor
- ExtractTextFromElementExecutor
- PageToHtmlExecutor

**AI & Data**:
- ExtractDataWithAiExecutor (OpenAI GPT-4o-mini)
- AgentExecutor (Gemini + GOAT plugins, 2 credits)
- AgentWithSafeWalletExecutor (Multi-sig, 2 credits)

**Integration**:
- DeliverViaWebhookExecutor
- TelegramExecutor
- TelegramAgentExecutor

**Data Processing**:
- InputTextExecutor
- AddPropertyToJsonExecutor
- ReadPropertyFromJsonExecutor

### 6. Plugin System
**Location**: `/lib/goat-plugins/pluginRegistry.ts`, `/lib/goat-plugins/pluginStore.ts`

**Architecture**:
```typescript
// Plugins are GOAT SDK modules
const pluginRegistry = {
  CoinGecko: coingecko({ apiKey: process.env.COINGECKO_API_KEY }),
  oneInch: oneInch({ apiKey: process.env.ONEINCH_API_KEY }),
  // ... 23+ more
};

// Converted to AI tools at runtime
const tools = await getOnChainTools({
  wallet: viem(walletClient),
  plugins: [pluginRegistry.CoinGecko, pluginRegistry.oneInch]
});
```

**Available Plugins**:
- **DEX**: Jupiter, 1inch, 0x, Uniswap, Orca, KIM, Avnu, Balancer
- **Data**: CoinGecko, Birdeye, CoinMarketCap, Dexscreener, Nansen
- **DeFi**: Lulo, Ionic, Ironclad (lending)
- **NFT**: ERC721, ERC1155, OpenSea, Crossmint
- **Social**: Farcaster
- **Governance**: Mode Voting
- **Special**: NEAR (custom plugin with Ref Finance + Defuse)

### 7. NEAR Protocol Integration
**Location**: `/lib/near-plugin/src/`

Custom GOAT plugin providing:
- `transferNEAR()` - Send NEAR tokens
- `swapTokens()` - Use Ref Finance DEX
- `crossChainSwap()` - Use Defuse Protocol for NEAR ↔ EVM swaps
- `crossChainSwapAndWithdraw()` - Swap + withdraw in one operation

**Special Features**:
- NEP-413 message signing
- Intent-based settlement (5-minute polling)
- Storage deposit handling (NEP-141)

---

## Workflow Execution Flow

```
1. User Creates Workflow in Visual Editor
   - Drags nodes from task menu
   - Connects nodes with edges (data flow)
   - Configures inputs and plugins

2. Validation (FlowToExecutionPlan)
   - Checks for entry point (isEntryPoint: true)
   - Validates all inputs have values or incoming edges
   - Builds execution phases via topological sort

3. Publish
   - Calculates creditsCost (sum of all task costs)
   - Stores definition + executionPlan in database

4. Trigger (3 ways)
   - MANUAL: User clicks "Run"
   - CRON: Scheduled via cron expression
   - WEBHOOK: External HTTP POST

5. Execution (executeWorkflow.ts)
   - Creates WorkflowExecution record
   - Initializes environment (browser, state)
   - Executes phases sequentially:
     a. Setup inputs from edges/values
     b. Check & deduct credits
     c. Call executor for task type
     d. Store outputs in environment
     e. Log results
   - Finalizes execution (update status, credits consumed)
   - Cleanup resources (close browser)

6. Results
   - Stored in ExecutionPhase table
   - Viewable in UI at /workflow/runs/[workflowId]/[executionId]
   - Logs preserved for debugging
```

---

## Key Insights for Hackathon

### Strengths
1. **Modular Design**: Easy to add new task types, chains, or plugins
2. **Visual Interface**: Non-coders can create complex workflows
3. **AI-First**: Gemini agents can make autonomous decisions
4. **Multi-Chain**: Already supports 20+ chains, easy to add Somnia
5. **Production-Ready**: Has billing, marketplace, authentication

### Missing Somnia Integration
**Current State**: No explicit Somnia blockchain code

**To Add Somnia**:
1. Add chain definition to `/lib/chains.ts`
2. Update UI dropdown to include Somnia
3. (Optional) Create Somnia-specific GOAT plugin if unique DeFi protocols
4. Test with Somnia testnet RPC and funded wallet

### Extensibility Points
- **New Task Types**: Add to `/types/task.ts` + create executor
- **New Chains**: Add to `/lib/chains.ts`
- **New Plugins**: Create GOAT plugin + register in `pluginRegistry.ts`
- **Custom Triggers**: Add new trigger types to execution system

---

## Technical Debts / Considerations

1. **No Smart Contracts**: Platform itself doesn't deploy contracts (could add)
2. **Centralized Execution**: Workflows run on server, not decentralized
3. **Credit System**: Uses database credits, not on-chain tokens
4. **Marketplace Payments**: Tracks blockchain payments but doesn't enforce on-chain

### Potential Improvements for Hackathon
1. Deploy marketplace as smart contract on Somnia
2. Use SOMI tokens for credits instead of Stripe
3. Add Somnia-specific DeFi protocol plugins
4. Create on-chain workflow registry
5. Decentralized execution via Somnia validators

---

## File Navigation Guide

| Need to... | Check file... |
|------------|---------------|
| Understand workflow execution | `/lib/workflow/executeWorkflow.ts` |
| See AI agent implementation | `/lib/workflow/executor/AgentExecutor.ts` |
| Add new blockchain | `/lib/chains.ts` |
| Add new DeFi plugin | `/lib/goat-plugins/pluginRegistry.ts` |
| Modify database schema | `/prisma/schema.prisma` |
| Edit visual editor | `/app/workflow/_components/FlowEditor.tsx` |
| Add new task type | `/types/task.ts` + `/lib/workflow/executor/` |
| Configure API routes | `/app/api/workflows/` |

---

## Environment Setup Checklist

- [ ] PostgreSQL database running
- [ ] Clerk account configured (authentication)
- [ ] Google AI API key (Gemini 2.0 Flash)
- [ ] OpenAI API key (GPT-4o-mini)
- [ ] DeFi plugin API keys (CoinGecko, Birdeye, 1inch, etc.)
- [ ] Encryption key (32 characters) for credentials
- [ ] API secret for webhook security
- [ ] (Optional) Stripe keys for payments
- [ ] Prisma client generated (`npx prisma generate`)
- [ ] Database schema pushed (`npx prisma db push`)

---

## Quick Start Commands

```bash
# Clone & install
git clone https://github.com/crushrrr007/Somnia-agent.git
cd Somnia-agent
yarn install

# Setup
cp .env.example .env
# Edit .env with your keys

# Database
npx prisma generate
npx prisma db push

# Run
yarn dev
# Open http://localhost:3000
```

---

## Hackathon Submission Readiness

| Requirement | Status |
|-------------|--------|
| Public GitHub repo | ✅ Done |
| 2+ commits | ✅ Done |
| README | ✅ Done (comprehensive) |
| Open-source license | ✅ MIT License |
| Deployed on Somnia Testnet | ⚠️ Need to add Somnia chain |
| Contract addresses | ⚠️ No contracts yet (platform is off-chain) |
| Demo video | ❌ TODO |
| Pitch deck | ❌ TODO |

**Next Steps**:
1. Add Somnia chain configuration
2. Create test workflow demonstrating AI agent on Somnia
3. (Optional) Deploy marketplace smart contract on Somnia
4. Record demo video
5. Create pitch deck

---

## Recommended Hackathon Track

**Best Fit**: **Infra Agents Track**

**Reasoning**:
- Provides SDK-like platform for building AI agents
- Enables developers to create agents without coding
- Marketplace for sharing agent workflows
- Multi-chain infrastructure ready
- Extensible plugin system

**Alternative**: **DeFi Agents Track**
- Already has 23+ DeFi integrations
- AI agents can perform autonomous trading
- Could add Somnia-specific DeFi strategies

---

## Contact & Resources

- **Docs**: See ARCHITECTURE.md for detailed documentation
- **Telegram**: [Somnia Hackathon Group](https://t.me/+XHq0F0JXMyhmMzM0)
- **GitHub**: [crushrrr007/Somnia-agent](https://github.com/crushrrr007/Somnia-agent)

---

## Final Thoughts

This is a **well-architected, production-quality codebase** that demonstrates:
- Modern full-stack development (Next.js, TypeScript, Prisma)
- AI/blockchain integration (Gemini + GOAT SDK)
- Complex workflow orchestration
- Multi-chain support

**For the hackathon**, the main work needed is:
1. Adding Somnia chain support (straightforward)
2. Creating compelling demo workflows
3. Documentation & presentation

The codebase is already feature-complete and ready for showcase!
