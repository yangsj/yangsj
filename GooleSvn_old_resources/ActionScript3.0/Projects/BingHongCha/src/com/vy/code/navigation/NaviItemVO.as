package com.vy.code.navigation
{
	
	/**
	 * 说明：NaviItemVO
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-12
	 */
	
	public class NaviItemVO
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		/**
		 * 当前城市编号
		 */
		public var id:String = "00";
		
		/**
		 * 城市名称
		 */
		public var city:String = "北京";
		
		/**
		 * 城市拼音
		 */
		public var spell:String = "BEIJING";
		
		
		private var _data:XML = new XML();
		
		public function NaviItemVO($data:XML = null)
		{
			if ($data)
			{
				data = $data;
			}
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function get data():XML
		{
			return _data;
		}
		
		public function set data(value:XML):void
		{
			_data = value;
			assignVars();
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function assignVars():void
		{
			id		= String(data.@id);
			city	= String(data.@city);
			spell	= String(data.@spell);
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		

	}
	
}