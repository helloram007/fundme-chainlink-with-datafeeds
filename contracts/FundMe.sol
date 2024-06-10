// Get Funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUSD = 5e18;

    // for any function to send or receive funds is make the function payable
    function fund() public payable {
        //Allow users to send $
        // Have a minimum $ sent
        // 1. How do we send ETH to this contract?

        // for ETH to receive or send, you need to use the variable msg.value
        // if you need to check any condition you require function
        require(getConversionRate(msg.value) >= minimumUSD, "didn't send enough ETH/USD, it should be atleast $5"); // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18

        // What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        // Here in the above e.g When the require is success, then myValue is saved as dmyValue + 1, else the action is reverted.


    }

    function getPrice() public view returns (uint256) {
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //Price of ETH interms of USD
        //2000_000000000000000000
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        
        //How much 1ETH in USD?
        
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount ) / 1e18;
        return ethAmountInUSD;
    }

    function getVersion() public view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();

    }
    
    //function withdraw() public {}
}