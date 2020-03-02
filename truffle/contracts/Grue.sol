pragma solidity >=0.4.25 <0.7.0;

contract Grue {
    uint public globalState;
    uint private privateState;
	mapping (address => uint) balances;

	constructor() public {
		balances[tx.origin] = 10000;
        privateState = 42;
	}

    function getPrivateState() public view returns (uint) {
        return privateState;
    }

    function setPrivateState( uint newState) public {
        privateState = newState;
    }

	function deposit(uint amount) public payable returns(bool sucess) {
		balances[msg.sender] += amount;
		return true;
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}
