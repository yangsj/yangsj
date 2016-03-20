package core.diamonds
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	
	/**
	 * 说明：DiamondsPool
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-2-22
	 */
	
	public class DiamondsPool
	{
		
		/////////////////////////////////static ////////////////////////////
		
		private static var pool:Dictionary = new Dictionary();
		
		///////////////////////////////// vars /////////////////////////////////
		
		
		
		public function DiamondsPool()
		{
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 按对象名称获取对应的对象
		 * @param $name 对象名称或Type
		 * @return 
		 * 
		 */
		static public function getObject($name:String):DisplayObject
		{
			var ar:Vector.<DisplayObject> = pool[$name] as Vector.<DisplayObject>;
			var dis:DisplayObject;
			dis = ar.shift();
			return dis as DisplayObject;
		}
		
		/**
		 * 按对象名称或Type存储对象
		 * @param $obj 存储的对象
		 * @param $name 存储对象名称或Type
		 * 
		 */
		static public function setObject($obj:DisplayObject, $name:String):void
		{
			var ar:Vector.<DisplayObject>;
			if (pool[$name])
			{
				ar = pool[$name] as Vector.<DisplayObject>;
			}
			else
			{
				ar = new Vector.<DisplayObject>();
			}
			ar.push($obj);
			pool[$name] = ar;
		}
		
		/**
		 * 对象池中是否存在指定名称的对象
		 * @param $name 查找的对象名或Type
		 * @return Boolean
		 * 
		 */
		static public function hasObject($name:String):Boolean
		{
			if (pool[$name])
			{
				var ar:Vector.<DisplayObject> = pool[$name] as Vector.<DisplayObject>;
				if (ar && ar.length > 0)
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			
			return false;
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}