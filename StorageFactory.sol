// SPDX-License-Identifier: MIT
pragma solidity 0.8.18 ;
import {SimpleStorage} from "./storage.sol";

contract StorageFactory{

    SimpleStorage[] public ListofSimpleStorage;

    function createSimpleStorage() public{
        SimpleStorage simpleStorage = new  SimpleStorage();
        ListofSimpleStorage.push(simpleStorage);

    }

    function sfStore(uint256 x, uint256 y) public{
        SimpleStorage store = ListofSimpleStorage[x];
        store.store(y);
    }

    function sfGet(uint256 simpleStorageIndex) public view returns (uint256) {
        return ListofSimpleStorage[simpleStorageIndex].retrieve();

    }

}
