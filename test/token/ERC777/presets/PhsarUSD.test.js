// Right click on the script name and hit "Run" to execute
(async () => {
  try {
    console.log('Running test_phsarusd script...');

    const contractName = 'PhsarUSD'; // Change this for other contract
    const constructorArgs = [];    // Put constructor args (if any) here for your contract

    // Note that the script needs the ABI which is generated from the compilation artifact.
    // Make sure contract is compiled and artifacts are generated
    const artifactsPath = `browser/contracts/artifacts/${contractName}.json` // Change this for different path

    const metadata = JSON.parse(await remix.call('fileManager', 'getFile', artifactsPath));
    const accounts = await web3.eth.getAccounts();
    const creatorAccount = '0xB094A617eb3C8aB075398412052A33304508F8F2';
    const operatorAccount = '0x829d48918ba935A87BB04F134F64986451CA99c4';
    const normalAccount = '0x741AAA0194702BbBE66C7C1B3ae1EC3EA0E57345';

    let contract = new web3.eth.Contract(metadata.abi, '0x953401AD7b9B421d2b5C5c6f693e994197DeFAE5');

    const decimals = await contract.methods.decimals().call();

    var r = '';

    // r = await contract.methods.mint(
    //     creatorAccount,
    //     web3.utils.toBN(10).pow(web3.utils.toBN(18)).mul(web3.utils.toBN(1000)),
    //     '0x', '0x').send({
    //         from: accounts[0]
    //     });
    // console.log("mint to creator: ", r);

    // r = await contract.methods.mint(
    //     operatorAccount,
    //     web3.utils.toBN(10).pow(web3.utils.toBN(18)),
    //     '0x', '0x').send({
    //         from: accounts[0]
    //     });
    // console.log("mint to non-creator: ", r);


    // r = await contract.methods.operatorBurn(
    //     creatorAccount,
    //     web3.utils.toBN(10).pow(web3.utils.toBN(18)), '0x', '0x').send({
    //         from: accounts[0]
    //     });
    // console.log("burn from creator: ", r);

    // r = await contract.methods.operatorBurn(
    //     operatorAccount,
    //     web3.utils.toBN(10).pow(web3.utils.toBN(18)), '0x', '0x').send({
    //         from: accounts[0]
    //     });
    // console.log("burn from non-creator: ", r);


    r = await contract.methods.operatorSend(
      normalAccount,
      operatorAccount,
      web3.utils.toBN(10).pow(web3.utils.toBN(18)), '0x', '0x').send({
        from: accounts[0]
      });
    console.log("operatorSend from non-operator: ", r);

    // r = await contract.methods.operatorSend(
    //     creatorAccount, 
    //     operatorAccount,
    //     web3.utils.toBN(10).pow(web3.utils.toBN(18)), '0x', '0x').send({
    //         from: accounts[0]
    //     });
    // console.log("operatorSend from creator: ", r);

    // r = await contract.methods.operatorSend(
    //     operatorAccount, 
    //     normalAccount,
    //     web3.utils.toBN(10).pow(web3.utils.toBN(18)), '0x', '0x').send({
    //         from: accounts[0]
    //     });
    // console.log("operatorSend from operator: ", r);



    // r = await contract.methods.authorizeOperator(operatorAccount).send({
    //         from: accounts[0]
    //     });
    // r = await contract.methods.isOperatorFor(operatorAccount, accounts[0]).call();
    // console.log("result: ", r);

    // r = await contract.methods.revokeOperator(operatorAccount).send({
    //         from: accounts[0]
    //     });
    // r = await contract.methods.isOperatorFor(operatorAccount, accounts[0]).call();
    // console.log("result: ", r);

    // r = await contract.methods.revokeOperator(creatorAccount).send({
    //         from: accounts[0]
    //     });
    // r = await contract.methods.isOperatorFor(creatorAccount, accounts[0]).call();
    // console.log("result: ", r);


    // r = await contract.getPastEvents('allEvents');
    // console.log("result: ", r);


    r = await contract.methods.totalSupply().call();
    console.log("totalSupply: ", r);
  } catch (e) {
    console.log(e.message)
  }
})()