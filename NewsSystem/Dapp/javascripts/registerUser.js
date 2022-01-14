const web3 = new Web3(Web3.givenProvider);

var myContract = new web3.eth.Contract(abi, a);
var myContract1 = new web3.eth.Contract(abi1,b);

$("#confirm").click(function(){
    var name =$("#addName").val();
    var addr =$("#addAddr").val(); 
     myContract.methods.register(name,addr).send({
        from:addr,
        gasPrice: '100000000',
        gas: 1000000
     });
})

$("#search").click(function(){
    var Addr =$("#Addr").val();
    myContract.methods.isUserExist(Addr).call().then(
        function(res){
            if(res == true){
                alert("用户已注册，存在！")
            }else{
                alert("用户未注册，不存在！")
            }
        }
    );
})