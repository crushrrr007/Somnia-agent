# Somnia Workflow Marketplace Smart Contract

This directory contains the smart contract for the decentralized workflow marketplace on Somnia blockchain.

## Contract: WorkflowMarketplace.sol

A fully on-chain marketplace for buying and selling AI workflow automation templates with native STT token payments.

### Features

- **List Workflows**: Creators can list their workflows with custom pricing
- **Purchase Workflows**: Users can purchase workflows with STT tokens
- **Revenue Tracking**: Automatic revenue distribution with platform fees
- **On-chain Records**: All transactions recorded on Somnia blockchain
- **Creator Royalties**: Creators receive 95% of sales (5% platform fee)
- **Active/Inactive Listings**: Creators can manage listing visibility
- **Purchase History**: Track all purchases and ownership

### Contract Functions

#### Public Functions

- `listWorkflow(workflowId, name, description, price)` - List a new workflow
- `purchaseWorkflow(listingId)` - Purchase a workflow (payable)
- `updateWorkflow(listingId, name, description, price)` - Update listing details
- `deactivateWorkflow(listingId)` - Deactivate a listing
- `reactivateWorkflow(listingId)` - Reactivate a listing

#### View Functions

- `getListing(listingId)` - Get listing details
- `getCreatorListings(creator)` - Get all listings by creator
- `getUserPurchases(user)` - Get all purchases by user
- `getActiveListings(offset, limit)` - Get paginated active listings
- `hasPurchased(user, listingId)` - Check if user purchased workflow

#### Admin Functions

- `updatePlatformFee(newFeePercent)` - Update platform fee (max 20%)
- `transferPlatformOwnership(newWallet)` - Transfer platform ownership

### Events

- `WorkflowListed` - Emitted when a workflow is listed
- `WorkflowPurchased` - Emitted when a workflow is purchased
- `WorkflowUpdated` - Emitted when listing is updated
- `WorkflowDeactivated` - Emitted when listing is deactivated

## Deployment

### Prerequisites

1. Install dependencies:
```bash
cd contracts
npm install
```

2. Set up environment variables in root `.env`:
```env
DEPLOYER_PRIVATE_KEY="your-private-key-here"
```

3. Get Somnia testnet tokens:
- Visit: https://testnet.somnia.network/
- Request STT tokens for deployment

### Deploy to Somnia Testnet

```bash
npm run deploy:testnet
```

This will:
1. Deploy the WorkflowMarketplace contract
2. Save deployment info to `deployment.json`
3. Display contract address and explorer link

### Verify Contract (Optional)

```bash
npx hardhat verify --network somniaTestnet <CONTRACT_ADDRESS>
```

## Integration with Platform

After deployment, update your application:

1. Add contract address to `.env`:
```env
NEXT_PUBLIC_MARKETPLACE_CONTRACT_ADDRESS="0x..."
```

2. The platform will automatically use on-chain marketplace for:
   - Workflow listings
   - Purchase transactions
   - Revenue tracking
   - Ownership verification

## Testing

### Local Testing

```bash
# Start local Hardhat node
npx hardhat node

# Deploy to local network (in another terminal)
npm run deploy:local

# Run tests
npm test
```

### Testnet Testing

1. Deploy contract to Somnia testnet
2. Use the platform UI to:
   - List a test workflow
   - Purchase with another account
   - Verify transaction on explorer

## Contract ABI

After compilation, the ABI is available at:
```
artifacts/contracts/WorkflowMarketplace.sol/WorkflowMarketplace.json
```

## Gas Optimization

The contract is optimized for gas efficiency:
- Solidity 0.8.20 with optimizer enabled
- Efficient storage patterns
- Minimal external calls
- Batch operations where possible

## Security Considerations

- ✅ Reentrancy protection via checks-effects-interactions pattern
- ✅ Input validation on all public functions
- ✅ Access control for admin functions
- ✅ Safe math (Solidity 0.8+ built-in overflow protection)
- ✅ Platform fee capped at 20%

## Somnia Network Details

- **Chain ID**: 50312
- **RPC URL**: https://dream-rpc.somnia.network
- **Explorer**: https://shannon-explorer.somnia.network
- **Symbol**: STT
- **Faucet**: https://testnet.somnia.network/

## License

MIT License - See LICENSE file in root directory
