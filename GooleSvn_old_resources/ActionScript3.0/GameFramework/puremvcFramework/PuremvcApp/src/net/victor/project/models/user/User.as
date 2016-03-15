package net.victor.project.models.user
{
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-11-16 下午01:11:03
	 */
	public class User
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function User()
		{
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		static public const fields:Array = 
			[
				"uid", "name", "pass", "mail", "mode", "created", "access", "login", "status", "picture", "friends", "order",
				"appfriends", "city", "sex", "money", "gold", "heart", "experience", "last_score", "last_exp", "wscore", "hscore", "tscore", "a_number",
				"b_number", "c_number", "ep_timeout", "level", "heart_recover","nextchallenge", "panel","bonus", "nextbonus", "levelup", "last_level",
				"last_top3", "is_newperiod", "last_p_order", "last_p_wscore", "fristlogin", "play_number", "unlock", "is_guide",
				"add_gold", "is_to_ep", "house_level"
			]
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public var uid:String = "16";
		
		public var name:String = "el_16";
		
		public var pass:String = "el_16";
		
		public var mail:String = "el_16@jt-tech.net";
		
		public var mode:String = "0";
		
		public var created:Number = 1320986701;
		
		public var access:Number = 1321406807;
		
		public var login:Number = 1320986701;
		
		public var status:int = 1;
		
		public var picture:String = "http://hdn.xnimg.cn/photos/hdn311/20090408/13/40/tiny_B6C0_45613h204234.jpg";
		
		public var friends:String = "1,12,19,35,36,49";
		
		public var appfriends:String = " 1,12,19,35,36,49";
		
		public var city:String = " ";
		
		public var sex:int = 0;
		
		public var bonus:Number = 0;
		
		/**
		 * 当前  升bonus的下个等级差
		 */
		public var nextbonus:Number = 0;
		
		public var money:Number = 80000;
		
		public var gold:Number = 600;
		
		public var heart:Number = 5;
		
		/**
		 * 排名
		 */
		public var order:Number = 1;
		
		/**
		 * 是否可以升级
		 */
		public var levelup:Number = 0;
		
		/**
		 * 总经验值
		 */
		public var experience:Number = 0;
		
		/**
		 * 上一局获得经验值
		 */
		public var last_exp:Number = 0;
		
		/**
		 * 上一局得分
		 */
		public var last_score:Number = 0;
		
		/**
		 * 一个周期的最高分
		 */
		public var wscore:Number = 0;
		
		/**
		 * 历史记录 最高分
		 */
		public var hscore:Number = 0;
		
		/**
		 * 累积总得分
		 */
		public var tscore:Number = 0;
		
		/**
		 * 获得第一名的次数
		 */
		public var a_number:Number = 0;
		
		/**
		 * 获得第二名的次数
		 */
		public var b_number:Number = 0;
		
		/**
		 * 获得第三名的次数
		 */
		public var c_number:Number = 0;
		
		public var ep_timeout:Number = 0;
		
		/**
		 * 长度为 3 ， 第一个值为 等级 level 、第二个值为 升级进度 rate 、第三个值为 升到下一个等级的 分数
		 */
		public var level:Array = [1,0.03,100];
		
		/**
		 * 升级前的等级信息
		 */
		public var last_level:Array = [];
		
		/**
		 * 恢复体力值 （红心）的截止时间
		 */
		public var heart_recover:Number = 0;
		
		public var nextchallenge:Object;
		
		/**
		 * 1 初次登陆 邀请好友
		 * 2 排名第一时的登陆
		 * 3 排名第一时挑战结束
		 * 4 排名不是第一时的登陆
		 * 5 排名不是第一时的挑战结束
		 */
		public var panel:int = 0;
		
		/**
		 * 上周期前三名数据
		 */
		public var last_top3:Array = [];
		
		/**
		 * 是否是一个新的周期
		 */
		public var is_newperiod:Number = 0;
		
		/**
		 * 用户上周期的排名
		 */
		public var last_p_order:int = 0;
		
		/**
		 * 用户上周期的周期最高分
		 */
		public var last_p_wscore:Number = 0;
		
		/**
		 * 是否是新注册的用户  0为新注册用户  1为不是新注册用户
		 */
		public var fristlogin:Number = 0;
		
		/**
		 * 新手引导中玩了几局游戏
		 */
		public var play_number:int = -1;
		
		/**
		 * 道具解锁，0为没有要解锁的道具，大于0对应数值表中解锁道具顺序
		 */
		public var unlock:int = -1;
		
		/**
		 * 是否还处于新手引导阶段 （0为新手引导，1为非新手引导）
		 */
		public var is_guide:int = 0;
		
		/**
		 * gold 升级奖励值
		 */
		public var add_gold:int = 0;
		
		/**
		 * 1为访问过（不能访问 // 0为未访问（能访问
		 */
		public var is_to_ep:int = 0;
		
		/**
		 * 当前将要拆毁的房子等级
		 */
		public var house_level:int = 0;
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}