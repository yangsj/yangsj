package datas
{


	/**
	 * 说明：RolesID
	 * @author Victor
	 * 2012-10-3
	 */

	public class RolesID
	{

		/**
		 * 人物 [id] 命名字段的前缀
		 */
		public static const TYPE_ROLE_ID : String = "ROLE_ID_";

		/**
		 * 人物 [名字] 命名字段的前缀
		 */
		public static const TYPE_ROLE_NAME : String = "ROLE_NAME_";


		/** 可以使用人人物资源id  */
		public static const canUseRoleId : Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21];

		/** 当前用户能使用的人物资源id */
		public static const canUseForUserRoleId : Array = [5, 10, 11, 13, 14, 15, 18, 19, 20, 21];

		/** 有技能的人物id */
		public static const canUseSkillRoleId : Array = [14, 20, 19];

		/** 默认编队的人物id */
		public static const defalutSelectedRoleId : Array = [14, 19, 20];

		/** 默认等待编队的人物id */
		public static const defalutWaitingRoleId : Array = [5, 10, 11, 13, 15, 18];

		//////////////////////////////////////////

		public static function getName(id : int) : String
		{
			return RolesID[TYPE_ROLE_NAME + id];
		}

		//////////////////// 人物id /////////////////////////////////////////////////////////////

		/** 虾兵 */
		public static const ROLE_ID_0 : int = 0;

		/** 小骑兵 */
		public static const ROLE_ID_1 : int = 1;

		/** 小弓手兵 */
		public static const ROLE_ID_2 : int = 2;

		/** 精细伶俐虫 */
		public static const ROLE_ID_3 : int = 3;

		/** 天兵 */
		public static const ROLE_ID_4 : int = 4;

		/** 山神 */
		public static const ROLE_ID_5 : int = 5;

		/** 魔礼寿 */
		public static const ROLE_ID_6 : int = 6;

		/** 魔礼青 */
		public static const ROLE_ID_7 : int = 7;

		/** 魔礼红 */
		public static const ROLE_ID_8 : int = 8;

		/** 魔礼海 */
		public static const ROLE_ID_9 : int = 9;

		/** 黄狮精 */
		public static const ROLE_ID_10 : int = 10;

		/** 沙僧 */
		public static const ROLE_ID_11 : int = 11;

		/** 铁扇公主 */
		public static const ROLE_ID_12 : int = 12;

		/** 白骨夫人 */
		public static const ROLE_ID_13 : int = 13;

		/** 猪八戒 */
		public static const ROLE_ID_14 : int = 14;

		/** 托塔天王 */
		public static const ROLE_ID_15 : int = 15;

		/** 唐三藏 */
		public static const ROLE_ID_16 : int = 16;

		/** 红孩儿 */
		public static const ROLE_ID_17 : int = 17;

		/** 牛魔王 */
		public static const ROLE_ID_18 : int = 18;

		/** 二郎神杨戬 */
		public static const ROLE_ID_19 : int = 19;

		/** 孙悟空 */
		public static const ROLE_ID_20 : int = 20;

		/** 太上老君 */
		public static const ROLE_ID_21 : int = 21;

		//////////////////// 人物name /////////////////////////////////////////////////////////////

		/** 虾兵 */
		public static const ROLE_NAME_0 : String = "虾兵";

		/** 小骑兵 */
		public static const ROLE_NAME_1 : String = "小骑兵";

		/** 小弓手兵 */
		public static const ROLE_NAME_2 : String = "小弓手兵";

		/** 精细伶俐虫 */
		public static const ROLE_NAME_3 : String = "精细伶俐虫";

		/** 天兵 */
		public static const ROLE_NAME_4 : String = "天兵";

		/** 山神 */
		public static const ROLE_NAME_5 : String = "山神";

		/** 魔礼寿 */
		public static const ROLE_NAME_6 : String = "魔礼寿";

		/** 魔礼青 */
		public static const ROLE_NAME_7 : String = "魔礼青";

		/** 魔礼红 */
		public static const ROLE_NAME_8 : String = "魔礼红";

		/** 魔礼海 */
		public static const ROLE_NAME_9 : String = "魔礼海";

		/** 黄狮精 */
		public static const ROLE_NAME_10 : String = "黄狮精";

		/** 沙僧 */
		public static const ROLE_NAME_11 : String = "沙僧";

		/** 铁扇公主 */
		public static const ROLE_NAME_12 : String = "铁扇公主";

		/** 白骨夫人 */
		public static const ROLE_NAME_13 : String = "白骨夫人";

		/** 猪八戒 */
		public static const ROLE_NAME_14 : String = "八戒";

		/** 托塔天王 */
		public static const ROLE_NAME_15 : String = "李靖";

		/** 唐三藏 */
		public static const ROLE_NAME_16 : String = "三藏 ";

		/** 红孩儿 */
		public static const ROLE_NAME_17 : String = "红孩儿";

		/** 牛魔王 */
		public static const ROLE_NAME_18 : String = "牛魔王";

		/** 二郎神杨戬 */
		public static const ROLE_NAME_19 : String = "杨戬";

		/** 孙悟空 */
		public static const ROLE_NAME_20 : String = "悟空";

		/** 太上老君 */
		public static const ROLE_NAME_21 : String = "老君";



		public function RolesID()
		{

		}


	}

}
