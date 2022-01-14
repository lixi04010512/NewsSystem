const web3 = new Web3(Web3.givenProvider);

var myContract = new web3.eth.Contract(abi, a);
var myContract1 = new web3.eth.Contract(abi1,b);

//获取host地址
var host;
myContract.methods.searchHost().call().then(
    function(res){
        host=res;
    }
)

$("#confirm").click(function(){
    var name =$("#addName").val();
    var addr =$("#addAddr").val();
    myContract.methods.addManager(name,addr).send({
        from:host,
        gasPrice: '100000000',
        gas: 1000000
     });
})
$("#search").click(function(){
    var Addr =$("#Addr").val();
    myContract.methods.isManagerExist(Addr).call().then(
        function(res){
            if(res == true){
                alert("管理员已注册，存在！")
            }else{
                alert("管理员未注册，不存在！")
            }
        }
    )
})