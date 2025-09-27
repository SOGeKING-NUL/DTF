// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// NOTE: When running in Remix, ensure you have the OpenZeppelin dependency 
// installed, or import directly from their GitHub/CDN if necessary.
// Remix typically handles these standard imports seamlessly.
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title CustomERC20
 * @dev A simple ERC20 token contract that mints a specified initial supply to the deployer.
 * The total supply is defined by the amount minted in the constructor.
 */
contract CustomERC20 is ERC20, Ownable {

    // Define standard token decimals (10^18 is standard for Ethereum ecosystem)
    uint256 private constant DECIMALS_FACTOR = 10**18;

    /**
     * @notice Constructor initializes the token and mints the initial supply to the deployer.
     * @param name The name of the token (e.g., "OSMO DTF Token")
     * @param symbol The symbol of the token (e.g., "OSMO")
     * @param initialMintAmount The number of tokens (not including decimals) to mint to the deployer.
     * Example: To mint 100,000 tokens, pass 100000.
     */
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialMintAmount
    )
    // Initialize ERC20 with name and symbol
    ERC20(name, symbol)
    // Set the contract deployer (msg.sender) as the initial owner
    Ownable(msg.sender)
    {
        // Convert the human-readable amount into the full unit amount (with 18 decimals)
        uint256 amountInWei = initialMintAmount * DECIMALS_FACTOR;

        // Issue the initial, self-declared supply to the contract deployer.
        // This is the total supply for this token.
        _mint(msg.sender, amountInWei);
    }

    /**
     * @notice Optional: Allows the owner to mint additional tokens.
     * @dev In a truly fixed-supply model, this function would be omitted.
     * Included here for simple testing/re-issuance by the owner.
     * @param to The address to receive the minted tokens.
     * @param amount The number of tokens (in full units, with decimals) to mint.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
