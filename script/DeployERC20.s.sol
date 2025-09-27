// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {CustomERC20} from "../src/ERC20.sol";

// This script is designed to deploy the CustomERC20 token contract.
contract DeployCustomERC20 is Script {

    // --- Configuration Variables ---
    // You can edit these values before running the script.
    string private constant TOKEN_NAME = "OSMO Index Token";
    string private constant TOKEN_SYMBOL = "OSMO";
    // 1,000,000 tokens minted to the deployer
    uint256 private constant INITIAL_MINT_AMOUNT = 1_000_000; 

    // --- Main Deployment Function ---
    function run() public returns (address tokenAddress) {
        
        // 1. Start the deployment transaction batch
        vm.startBroadcast();

        console.log("Starting deployment for %s (%s)...", TOKEN_NAME, TOKEN_SYMBOL);
        console.log("Initial Supply (raw units):", INITIAL_MINT_AMOUNT);

        // 2. Deploy the CustomERC20 contract
        CustomERC20 token = new CustomERC20(
            TOKEN_NAME,
            TOKEN_SYMBOL,
            INITIAL_MINT_AMOUNT
        );

        tokenAddress = address(token);

        console.log("Deployed Token Address: %s", tokenAddress);

        // 3. End the transaction batch and sign
        vm.stopBroadcast();
        
        // 4. (Optional) Verification on Etherscan/Block Explorer
        // This command assumes you have the ETHERSCAN_API_KEY environment variable set.
        // It should be run *after* the deployment transaction is confirmed.
        // Uncomment the line below to perform verification automatically.
        // vm.verify(tokenAddress, TOKEN_NAME, TOKEN_SYMBOL, INITIAL_MINT_AMOUNT);

        console.log("Deployment complete. Verify total supply on-chain:", token.totalSupply());
    }
}
