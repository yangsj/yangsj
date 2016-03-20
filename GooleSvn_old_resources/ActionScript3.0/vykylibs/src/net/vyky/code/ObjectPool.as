package net.vyky.code
{

	import flash.display.DisplayObject;
	import flash.utils.Dictionary;


	/**
	 * 说明：ObjectPool
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-26
	 */

	public class ObjectPool
	{
		private static var pool : Dictionary = new Dictionary();


		////////////// public functions //////////////

		/**
		 * 初始化指定的类型对象到对象池中。
		 * @param className 初始化指定的对象类型
		 * @param poolName 用于存取对象的名称
		 * @param number 需要初始化的对象数目
		 *
		 */
		public static function initObjects(className : Class, poolName : String, number : uint) : void
		{
			var i : int = 0;
			for (i = 0; i < number; i++)
			{
				setObject(new className(), poolName);
			}
		}

		/**
		 * 按对象名称获取对应的对象
		 * @param poolName 对象名称或Type
		 * @return Object 若存在则返回指定名称的索引对象
		 */
		public static function getObject(poolName : String) : Object
		{
			if (hasObject(poolName))
			{
				var ar : Vector.<Object> = pool[poolName] as Vector.<Object>;
				return ar.pop();
			}
			return null;
		}

		/**
		 * 按对象名称或Type存储对象
		 * @param object 存储的对象
		 * @param poolName 存储对象名称或Type
		 * @param isOnly 将要被储存的对象是否储存唯一一个，为true则$name字段对应的值$obj只有一份
		 *
		 */
		public static function setObject(object : Object, poolName : String, isOnly : Boolean = false) : void
		{
			var ar : Vector.<Object>;
			if (pool.hasOwnProperty(poolName))
			{
				ar = pool[poolName] as Vector.<Object>;
			}
			else
			{
				ar = new Vector.<Object>();
			}
			if (isOnly)
			{
				ar[0] = object;
			}
			else
			{
				ar.push(object);
			}

			pool[poolName] = ar;
		}

		/**
		 * 对象池中是否存在指定名称的对象
		 * @param poolName 查找的对象名或Type
		 * @return Boolean
		 *
		 */
		public static function hasObject(poolName : String) : Boolean
		{
			if (pool.hasOwnProperty(poolName))
			{
				var ar : Vector.<Object> = pool[poolName] as Vector.<Object>;
				return (ar && ar.length > 0) ? true : false;
			}
			return false;
		}

		////////////// override functions //////////////



		////////////// private functions //////////////



		////////////// events functions handle/////////



		////////////// getter/setter //////////////////

	}

}
