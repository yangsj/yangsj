package net.vyky.loader
{
	import flash.display.Bitmap;
	import flash.display.Loader;

	internal class LoadData
	{
		private var _bytesTotal:uint = 0;
		
		private var _url:String = "";
		private var _type:String = "";
		
		private var _loader:Loader = null;
		private var _bitmap:Bitmap = null;
		private var _data:*;
		public function LoadData()
		{
		}
		
		
		public function get bitmap():Bitmap
		{
			return _bitmap;
		}

		public function set bitmap(value:Bitmap):void
		{
			_bitmap = value;
		}

		public function get data():*
		{
			return _data;
		}

		public function set data(value:*):void
		{
			_data = value;
		}

		public function get loader():Loader
		{
			return _loader;
		}

		public function set loader(value:Loader):void
		{
			_loader = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}

		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}

		public function set bytesTotal(value:uint):void
		{
			_bytesTotal = value;
		}

	}
}