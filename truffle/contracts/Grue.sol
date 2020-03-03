pragma solidity >=0.4.25 <0.7.0;

// pure
// view
// payable
// nonpayable

// TODO: do we need different function visibility public, internal, external? No because not in the JSON ABI
// first filter is to check for function
// view -> cachecall
// pure -> cacheSend
// !view && !pure -> cachesend (can't use this because pure or view funcs without pure/view tags defaults to nonpayable?)
// payable || nonpayable -> cachesend

contract Grue {
    uint256 public publicState;
    uint256 internal internalState;
    uint256 private privateState;
	mapping (address => uint) public balances;
	uint256[] public array;
	address public owner;

	constructor() public {
		publicState = 42;
        privateState = 42;
		balances[msg.sender] = 10000;
		owner = msg.sender;
	}

	// TODO: what if dev leaves out 'pure' and 'view? defaults to nonpayable
	// pure function
	function pureFunc() public pure returns(uint) {
		return 1 + 1;
	}

	function pureFuncWithoutPureTag() public returns(uint) {
		return 1 + 1;
	}

	/*
	* publicState functions
	* getter - built in
	* setter nonpayable
	* setter payable
	*/

	// getter for publicState is in built-in because state var is public, stateMutability is view

	// setter for publicState nonpayable
	function setpublicStateNonPayable(uint256 num) public {
		publicState = num;
	}

	// setter for publicState payable
	function setpublicStatePayable(uint256 num) public payable {
		publicState = num;
	}


	/*
	* internal state functions
	* getter view
	* setter nonpayable
	* setter payable
	*/


	// getter for the privateState
    function getInternalState() public view returns (uint) {
        return internalState;
    }

	// without view tag
	function getInternalStateWithoutViewTag() public returns (uint) {
        return internalState;
    }

	// setter for internalState nonpayable
	function setInternalStateNonPayable(uint256 num) public {
		internalState = num;
	}

	// setter for internalState payable
	function setInternalStatePayable(uint256 num) public payable {
		internalState = num;
	}


	/*
	* private state functions
	* getter view
	* setter nonpayble
	* setter payable
	*/


	// getter for the privateState
    function getPrivateState() public view returns (uint) {
        return privateState;
    }


	// nonpayable setter for private state var
	function setPrivateStateNonPayable( uint newState) public {
        privateState = newState;
    }

	// payable setter for private state var
    function setPrivateStatePayable( uint newState) public payable {
        privateState = newState;
    }

	/*
	* Mapping type functions
	*/

	// deposit getter is built in

	// payable func
	// TODO: ask amal
	// Do we need this function, may be redundant check as we have payable functions already
	function deposit(uint amount) public payable returns(bool sucess) {
		balances[msg.sender] += amount;
		return true;
	}

	// view func for mapping
	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}


}
