const news = artifacts.require("NewsContract_lixi");

contract('test', async accounts =>{
    console.log(accounts);
    it("真实新闻系统测试",async() =>{
        
        var host='0x95d87f7FE4E710A04D2149B374AD65324ED132fb';
        var user='0x8bccBf348cd6d7E9c7aa7F9382DD68066ef69aD4';
        var manager='0x1884dFfCE31E391bAe92AeF43F5f0fD37A399fA0';
        let instance =await news.deployed({from:host});
       
        //用户注册
        await instance.register("熙",user);

        //用户是否存在
        let isUserExist=await instance.isUserExist(user);
        assert.equal(isUserExist,true,"错误！");

        //添加管理员
        await instance.addManager('管理员',manager,{from:host});

        //管理员是否存在
        let isManagerExist=await instance.isManagerExist(manager);
        assert.equal(isManagerExist,true,"错误！");

        //添加一条新闻
        await instance.addNews(user,'放假时间','一月七号',{from:user});

        //新闻是否存在
        let isNewsExist=await instance.isNewsExist(1);
        assert.equal(isNewsExist,true,"错误！")

        //审核新闻
        await instance.checkPass(manager,1,{from:manager});

        //奖励一条新闻
        await instance.rewardNews(1,100,{from:manager});

       //查看累计奖励
       let queryReward=await instance.queryReward(1);
       assert.equal(queryReward,100,"错误！")
    })
})