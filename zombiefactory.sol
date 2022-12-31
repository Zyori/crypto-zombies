pragma solidity  >=0.5.0 <0.6.0;

//Importts ownable contract for inheritence
import "./ownable.sol";

//Solidity contract to create Zombies with random DNA
contract ZombieFactory is Ownable {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days; //always plural, sinleton 'day' won't compile

    //Main Zombie "object" - called a "struct" in Solidity
    struct Zombie {
        string name;
        uint dna;
        uint32 level; //uint32 instead of uint256 to save space
        uint32 readyTime; //uint32 clustered together to save space
    }

    Zombie[] public zombies;

    //Added mapping to store Zombie ownership
    mapping (uint => address) public zombieToOwner;    //keeps track of the address that owns a zombie
    mapping (address => uint) ownerZombieCount;    //keeps track of how many zombies an owner has

    //Creates a new Zombie from name and dna
    function _createZombie(string memory _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1;  //pushes new Zombie and returns id in one line
        zombieToOwner[id] = msg.sender;     //maps address that called the function to the id for ownership
        ownerZombieCount[msg.sender]++;     //maps zombie count + 1 to address that called the function
        emit NewZombie(id, _name, _dna);
    }

    //Uses keccak256 to create random DNA of 16 characters
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    //Creates a Zombie struct with random DNA
    function createRandomZombie(string memory _name) public {
       require(ownerZombieCount[msg.sender] == 0);    //required to be true for the rest to execute
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
