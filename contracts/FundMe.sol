// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUSD = 5e18;

    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;
    address[] public funders;

    // for any function to send or receive funds is make the function payable
    function fund() public payable {
        //Allow users to send $
        // Have a minimum $ sent
        // 1. How do we send ETH to this contract?
        // for ETH to receive or send, you need to use the variable msg.value
        // if you need to check any condition you require function

        require(msg.value.getConversionRate() >= minimumUSD, "didn't send enough ETH/USD, it should be atleast $5"); // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18

        // When anyone funds, we will store them in an array called funders

        funders.push(msg.sender);

        // What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
        // Here in the above e.g When the require is success, then myValue is saved as dmyValue + 1, else the action is reverted.
    }
    //function withdraw() public {}
}