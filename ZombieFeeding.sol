pragma solidity >=0.5.0 <0.6.0;

//Importts other contract for inheritence
import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

    //Allows Zombies to multipy and be affected by what they feed on
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);      //msg.sender must come first in require statements
        Zombie storage myZombie = zombies[_zombieId];       //storage is on blockchain, memory is local to function
        _targetDna  = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }

}
