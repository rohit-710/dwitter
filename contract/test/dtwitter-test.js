const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Dwitter", function () {
  it("Test Dwitter sign up flow", async function () {
    const Dwitter = await ethers.getContractFactory("Dwitter"); //Dwitter is the contract factory
    const [user1, user2] = await ethers.getSigners(); //get the signer
    const dwitter = await Dwitter.deploy(); //instance of that Dwitter contract factory
    await dwitter.deployed();

    await dwitter.signup("Rohit710", "Rohit", "Wagmi", "some url");
    console.log("Signing up user for Rohit710");

    //Test if the user is added to the list of users
    const user = await dwitter.users("Rohit710");
    expect(user.name).to.equal("Rohit");
    expect(user.bio).to.equal("Wagmi");
    expect(user.avatar).to.equal("some url");
    console.log("Test Sign up is Successful!");

    //Test for getUser
    const userFromAddress = await dwitter.getUser(user1.address);
    expect(userFromAddress.username).to.equal("Rohit710")
    expect(userFromAddress.name).to.equal("Rohit");
    expect(userFromAddress.bio).to.equal("Wagmi");
    expect(userFromAddress.avatar).to.equal("some url");
    console.log("Test Sign up is Successful!");

    expect(await dwitter.usernames(user1.address)).to.equal("Rohit710");

    //Test for an existing user to sign up
    await expect (dwitter.signup("","","","")).to.be.revertedWith("The user already exists, try again.");
    console.log("Test user already exists, hence an error is expected");

    //Test for a new user to sign up with an existing username
    await expect (dwitter.connect(user2).signup("Rohit710","Ramesh","Some bio","someAvatar")).to.be.revertedWith("The username is already taken, please try another one.");
    console.log("Test username is already taken, please try another.");

    await dwitter.postDweet("Hello World");
    expect((await dwitter.dweets(0)).content).to.equal("Hello World");
    console.log("Test postDweet is Successful!");
    //console.log(dweet);

    const dweets = await dwitter.getDweets();
    expect((await dweets[0]).content).to.equal("Hello World");
    console.log("Test getDweets is Successful!");

    /*
    expect(await dtwitter.name()).to.equal("Rohit");

    const setName = await dtwitter.setName("Rohit Ramesh");

    // wait until the transaction is mined
    await setName.wait();

    expect(await dtwitter.name()).to.equal("Rohit Ramesh");
    */
  });
});
