// Get Funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUSD = 5e18;

    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;
    address[] public funders;

    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUSD, "didn't send enough ETH/USD, it should be atleast $5"); // 1e18 = 1 ETH = 1000000000000000000 = 1 * 10 ** 18
        funders.push(msg.sender);
    }

    
    function withdraw() public {
        // for loop
        // [1,2,3,4] elements
        // 0,1,2,3 indexes
        // for (/* starting index, ending index, step amount*/ )
        for(uint256 funderIndex; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);
        // actually withdraw the funds
        
        // three different ways to send
        //transfer
        //send
        //call

        //msg.sender = address
        //payable(msg.sender) = payable address

        //transfer method, gas is set to 2300, if it fails, it throws an error and reverts the txn.
        payable(msg.sender).transfer(address(this).balance);
        //send method, gas is set to 2300, if it fails, it returns true or false
        bool sendSuccess = payable (msg.sender).send(address(this).balance);
        // send will only revert the transaction  if the below statement is added.
        require(sendSuccess, "Send Failed");
        //call
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
        
    }
}