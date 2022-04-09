//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Dwitter{
    struct User{  //struct for user, contains wallet address and user name, bio and avatar
        address wallet;
        string name;
        string username;
        string bio;
        string avatar;
    }

    struct Dweet{ //struct for the dweeter, contains the user, the dweet text, the dweet time and the dweet id
        address author;
        string content;
        uint256 timestamp;
        uint likes;
        string avatar;
    }

    Dweet[] public dweets;

    mapping(address => string) public usernames; //mapping of address (wallet) to username
    mapping(string => User) public users; //mapping of username to user struct, it is also to validate and check if the username has not already been taken

    //mapping(string => Dweet) public dweets; //mapping of dweet id to dweet struct

    function signup(string memory _username, string memory _name, string memory _bio, string memory _avatar) public {

        require(bytes(usernames[msg.sender]).length == 0, "The user already exists, try again.");  //To make sure that the user can only sign up once
        require(users[_username].wallet == address(0), "The username is already taken, please try another one."); //To make sure that the username has not already been taken

        users[_username] = User({
            wallet: msg.sender,
            name: _name,
            username: _username,
            bio: _bio,
            avatar: _avatar
        });
        usernames[msg.sender] = _username;
    }

    function getUser(address _wallet) public view returns (User memory) { //function to get user struct from wallet address
        return users[usernames[_wallet]]; //returns the user struct of the user with the wallet address
    }

    function postDweet(string memory _content) public {
        require(bytes(usernames[msg.sender]).length>0, "You need to sign up first to post a Dweet."); //To make sure that the user has signed up
        require(bytes(_content).length>0, "The Dweet content cannot be empty."); //To make sure that the dweet content is not empty
        require(bytes(_content).length<=140, "The Dweet content cannot be longer than 140 characters."); //To make sure that the dweet content is not longer than 140 characters

        Dweet memory dweet = Dweet({
            author: msg.sender, 
            content: _content,
            timestamp: block.timestamp,
            likes: 0,
            avatar: users[usernames[msg.sender]].avatar

        });
        dweets.push(dweet);
    }

    function getDweets() public view returns (Dweet[] memory) {
        return dweets;
    }





    /*
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

    
    constructor(string memory _name) public
    {
        name = _name;
    }
    

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
    */

}