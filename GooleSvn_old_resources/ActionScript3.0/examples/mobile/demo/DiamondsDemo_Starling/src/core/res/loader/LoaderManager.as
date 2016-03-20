package core.res.loader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * 说明：LoaderManager
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-12
	 */
	
	public class LoaderManager
	{
		//E:/F/Work/flash_mobile/demo/DiamondsDemo/output/
		private var resXML:XML;
		
		private var length:int = 0;
		private var index:int=0;
		private var loader:Loader
		
		private var _callBack:Function;
		
		public var rootPath:String = "";
		
		public function LoaderManager()
		{
			resXML = Global.appXml.resources[0];
			length = resXML.item.length();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completed);
		}
		
		protected function completed(event:Event):void
		{
			// TODO Auto-generated method stub
			if (index == length)
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completed);
				loader = null;
				if (callBack != null)
				{
					callBack.apply(this);
				}
				callBack = null;
			}
			else
			{
				load();
			}
		}
		
		public function load():void
		{
			var pathString:String = rootPath + resXML.item[index].@src.toString();
			index++;
			loader.load(new URLRequest(pathString), new LoaderContext(false, Global.appDomain));
		}

		public function get callBack():Function
		{
			return _callBack;
		}

		public function set callBack(value:Function):void
		{
			_callBack = value;
		}
		
		
		
	}
	
}