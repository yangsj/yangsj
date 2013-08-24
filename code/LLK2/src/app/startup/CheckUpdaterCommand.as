package app.startup
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import app.NativeExtensions;
	import app.core.Alert;
	import app.events.ViewEvent;
	import app.module.ViewName;
	import app.module.model.Global;
	
	import framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class CheckUpdaterCommand extends BaseCommand
	{
		public function CheckUpdaterCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if ( NativeExtensions.isContented )
			{
				loaderXml();
			}
			else
			{
				Alert.showAlert( "网络状态", "当前没有可用网络连接，请检查网络！", "关闭" );
			}
		}

		private function loaderXml():void
		{
//			try
//			{
//				var url:String = "https://raw.github.com/yangsj/yangsj/master/code/LLK2/release/update.xml?t=" + (new Date().time);
//				var urlLoader:URLLoader = new URLLoader();
//				urlLoader.addEventListener( Event.COMPLETE, loadCompleteHandler );
//				urlLoader.addEventListener( IOErrorEvent.IO_ERROR, loadErrorHandler );
//				urlLoader.load( new URLRequest( url ) );
//			}
//			catch ( e:* )
//			{
//				trace("下载更新配置文件失败！！！！！！！！！！");
//			}
			
			Global.appUpdateUrl = "https://raw.github.com/yangsj/yangsj/master/code/LLK2/release/LLK2.apk?t=" + ( new Date().time );
			Global.fileNameStr = "LLK2.apk";
			
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.UPDATE ));
		}
		
		protected function loadErrorHandler( event:IOErrorEvent ):void
		{
			trace("IOErrorEvent  " + event.text );
		}
		
		protected function loadCompleteHandler( event:Event ):void
		{
			var urlLoader:URLLoader = event.target as URLLoader;
			urlLoader.removeEventListener( Event.COMPLETE, loadCompleteHandler );
			urlLoader.removeEventListener( IOErrorEvent.IO_ERROR, loadErrorHandler );
			
			trace(  urlLoader.data  );
			
			var file:File;
			var xml:XML = new XML( urlLoader.data );
			var curVersion:String = Global.currentVersion;
			var boolean:Boolean = Global.isAndroid;
			var updateVersion:String = String(xml.version[ 0 ]);
			Global.appUpdateUrl = ( boolean ? xml.apk[ 0 ] : xml.ipa[ 0 ]) + "?t=" + ( new Date().time );
			Global.fileNameStr = boolean ? xml.apkname[ 0 ] : xml.apkname[ 0 ];
			file = Global.filePath.resolvePath( Global.fileNameStr );
			
			if ( file.exists )
			{
				file.deleteFile();
			}
			
//			if ( curVersion != updateVersion )
//			{
				// has update
				Global.currentVersion = updateVersion;
				dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.UPDATE ));
//			}
		}
		
	}
}