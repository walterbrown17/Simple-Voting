// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleVoting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    address public owner;
    bool public votingActive;
    uint public candidatesCount;
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    constructor() {
        owner = msg.sender;
        votingActive = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action.");
        _;
    }

    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function startVoting() public onlyOwner {
        votingActive = true;
    }

    function endVoting() public onlyOwner {
        votingActive = false;
    }

    function vote(uint _candidateId) public {
        require(votingActive, "Voting is not active.");
        require(!hasVoted[msg.sender], "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;
    }

    function getCandidate(uint _id) public view returns (string memory, uint) {
        require(_id > 0 && _id <= candidatesCount, "Candidate does not exist.");
        Candidate memory c = candidates[_id];
        return (c.name, c.voteCount);
    }
}
