pragma solidity >=0.5.0 <0.6.0;

//Importts other contract for inheritence
import "./zombiefactory.sol";

//Interface to interact with CryptoKitties smart contract
contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
); //looks like function declaration but ends with ; to signify interface from another contract instead of function
}

contract ZombieFeeding is ZombieFactory {

    //Sets KittyContract to point to the outside ck contract
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);     //declares kittyContract as new variable

    //Allows Zombies to multipy and be affected by what they feed on
    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
      require(msg.sender == zombieToOwner[_zombieId]);
      Zombie storage myZombie = zombies[_zombieId];
      _targetDna = _targetDna % dnaModulus;
      uint newDna = (myZombie.dna + _targetDna) / 2;

      //checks to make sure its a kitty and replaces last two digits with 99 to denote
      if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
        newDna = newDna - newDna % 100 + 99;
      }

    //Allows Zombies to feed on a CryptoKitty's DNA
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); //functions that return multiple variables require this syntax
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }

}
