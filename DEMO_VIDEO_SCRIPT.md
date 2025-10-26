# Demo Video Script - Somnia Workflow Automation Platform

**Duration**: 5 minutes maximum
**Target Audience**: Hackathon judges, developers, crypto enthusiasts
**Goal**: Showcase the platform's capabilities as an infrastructure for AI agents on Somnia

---

## Video Structure

### Introduction (30 seconds)

**[Screen: Landing page or demo site]**

**Narration**:
> "Welcome to the Somnia Workflow Automation Platform - a visual, no-code infrastructure for building autonomous AI agents on the Somnia blockchain.
>
> Built for the Somnia AI Hackathon, our platform enables anyone to create complex workflows that combine artificial intelligence, DeFi operations, and blockchain interactions without writing a single line of code."

**Visual**:
- Show platform homepage
- Quick pan of workflow editor
- Brief flash of key features

---

### Problem Statement (30 seconds)

**[Screen: Text overlay or slides]**

**Narration**:
> "Building AI agents for blockchain is challenging. Developers need to:
> - Integrate multiple AI models
> - Connect to various DeFi protocols
> - Handle wallet management and transactions
> - Build complex automation logic
> - Deploy and maintain infrastructure
>
> This creates a high barrier to entry for building on-chain AI agents."

**Visual**:
- Show complexity: code snippets, multiple APIs, configuration files
- Frustrated developer animation (optional)

---

### Solution Overview (45 seconds)

**[Screen: Platform architecture diagram]**

**Narration**:
> "Our platform solves this with three core innovations:
>
> **First**, a visual workflow editor powered by React Flow. Drag and drop 17 different task types - from browser automation to AI agents - and connect them to create complex logic.
>
> **Second**, integrated AI agents using Google Gemini with access to 23+ DeFi plugins via the GOAT SDK. Agents can autonomously swap tokens, check prices, manage portfolios, and more.
>
> **Third**, native Somnia blockchain integration with multi-signature wallet support, enabling secure on-chain operations at scale."

**Visual**:
- Show workflow editor with nodes being connected
- Highlight AI agent configuration panel
- Show Somnia network selector
- Display plugin marketplace

---

### Live Demo Part 1: Creating a Workflow (90 seconds)

**[Screen: Workflow editor]**

**Narration**:
> "Let me show you how easy it is to build an AI-powered DeFi agent.
>
> **Step 1**: I'm creating a new workflow called 'Portfolio Analyzer'.
>
> **Step 2**: First, I'll add an INPUT_TEXT task where users can enter a wallet address.
>
> **Step 3**: Next, I add an AGENT task. This is our AI agent powered by Google Gemini. I'll configure it with:
> - A system prompt: 'You are a DeFi portfolio analyst'
> - Connect the wallet address input
> - Select Somnia Testnet as the blockchain
> - Add my encrypted wallet credential
> - Enable plugins: Birdeye for analytics, CoinGecko for prices, and 1inch for swap recommendations
>
> **Step 4**: Finally, I'll add a TELEGRAM task to send results to users.
>
> **Step 5**: I connect all the nodes - data flows from input, through the AI agent, to the Telegram notification.
>
> The platform validates everything in real-time. All inputs are satisfied, so I can publish."

**Actions**:
1. Click "Create Workflow"
2. Add INPUT_TEXT node
3. Add AGENT node (show configuration panel)
4. Select plugins (zoom in on plugin selection)
5. Add TELEGRAM node
6. Draw connections between nodes
7. Click "Publish"
8. Show credit cost calculation

**Visual Tips**:
- Use mouse highlight or zoom to focus on important areas
- Show validation checkmarks
- Display the execution plan

---

### Live Demo Part 2: Execution & Results (60 seconds)

**[Screen: Workflow execution view]**

**Narration**:
> "Now let's execute this workflow.
>
> I'll enter a Somnia wallet address and click Run.
>
> Watch as the platform:
> 1. Processes the input
> 2. Decrypts my wallet credentials securely
> 3. Connects to Somnia testnet
> 4. Launches the Gemini AI agent with DeFi tools
> 5. The agent analyzes the portfolio using Birdeye
> 6. Checks token prices via CoinGecko
> 7. Generates swap recommendations
> 8. Sends results via Telegram
>
> Here are the results - the AI agent successfully analyzed the wallet, identified the token holdings, and suggested optimal rebalancing strategies.
>
> Every step is logged, and the transaction is recorded on the Somnia blockchain. You can view it on the Somnia Explorer."

**Actions**:
1. Click "Run Workflow"
2. Enter test wallet address
3. Show execution in progress (real-time phase updates)
4. Display completed execution with logs
5. Show Telegram notification received
6. Open Somnia Explorer tab showing transaction

**Visual Tips**:
- Show execution phases lighting up
- Display logs in real-time
- Show successful completion
- Open explorer in new tab (picture-in-picture)

---

### Smart Contract Integration (30 seconds)

**[Screen: Smart contract deployment info]**

**Narration**:
> "For the hackathon, we've also deployed a WorkflowMarketplace smart contract on Somnia testnet.
>
> This contract enables creators to list their workflows for sale, with payments in STT tokens. Buyers can purchase workflows directly on-chain, with automatic revenue distribution - 95% to creators, 5% platform fee.
>
> Here's our deployed contract on the Somnia Explorer. It's fully verified and ready for production."

