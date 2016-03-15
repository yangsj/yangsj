package net.victor.code.managers.resources
{
	import net.victor.code.managers.interfaces.ICCResourceItem;
	
	internal class CCResourceItem implements ICCResourceItem
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		/**
		 *  <item id="test" url="test.swf" version="1.0" loadpolicy="1"/> 
		 */		
		private var _data:XML;
		public function CCResourceItem(xml:XML)
		{
			_data = xml;
		}
		
		public function get id():String
		{
			return this._data.attribute("id");
		}
		
		public function get url():String
		{
			return this._data.attribute("url");
		}
		
		public function get version():String
		{
			return this._data.attribute("version");
		}
		
		public function get loadpolicy():String
		{
			return this._data.attribute("loadpolicy");
		}
		
		public function dispose():void
		{
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}