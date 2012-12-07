package datas
{

	import flash.utils.Dictionary;
	
	import manager.LocalStoreManager;
	
	import view.ectypal.EctypalType;


	/**
	 * 说明：EctypalDataClass
	 * @author Victor
	 * 2012-10-1
	 */

	public class EctypalData
	{

		/**
		 * 该部分需要存储记录的数据：
		 *
		 * 1、当前停留查看的副本id编号
		 * 2、打过或正在打的副本的数据
		 *
		 * 数据结构
		 * Array：
		 * [
		 * 		[0]:
		 * 			[
		 * 				[0]:
		 * 				{
		 * 					level : 1, 		// 关卡编号
		 * 					status : 2,		// 关卡状态：1=未解锁 / 2=已解锁但未过关 / 3=已胜利
		 * 					type : 1,		// 关卡类型：1=普通 / 2=打boss / 3=跳前一副本 / 4=跳后一副本
		 * 					team : 1,		// 编队对号
		 * 					branch : 1		// 是否有分支线：0=无 / 1=只有一个直线 / x=有两个直线（x计算方式：用两个直线的第一个level编号减当前level取最大值）
		 * 					name : "name",	// 关卡名称
		 * 					des	: "des"		// 关卡描述
		 * 				},
		 * 				[1]:
		 * 				{
		 * 					level:2,
		 * 					status:1,
		 * 					type:1,
		 * 					team:2,
		 * 					branch:1
		 * 				}
		 * 			]
		 * 		[1]:
		 * 			[
		 * 				[0] : {},
		 * 				[1] : {},
		 * 				[2] : {},
		 * 				[3] : {},
		 * 				[4] : {}
		 * 			]
		 * ]
		 *
		 */


		/** 用于数据存取的一个名称 */
		private static const PREFIX_NAME : String = "data_EctypalData_prefix_name";

		private static const pool : Dictionary = new Dictionary();
		
		/** 默认选中战斗的关卡level值 */
		private static const DEFAULT_CURRENT_LEVEL:int = -1;
		
		
		/** 默认副本id值 */
		public static const DEFAULT_ECTYPAL_ID:int = -1;


		/** 副本的数据配置文件 */
		[Embed(source = "../asset/ectypal.xml", mimeType = "application/octet-stream")]
		private static var EctypalDataXML : Class;

		private static var _ectypalDataXML : XML = XML(new EctypalDataXML());
		private static var _currentEctypalID : int = -1;

		/** 在当前副本中挑战的关卡编号 */
		public static var currentLevel : int = DEFAULT_CURRENT_LEVEL;

		/** 所有副本编号 [id] */
		public static var ectypalDataArrayID : Array = JSON.parse(String(ectypalDataXML.ectypal_id[0])) as Array;

		/**
		 * 获取副本的数据 [默认] 配置信息
		 */
		public static function get ectypalDataXML() : XML
		{
			return _ectypalDataXML;
		}

		/**
		 * 使用一个副本id编号获取数据
		 * @param ectypalID 指定一个副本的id编号
		 * @return XML
		 */
		public static function getCurrentEctypalData(ectypalID : int) : Array
		{
			if (pool[PREFIX_NAME + ectypalID])
			{
				return pool[PREFIX_NAME + ectypalID] as Array;
			}
			return null;
		}

		/**
		 * 获取默认副本数据
		 * @param ectypalID 副本id编号
		 * @return 返回指定副本默认数据
		 */
		public static function getDefaultEctypalData(ectypalID : int) : Array
		{
			var xml : XML = ectypalDataXML.items.(@id == ectypalID)[0];
			var xmllist : XMLList = xml.children();
			var array : Array = [];
			for each (xml in xmllist)
			{
				var object : Object = {};
				object.level = xml.@level;
				object.status = xml.@status;
				object.type = xml.@type;
				object.team = xml.@team;
				object.branch = xml.@branch;
				object.name = xml.@name;
				object.des = xml.@des;
				array.push(object);
			}
			return array;
		}

		/**
		 * 设置当前副本的数据
		 * @param ectypalXml 副本数据
		 */
		public static function setCurrentEctypalData(ectypalData : Array, ectypalID : int = -1) : void
		{
			ectypalID = ectypalID == -1 ? currentEctypalID : ectypalID;
			pool[PREFIX_NAME + ectypalID] = ectypalData;
		}
		
		/**
		 * 将当前进入战斗的关卡设置为 默认值
		 */
		public static function setDefaultCurrentLevel():void
		{
			currentLevel = DEFAULT_CURRENT_LEVEL;
		}

		/**
		 * 战斗结束后调用，存储或更改副本数据
		 * @param type 结果状态，
		 * @see view.ectypal.EctypalType.EctypalType.RESULT_WIN
		 * @see view.ectypal.EctypalType.EctypalType.RESULT_LOSE
		 *
		 */
		public static function setBattleResult(type : int) : void
		{
			if (currentLevel == -1) return ;
			if (type == EctypalType.RESULT_WIN)
			{
				var array : Array = getCurrentEctypalData(currentEctypalID);
				if (array == null)
					return;

				var object : Object;
				var i : int = 0;
				var length : int = array.length;
				for (i = 0; i < length; i++)
				{
					object = array[i];
					if (object)
					{
						var level : int = int(object.level);
						if (level == currentLevel)
						{
							var status : int = int(object.status);
							var branch : int = int(object.branch);
							if (status == EctypalType.STATUS_2)
							{
								object.status = EctypalType.STATUS_3;
								if (branch > 0)
								{
									var i1 : int = i + 1;
									var i2 : int = i + branch;
									var o1 : Object = i1 < length ? array[i + 1] : null;
									var o2 : Object = (branch > 1 && i2 < length) ? array[i + branch] : null;
									if (o1)
									{
										o1.status = EctypalType.STATUS_2;
									}
									if (o2)
									{
										o2.status = EctypalType.STATUS_2;
									}
									setCurrentEctypalData(array);
								}
							}
							return;
						}
					}
				}
			}
		}

		/** 战斗挑战的副本编号 */
		public static function get currentEctypalID():int
		{
			return _currentEctypalID;
		}

		/**
		 * @private
		 */
		public static function set currentEctypalID(value:int):void
		{
			_currentEctypalID = value;
		}


	}

}
