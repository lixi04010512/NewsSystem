const web3 = new Web3(Web3.givenProvider);

var myContract = new web3.eth.Contract(abi, a);
var myContract1 = new web3.eth.Contract(abi1,b);

let lixiaccounts=[];
web3.eth.getAccounts().then(function(accounts){
    lixiaccounts=accounts;
});

$("#confirm").click(function(){
    var key =$("#key").val();

    myContract.methods.queryCtx(key).call().then(
        function(res){
            $("#title").val(res[1]);
            $("#content").val(res[2]);
            $("#money").val(res[3]);
            $("#addr").val(res[0]);
            $("#number").val(res[4]);
        }
    );
})

$("#pass").click(function(){
    var key =$("#key").val();
    var reward =$("#reward").val();

    myContract.methods.rewardNews(key,reward).send({
        from:lixiaccounts[0],
        gasPrice: '100000000',
        gas: 1000000
    });
    var addre = $("#addr").val();
    myContract1.methods.transfer(addre,reward).send({
        from:lixiaccounts[0],
        gasPrice: '100000000',
        gas: 1000000
    });
})