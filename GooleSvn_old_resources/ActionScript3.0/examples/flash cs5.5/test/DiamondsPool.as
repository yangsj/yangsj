package
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.display.Sprite;
	
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
		
		static public function getObject($name:String):DisplayObject
		{
			var ar:Array = pool[$name] as Array;
			var dis:Sprite
			if (ar && ar.length > 0)
			{
				dis = ar.shift();
			}
			else
			{
				dis = new Sprite();
			}
			return dis as DisplayObject;
		}
		
		static public function setObject($obj:DisplayObject, $name:String):void
		{
			var ar:Array;
			if (pool[$name])
			{
				ar = pool[$name] as Array;
			}
			else
			{
				ar = new Array();
				pool[$name] = [];
			}
			ar.push($obj);
			pool[$name] = ar;
		}
		
		/**
		 * 对象池中是否存在指定名称的对象
		 * @param $name 查找的对象名（id）
		 * @return Boolean
		 * 
		 */
		static public function hasObject($name:String):Boolean
		{
			if (pool[$name])
			{
				var ar:Array = pool[$name] as Array;
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