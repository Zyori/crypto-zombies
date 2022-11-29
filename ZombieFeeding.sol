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
); //looks like function declaration but ends with ; to signify interface
}

contract ZombieFeeding is ZombieFactory {

    //Sets KittyContract to point to the outside ck contract
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);     //declares kittyContract as new variable

    //Allows Zombies to multipy and be affected by what they feed on
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);      //msg.sender must come first in require statements
        Zombie storage myZombie = zombies[_zombieId];       //storage is on blockchain, memory is local to function
        _targetDna  = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }

}