**Actions**:
1. Show deployment.json file
2. Open Somnia Explorer
3. Show contract code
4. Demonstrate a marketplace listing (if time permits)

**Visual Tips**:
- Highlight contract address
- Show verified checkmark on explorer
- Display contract functions

---

### Platform Features Overview (30 seconds)

**[Screen: Split screen or feature montage]**

**Narration**:
> "Beyond what we've shown, the platform includes:
> - Scheduled execution with cron expressions
> - Webhook triggers for external integrations
> - Browser automation with Puppeteer
> - Multi-chain support - 20+ EVM networks plus NEAR Protocol
> - Marketplace for sharing and monetizing workflows
> - Enterprise features like Safe wallet integration for multi-sig operations"

**Visual**:
- Show cron configuration
- Webhook URL generation
- Browser automation example
- Chain selector dropdown
- Marketplace browse view
- Safe wallet selector

---

### Use Cases & Impact (30 seconds)

**[Screen: Text with icons or simple animations]**

**Narration**:
> "This infrastructure enables endless possibilities:
>
> **For DeFi**: Automated trading bots, yield farming optimizers, risk management agents
>
> **For Gaming**: NFT minting automation, in-game asset trading, tournament prize distribution
>
> **For Developers**: Monitoring tools, gas optimization workflows, contract interaction recorders
>
> **For DAOs**: Governance automation, treasury management, proposal analyzers
>
> By making it easy to build AI agents on Somnia, we're accelerating the adoption of autonomous on-chain intelligence."

**Visual**:
- Show 4 quadrants with icons for each use case
- Brief animation of workflows in action

---

### Technical Highlights (20 seconds)

**[Screen: Architecture diagram or code snippets]**

**Narration**:
> "Under the hood, we're using:
> - Next.js 14 with TypeScript for the frontend
> - Prisma ORM with PostgreSQL for data persistence
> - Google Gemini 2.0 Flash for AI reasoning
> - GOAT SDK for standardized DeFi integrations
> - Viem for multi-chain wallet management
> - And of course, deployed on Somnia testnet with full blockchain integration"

**Visual**:
- Show tech stack logos
- Brief code snippet (1-2 seconds)
- Architecture diagram

---

### Call to Action & Conclusion (20 seconds)

**[Screen: Repository and links]**

**Narration**:
> "The platform is fully open-source on GitHub. You can deploy it yourself, create workflows, or contribute to the codebase.
>
> We've included comprehensive documentation, deployment guides, and example workflows to get you started.
>
> Visit our repository, try the platform on Somnia testnet, and experience the future of AI agent infrastructure.
>
> Thank you!"

**Visual**:
- Show GitHub repository
- Display QR code
- Show deployment guide thumbnail
- End screen with:
  - GitHub URL
  - Somnia Explorer link
  - Demo site URL
  - Social links

---

## Recording Tips

### Before Recording

1. **Prepare Demo Environment**:
   - Fresh browser session
   - Clear cookies/cache
   - Close unnecessary tabs
   - Turn off notifications
   - Use incognito mode

2. **Test Everything**:
   - Run workflow end-to-end
   - Verify Telegram bot works
   - Check Somnia Explorer loads
   - Test all clicks and navigation

3. **Setup Recording**:
   - Use 1920x1080 resolution
   - Install Loom, OBS, or ScreenFlow
   - Test audio (clear, no background noise)
   - Use teleprompter app for narration

4. **Prepare Assets**:
   - Have all URLs bookmarked
   - Pre-load Somnia Explorer tab
   - Have test wallet address ready
   - Queue up Telegram app

### During Recording

1. **Pacing**:
   - Speak clearly and not too fast
   - Pause briefly between sections
   - Allow UI animations to complete

2. **Mouse Movement**:
   - Move cursor smoothly
   - Hover to highlight elements
   - Click deliberately
   - Use zoom for small details

3. **Backup Takes**:
   - Record each section separately
   - Keep best take of each
   - Edit together in post

### After Recording

1. **Editing**:
   - Trim dead space
   - Add transitions between sections
   - Include text overlays for important points
   - Add background music (subtle, no copyright)
   - Add captions/subtitles

2. **Polish**:
   - Color correction
   - Audio normalization
   - Export at 1080p, 30fps
   - Keep file size under 500MB

3. **Upload**:
   - YouTube (unlisted or public)
   - Loom (for easy sharing)
   - Direct link in README.md

---

## Alternative Demo Flows

### Option A: Browser Automation Focus

Show web scraping → AI extraction → blockchain storage workflow

### Option B: Multi-Chain Focus

Demonstrate cross-chain workflow: NEAR → Somnia via Defuse Protocol

### Option C: Marketplace Focus

Show listing workflow, purchasing with STT, revenue distribution

---

## Production Notes

**Video Format**:
- MP4, H.264 codec
- 1920x1080 resolution
- 30fps
- Stereo audio, 128kbps AAC

**Hosting**:
- YouTube (recommended)
- Loom (for easy embedding)
- Vimeo (professional)

**File Naming**:
`somnia-workflow-platform-demo-v1.mp4`

---

## Example Narration Script (Full)

*Available as separate document for teleprompter*

---

**Total Duration**: 5 minutes (± 15 seconds)
**Target**: Informative, professional, exciting
**Tone**: Technical but accessible, enthusiastic but credible
