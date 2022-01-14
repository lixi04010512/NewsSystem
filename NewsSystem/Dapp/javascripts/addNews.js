const web3 = new Web3(Web3.givenProvider);

var myContract = new web3.eth.Contract(abi, a);
var myContract1 = new web3.eth.Contract(abi1,b);

$("#confirm").click(function(){
    var addr =$("#addAddr").val();
    var title =$("#addTitle").val();
    var content =$("#addContent").val();
    
    myContract.methods.addNews(addr,title,content).send({
        from:addr,
        gasPrice: '100000000',
        gas: 1000000
    });
    window.location ="./FirstPage.html";
})