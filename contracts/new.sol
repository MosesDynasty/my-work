 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PhysicsElection{

    struct Candidate{
        uint256 id;
        string name;
        uint256 voteCount;
    }

    enum Position { President, SenatePresident, Secretary, FinancialSecretary }

    mapping(Position => mapping(uint256 => Candidate)) public candidates;
    mapping(Position => uint256) public candidatesCount;
    mapping(address => mapping(Position => bool)) public voters;

    event VotedEvent(Position indexed position, uint256 indexed candidateId);

    constructor() {
        addCandidate(Position.President, "Moses");
        addCandidate(Position.President, "Chike");
        addCandidate(Position.Secretary, "David");
        addCandidate(Position.Secretary, "Abdul");
        addCandidate(Position.FinancialSecretary, "Ngozi");
        addCandidate(Position.FinancialSecretary, "Emeka");
    }

    function addCandidate(Position _position, string memory _name) private {
        candidatesCount[_position]++;
        candidates[_position][candidatesCount[_position]] = Candidate(candidatesCount[_position], _name, 0);
    }

    function vote(Position _position, uint256 _candidateId) public {
        require(!voters[msg.sender][_position], "Already voted for this position.");
        require(_candidateId > 0 && _candidateId <= candidatesCount[_position], "Invalid candidate.");

        voters[msg.sender][_position] = true;
        candidates[_position][_candidateId].voteCount++;

        emit VotedEvent(_position, _candidateId);
    }

    function getWinner(Position _position) public view returns (string memory winnerName) {
        uint256 maxVotes = 0;
        for (uint256 i = 1; i <= candidatesCount[_position]; i++) {
            if (candidates[_position][i].voteCount > maxVotes) {
                maxVotes = candidates[_position][i].voteCount;
                winnerName = candidates[_position][i].name;
            }
        }
    }
}
