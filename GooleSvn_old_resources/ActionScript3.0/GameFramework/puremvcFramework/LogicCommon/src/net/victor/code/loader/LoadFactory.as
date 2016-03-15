package net.victor.code.loader
{
	public class LoadFactory
	{
		/**
		 * 创建单个加载 
		 * @param url
		 * @param type
		 * @return 
		 * 
		 */		
		public static function createLoadItem(url:String, type:String):LoadItem
		{
			var li:LoadItem = new LoadItem();
			li.url = url;
			li.type = type;
			return li;
		}
		
		/**
		 *  
		 * @return 
		 * 
		 */		
		public static function createLoadBatch():LoadBatch
		{
			var loadBatch:LoadBatch = new LoadBatch();
			
			return loadBatch;
		}
	}
}