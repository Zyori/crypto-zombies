pragma solidity  >=0.5.0 <0.6.0;

//Solidity contract to create Zombies with random DNA
contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    //Main Zombie "object" - called a "struct" in Solidity
    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    //Creates a new Zombie from name and dna
    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    //Uses keccak256 to create random DNA of 16 characters
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    //Creates a Zombie struct with random DNA
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
