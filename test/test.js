const {expect} = require("chai");
const { hexStripZeros } = require("ethers/lib/utils");
const {ethers} = require("hardhat");

describe("CONTRACT", function() {

    let multiSender;
    let owner, addr1, addr2;

    beforeEach(async function() {
        const MultiSender = await hre.ethers.getContractFactory("MultiSender");
        multiSender = await MultiSender.deploy();
        await multiSender.deployed();

        [owner, addr1, addr2] = await ethers.getSigners();
    });
    
    
    it("Should succesfully deploy", async function (){
       console.log("success");
    });

    







});