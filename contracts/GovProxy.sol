// contracts/GovProxy.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GovProxy {
    address public impl; address public admin;
    constructor(address i){impl=i; admin=msg.sender;}
    fallback() external payable {
        address target=impl;
        assembly {
            calldatacopy(0,0,calldatasize())
            let r:=delegatecall(gas(),target,0,calldatasize(),0,0)
            returndatacopy(0,0,returndatasize())
            switch r case 0 {revert(0,returndatasize())} default {return(0,returndatasize())}
        }
    }
}
