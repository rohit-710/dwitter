const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Dtwitter", function () {
  it("Should return the name", async function () {
    const Dtwitter = await ethers.getContractFactory("Dtwitter"); //Dtwitter is the contract factory
    const dtwitter = await Dtwitter.deploy(); //instance of that Dtwitter contract factory
    await dtwitter.deployed();

    expect(await dtwitter.name()).to.equal("Rohit");

    const setName = await dtwitter.setName("Rohit Ramesh");

    // wait until the transaction is mined
    await setName.wait();

    expect(await dtwitter.name()).to.equal("Rohit Ramesh");
  });
});
