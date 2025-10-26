// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title WorkflowMarketplace
 * @dev Decentralized marketplace for AI workflow automation templates on Somnia blockchain
 * @notice This contract enables creators to list, sell, and manage workflow templates with on-chain payments
 */
contract WorkflowMarketplace {

    // Workflow listing structure
    struct WorkflowListing {
        uint256 id;
        address payable creator;
        string workflowId;        // Off-chain workflow ID
        string name;
        string description;
        uint256 price;            // Price in wei (STT tokens)
        uint256 totalSales;
        uint256 revenue;
        bool active;
        uint256 createdAt;
    }

    // Purchase record structure
    struct Purchase {
        uint256 listingId;
        address buyer;
        uint256 price;
        uint256 timestamp;
        string txHash;
    }

    // State variables
    uint256 public nextListingId = 1;
    uint256 public platformFeePercent = 5; // 5% platform fee
    address payable public platformWallet;

    // Mappings
    mapping(uint256 => WorkflowListing) public listings;
    mapping(address => uint256[]) public creatorListings;
    mapping(address => uint256[]) public userPurchases;
    mapping(uint256 => Purchase[]) public listingPurchases;
    mapping(string => bool) public workflowExists;

    // Events
    event WorkflowListed(
        uint256 indexed listingId,
        address indexed creator,
        string workflowId,
        string name,
        uint256 price
    );

    event WorkflowPurchased(
        uint256 indexed listingId,
        address indexed buyer,
        address indexed creator,
        uint256 price,
        uint256 platformFee
    );

    event WorkflowUpdated(
        uint256 indexed listingId,
        string name,
        string description,
        uint256 price
    );

    event WorkflowDeactivated(uint256 indexed listingId);

    event PlatformFeeUpdated(uint256 newFeePercent);

    // Modifiers
    modifier onlyCreator(uint256 _listingId) {
        require(listings[_listingId].creator == msg.sender, "Not the creator");
        _;
    }

    modifier onlyPlatform() {
        require(msg.sender == platformWallet, "Not platform owner");
        _;
    }

    modifier listingExists(uint256 _listingId) {
        require(_listingId > 0 && _listingId < nextListingId, "Listing does not exist");
        _;
    }

    // Constructor
    constructor() {
        platformWallet = payable(msg.sender);
    }

    /**
     * @dev List a new workflow in the marketplace
     * @param _workflowId Off-chain workflow identifier
     * @param _name Workflow name
     * @param _description Workflow description
     * @param _price Price in wei (STT tokens)
     */
    function listWorkflow(
        string memory _workflowId,
        string memory _name,
        string memory _description,
        uint256 _price
    ) external returns (uint256) {
        require(_price > 0, "Price must be greater than 0");
        require(!workflowExists[_workflowId], "Workflow already listed");
        require(bytes(_name).length > 0, "Name cannot be empty");

        uint256 listingId = nextListingId++;

        listings[listingId] = WorkflowListing({
            id: listingId,
            creator: payable(msg.sender),
            workflowId: _workflowId,
            name: _name,
            description: _description,
            price: _price,
            totalSales: 0,
            revenue: 0,
            active: true,
            createdAt: block.timestamp
        });

        creatorListings[msg.sender].push(listingId);
        workflowExists[_workflowId] = true;

        emit WorkflowListed(listingId, msg.sender, _workflowId, _name, _price);

        return listingId;
    }

    /**
     * @dev Purchase a workflow listing
     * @param _listingId The ID of the listing to purchase
     */
    function purchaseWorkflow(uint256 _listingId)
        external
        payable
        listingExists(_listingId)
    {
        WorkflowListing storage listing = listings[_listingId];

        require(listing.active, "Listing is not active");
        require(msg.value >= listing.price, "Insufficient payment");
        require(msg.sender != listing.creator, "Cannot purchase own workflow");

        // Calculate platform fee and creator payment
        uint256 platformFee = (msg.value * platformFeePercent) / 100;
        uint256 creatorPayment = msg.value - platformFee;

        // Transfer funds
        platformWallet.transfer(platformFee);
        listing.creator.transfer(creatorPayment);

        // Update listing stats
        listing.totalSales++;
        listing.revenue += creatorPayment;

        // Record purchase
        Purchase memory purchase = Purchase({
            listingId: _listingId,
            buyer: msg.sender,
            price: msg.value,
            timestamp: block.timestamp,
            txHash: ""
        });

        listingPurchases[_listingId].push(purchase);
        userPurchases[msg.sender].push(_listingId);

        emit WorkflowPurchased(
            _listingId,
            msg.sender,
            listing.creator,
            msg.value,
            platformFee
        );
    }

    /**
     * @dev Update workflow listing details
     * @param _listingId The ID of the listing to update
     * @param _name New name
     * @param _description New description
     * @param _price New price
     */
    function updateWorkflow(
        uint256 _listingId,
        string memory _name,
        string memory _description,
        uint256 _price
    ) external onlyCreator(_listingId) listingExists(_listingId) {
        require(_price > 0, "Price must be greater than 0");
        require(bytes(_name).length > 0, "Name cannot be empty");

        WorkflowListing storage listing = listings[_listingId];
        listing.name = _name;
        listing.description = _description;
        listing.price = _price;

        emit WorkflowUpdated(_listingId, _name, _description, _price);
    }

    /**
     * @dev Deactivate a workflow listing
     * @param _listingId The ID of the listing to deactivate
     */
    function deactivateWorkflow(uint256 _listingId)
        external
        onlyCreator(_listingId)
        listingExists(_listingId)
    {
        listings[_listingId].active = false;
        emit WorkflowDeactivated(_listingId);
    }

    /**
     * @dev Reactivate a workflow listing
     * @param _listingId The ID of the listing to reactivate
     */
    function reactivateWorkflow(uint256 _listingId)
        external
        onlyCreator(_listingId)
        listingExists(_listingId)
    {
        listings[_listingId].active = true;
    }

    /**
     * @dev Update platform fee percentage
     * @param _newFeePercent New fee percentage (0-100)
     */
    function updatePlatformFee(uint256 _newFeePercent) external onlyPlatform {
        require(_newFeePercent <= 20, "Fee cannot exceed 20%");
        platformFeePercent = _newFeePercent;
        emit PlatformFeeUpdated(_newFeePercent);
    }

    /**
     * @dev Transfer platform ownership
     * @param _newPlatformWallet New platform wallet address
     */
    function transferPlatformOwnership(address payable _newPlatformWallet)
        external
        onlyPlatform
    {
        require(_newPlatformWallet != address(0), "Invalid address");
        platformWallet = _newPlatformWallet;
    }

    // View functions

    /**
     * @dev Get listing details
     * @param _listingId The ID of the listing
     */
    function getListing(uint256 _listingId)
        external
        view
        listingExists(_listingId)
        returns (WorkflowListing memory)
    {
        return listings[_listingId];
    }

    /**
     * @dev Get all listings by a creator
     * @param _creator Creator address
     */
    function getCreatorListings(address _creator)
        external
        view
        returns (uint256[] memory)
    {
        return creatorListings[_creator];
    }

    /**
     * @dev Get all purchases by a user
     * @param _user User address
     */
    function getUserPurchases(address _user)
        external
        view
        returns (uint256[] memory)
    {
        return userPurchases[_user];
    }

    /**
     * @dev Get all purchases for a listing
     * @param _listingId The ID of the listing
     */
    function getListingPurchases(uint256 _listingId)
        external
        view
        listingExists(_listingId)
        returns (Purchase[] memory)
    {
        return listingPurchases[_listingId];
    }

    /**
     * @dev Get total number of listings
     */
    function getTotalListings() external view returns (uint256) {
        return nextListingId - 1;
    }

    /**
     * @dev Check if user has purchased a specific workflow
     * @param _user User address
     * @param _listingId Listing ID
     */
    function hasPurchased(address _user, uint256 _listingId)
        external
        view
        returns (bool)
    {
        uint256[] memory purchases = userPurchases[_user];
        for (uint256 i = 0; i < purchases.length; i++) {
            if (purchases[i] == _listingId) {
                return true;
            }
        }
        return false;
    }

    /**
     * @dev Get active listings (paginated)
     * @param _offset Starting index
     * @param _limit Number of items to return
     */
    function getActiveListings(uint256 _offset, uint256 _limit)
        external
        view
        returns (WorkflowListing[] memory)
    {
        uint256 totalListings = nextListingId - 1;
        uint256 resultCount = 0;

        // Count active listings
        for (uint256 i = 1; i <= totalListings; i++) {
            if (listings[i].active) {
                resultCount++;
            }
        }

        // Calculate actual return size
        uint256 start = _offset > resultCount ? resultCount : _offset;
        uint256 end = start + _limit > resultCount ? resultCount : start + _limit;
        uint256 size = end > start ? end - start : 0;

        WorkflowListing[] memory activeListings = new WorkflowListing[](size);
        uint256 currentIndex = 0;
        uint256 skipCount = 0;

        // Collect active listings
        for (uint256 i = 1; i <= totalListings && currentIndex < size; i++) {
            if (listings[i].active) {
                if (skipCount >= start) {
                    activeListings[currentIndex] = listings[i];
                    currentIndex++;
                }
                skipCount++;
            }
        }

        return activeListings;
    }
}
