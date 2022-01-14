const web3 = new Web3(Web3.givenProvider);

var myContract = new web3.eth.Contract(abi, a);
var myContract1 = new web3.eth.Contract(abi1,b);

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