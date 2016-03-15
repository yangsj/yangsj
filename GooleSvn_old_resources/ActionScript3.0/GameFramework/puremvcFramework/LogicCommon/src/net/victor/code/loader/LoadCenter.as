package net.victor.code.loader
{
	/**
	 * 加载中心 
	 * @author Administrator
	 * 
	 */	
	public class LoadCenter
	{
		private static var _intance:LoadCenter;
		public function LoadCenter()
		{
			if(_intance)
			{
				throw new Error("singleton error");
			}
			else
			{
				_intance = this;
			}
		}
		
		public static function get instance():LoadCenter
		{
			if(!_intance)
			{
				_intance = new LoadCenter();
			}
			return _intance;
		}
		
		
		
		private var _loadBatchs:Vector.<LoadBatch> = new Vector.<LoadBatch>();
		private var _curBatch:LoadBatch;
		
		public function get curBatch():LoadBatch
		{
			if(!_curBatch)
			{
				_curBatch = new LoadBatch();
			}
			return this._curBatch;
		}
		public function addLoadItem(url:String, type:String, isCache:Boolean=false):void
		{
			
		}
		
		public function startCurrentLoad():void
		{
			this._loadBatchs.push(this.curBatch);
			this._curBatch = null;
		}
		
	}
}