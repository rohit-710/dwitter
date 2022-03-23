//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Dtwitter{

    string public name = "Rohit";  //Name of the user/tweeter
    //Whatever name we give, the contract will automatically create a getter function 
    //created by default by solidity, which will be named as the variable, in our case "name"
    //so we can just call that function "name" to return the value and that way we can ignore the getName
    //function. This will be called when we run the test file.

    //The above is also a contract storage, which means that it is permanent as it
    // keeps it in its storage space, but the variables we use inside the functions, 
    //we need to declare explicitly if they are the ones in the contract storage or
    //if it is going to be in memory 

    // a constructor will be run when the contract is deployed, a constructor is to
    //initialize the variables wit values, in our case the string "name"
    // we can also directly initialize the string name as "string name = "Rohit" " 
    //and then we wouldnt require a constructor. 

    /*
    constructor(string memory _name) public
    {
        name = _name;
    }
    */

    //function to get name and return name, as you can see that the
    //function is public, which means the function can be accessed publicly
    //and the modfier is set as view which means we cant externally modify
    //the function, only view it

    function getName() public view returns (string memory) 
    {
        return name;
    }

    //"memory" here is a reference type. Values of reference type can
    //be modifed through multiple different names. If we use reference types,
    //we always have to explicitly provide the data area where the type is stored
    //"memory" (whose lifetime is limited to an external function call),
    //"storage" (the location where the state variables are stored, where 
    //the lifetime is limited to the lifetime of a contract) or 
    //"calldata" (special data location that contains the function arguments).

    function setName(string memory _name) public
    {
        name=_name; // _name is temporary allocated memory during the execution of the program, i.e. runtime memory

    }

}