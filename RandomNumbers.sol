//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract Oracle {
  address public admin;
  uint public randomNum;

  constructor() {
    admin = msg.sender;
  }

  function getRandomNum(uint256 _randomNum) public {
    require(msg.sender == admin, "Only the admin can call this function");
    randomNum = _randomNum;
  }
}

contract RandomNumbers {
  Oracle oracle;
  uint256 private counter;

  constructor(address oracleAddress) {
    oracle = Oracle(oracleAddress);
  }

  function randModulusUnSafe(uint256 maxNum) external view returns (uint256) {
    //+-The Function "abi.encodePacked(***)" will calculate a Hash( https://www.geeksforgeeks.org/what-is-hashing-in-solidity/ ).
    return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % maxNum;
  }

  function randModulusSafeWithOracle(uint256 maxNum) external view returns (uint256) {
    //+-The Function "abi.encodePacked(***)" will calculate a Hash( https://www.geeksforgeeks.org/what-is-hashing-in-solidity/ ).
    return uint256(keccak256(abi.encodePacked(oracle.randomNum, block.timestamp, block.difficulty, msg.sender))) % maxNum;
  }

  function randModulusSafeWithCounter(uint256 maxNum) external returns (uint256) {
    counter++;
    //+-The Function "abi.encodePacked(***)" will calculate a Hash( https://www.geeksforgeeks.org/what-is-hashing-in-solidity/ ).
    return uint256(keccak256(abi.encodePacked(oracle.randomNum, block.timestamp, block.difficulty, msg.sender))) % maxNum;
  }
}