/*
* This is sample javascript code to display how it could interact with CryptoZombies
* It will allow a Zombie to bite a Kitty and display the dna
* Not written by Zyori
*/

//Initialization
var abi = /* abi generated by the compiler */
var ZombieFeedingContract = web3.eth.contract(abi)
var contractAddress = /* our contract address on Ethereum after deploying */
var ZombieFeeding = ZombieFeedingContract.at(contractAddress)
