// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Lottry{
    address public manager;
    address payable[] public participants;

    constructor(){
        manager=msg.sender;
    }

    receive() external payable { 
        require(msg.value>=1 ether,"Require ether should 1 or more then one ;(");
        participants.push(payable (msg.sender));
    }

    function getBalance() public view returns(uint256) {
        require(msg.sender==manager);
        return address(this).balance;
    }

    function random() public view  returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants)));
    }

    event WinnerSelected(address winner, uint amount);

    function selectRandom() public payable {
        require(msg.sender == manager, "Only the manager can call this function");
        require(participants.length >= 3, "At least three participants are required");

        uint r = random();
        address payable winner;
        uint index = r % participants.length;
        winner = participants[index];
        
        uint balanceBeforeTransfer = address(this).balance;
        payable(winner).transfer(balanceBeforeTransfer); // This line may cause revert

        emit WinnerSelected(winner, balanceBeforeTransfer);
    }
}
