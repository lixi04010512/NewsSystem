//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

contract NewsContract_lixi {
    
 //新闻主持人
 address public host_lixi;
 
 //记录一则新闻
 struct News_lixi {
  address addr;
  string newsCxt;
  string newsContent;
  uint accumulate;
  bool exist;
  bool pass;
  uint key;
 }

 //记录注册用户
 struct User_lixi {
   string name;
   address addr;
   bool exist;
 }

 //记录管理员
 struct Manager_lixi {
   string name;
   address addr;
   bool exist;
 }
    
 //存储所有新闻
 mapping(uint => News_lixi) public newsData;

 //存储所有用户
 mapping(address => User_lixi) usersData;

 //存储所有管理员
 mapping(address => Manager_lixi) managersData;
    
 //总新闻数
 uint public newsCnt_lixi;
 
 //得到最多奖励的新闻之键（Key）
 uint public maxRewardNews_lixi;
    
 //添加新闻事件
 event AddNewsEvt(string indexed eventType, uint newsKey);
 
 //奖励新闻事件
 event RewardEvt(string indexed eventType, address sender, uint value);
 
 //记录受益人
 constructor ()  {
   host_lixi = msg.sender;
 }
 
 //只有主持人可执行 
 modifier onlyHost() {
   require(msg.sender == host_lixi,
   "only host can do this");
    _;
 }

 //只有管理员可执行
 modifier onlyManager(address addr) {
   require(managersData[addr].exist == true);
   require(msg.sender == addr,
   "only manager can do this");
   _;
 }

//查看受益人
function searchHost() public view returns(address addr){
  return host_lixi;
}

 //用户注册
 function register(string memory name,address addr) public {
    usersData[addr].name=name;
    usersData[addr].addr=addr;
    usersData[addr].exist=true;
 }

 //用户是否存在
 function isUserExist(address addr) public view returns (bool){
    return usersData[addr].exist;
 }

 //查询用户信息
 function Users(address addr) public view returns(string memory name){
     return usersData[addr].name;
 }

 //添加管理员
 function addManager(string memory name,address addr) public onlyHost {
   managersData[addr].name=name;
   managersData[addr].addr=addr;
   managersData[addr].exist=true;
 }

 //管理员是否存在
 function isManagerExist(address addr) public view returns(bool){
     return managersData[addr].exist;
 }

  //查询管理员信息
 function Managers(address addr) public view returns(string memory name){
     return managersData[addr].name;

 }
    
 //添加一则新闻
 function addNews(address addr,string memory newsCxt,string memory newsContent) public returns(uint) {
   require(usersData[addr].exist ==true);
   //发布总量加1
   newsCnt_lixi++;
         
   newsData[newsCnt_lixi].addr=addr;      
   newsData[newsCnt_lixi].newsCxt = newsCxt;
   newsData[newsCnt_lixi].newsContent=newsContent;
   newsData[newsCnt_lixi].accumulate = 0;
   newsData[newsCnt_lixi].exist = true;
   newsData[newsCnt_lixi].key=newsCnt_lixi;
 
   //触发添加新闻事件
   emit AddNewsEvt("NewsAdd", newsCnt_lixi);
      
   return newsCnt_lixi;
 }
 
 //奖励一则新闻
 function rewardNews(uint newsKey,uint money) public  {
   //主持人不可以奖励
   require(msg.sender != host_lixi, "host can not reward it");

   //发布人不可以奖励自己
   require(msg.sender != newsData[newsKey].addr, "poster can not reward himself");
 
   //奖励金需大于0
   require(money > 0, "reward value need grater than 0");
 	
   //新闻必须存在  
   require(newsData[newsKey].exist, "news not exist");
 	  
   //累加奖励  
   newsData[newsKey].accumulate += money;
     
   //判断是否置换最高奖励的新闻
   if (newsData[newsKey].accumulate > newsData[maxRewardNews_lixi].accumulate)
    maxRewardNews_lixi = newsKey;
 
   //触发奖励事件
   emit RewardEvt("Reward", msg.sender, money);
 }
 
 //查询新闻是否存在
 function isNewsExist(uint newsKey) public view returns(bool) {

   return newsData[newsKey].exist;
 }

 //查看新闻总数
 function totalNews() public view returns(uint){

   return newsCnt_lixi;
 }

 //审核新闻通过
function checkPass(address addr,uint newsKey) public onlyManager(addr){
    newsData[newsKey].pass =true;
     
}

//审核新闻未通过
function checkOut(address addr,uint newsKey) public onlyManager(addr){
    newsData[newsKey].pass =false;
}
    
 //阅读新闻内容
 function queryCtx(uint newsKey) public view returns(address,string memory,string memory,uint,uint) {
   
   //新闻必须存在  
   require(newsData[newsKey].exist,
 	  "news not exist");

   //新闻必须通过
   require(newsData[newsKey].pass ==true,
   "news not pass");  
 	  
   return (newsData[newsKey].addr,newsData[newsKey].newsCxt,newsData[newsKey].newsContent,newsData[newsKey].accumulate,newsData[newsKey].key);

}
    
 //查询新闻累积奖励
 function queryReward(uint newsKey) public view returns(uint) {
 
  //新闻必须存在  
  require(newsData[newsKey].exist,
 	  "news not exist");
  
  //新闻必须审核通过
  require(newsData[newsKey].pass == true,
     "news not pass");   
 	  
  return newsData[newsKey].accumulate;

  }


}