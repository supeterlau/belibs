// Copyright © 2021 Peter Lau <superpeterlau@outlook.com>
//
// Distributed under terms of the MIT license.

pragma solidity >=0.4.16 <0.9.0;

contract Election {
  string public candidate;

  event votedEvent (
    uint indexed _candidateId
  );

  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }

  // Read / Write
  mapping(uint => Candidate) public candidates;

  uint public candidatesCount;

  mapping(address => bool) public voters;

  // function Election () public {
  //   candidate = "Pony";
  // }

  function addCandidate(string memory _name) private {
    // 更新 candidates count cache
    candidatesCount++;
    // 创建 candidate
    // 第一个候选人编号为 1
    candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
  }

  function vote (uint _candidateId) public {
    require(!voters[msg.sender]);
    // assert(!voters[msg.sender]);
    // require(voters[msg.sender] == false);
    require(_candidateId > 0 && _candidateId <= candidatesCount);

    voters[msg.sender] = true;
    candidates[_candidateId].voteCount++;

    // trigger voted event
    emit votedEvent(_candidateId);
  }

  constructor() public {
    // candidate = "Pony";
    addCandidate("Pony");
    addCandidate("Carl");
  }

}
