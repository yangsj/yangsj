package app.module.panel.update
{
	import com.greensock.TweenMax;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import app.NativeExtensions;
	import app.core.Alert;
	import app.core.ProgressBar;
	import app.module.model.Global;
	
	import framework.BasePanel;
	import framework.ViewStruct;
	
	import org.zengrong.ane.ANEToolkit;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class UpdateView extends BasePanel
	{
		private var container:Sprite;
		private var txtDes:TextField;
		private var progressBar:ProgressBar;
		private var bgShape:Shape;
		
		public function UpdateView()
		{
//			bgShape = new Shape();
//			bgShape.graphics.beginFill( 0 , 1 );
//			bgShape.graphics.drawRect( 0, 0, AppStage.stageWidth, AppStage.stageHeight );
//			bgShape.graphics.endFill();
//			
//			container = new Sprite();
//			addChild( container );
//			
//			txtDes = DisplayUtil.getTextFiled( 34, 0xffffff, TextFormatAlign.CENTER);
//			txtDes.text = "正在下载应用安装包...";
//			txtDes.width = 500;
//			txtDes.height = txtDes.textHeight + 10;
//			container.addChild( txtDes );
//			
//			progressBar = new ProgressBar( 500 );
//			progressBar.y = txtDes.y + txtDes.height;
//			container.addChild( progressBar );
//			
//			container.x = ( AppStage.stageWidth - container.width ) >> 1;
//			container.y = ( AppStage.stageHeight - container.height ) >> 1;
		}
		
		override public function hide():void
		{
			super.hide();
		}
		
		override public function show():void
		{
			if ( bgShape )
				bgShape.visible = false;
			
			super.show();
			
			ViewStruct.addChild( this, ViewStruct.UPDATE_PANEL );
			
			if ( bgShape )
				TweenMax.delayedCall( 0.5, startLoad);
			else startLoad();
		}
		
		private function startLoad():void
		{
			if ( NativeExtensions.isContented )
			{
				if ( NativeExtensions.isConnectedWithWIFI == false )
				{
					Alert.showAlert( "网络状态", "当前没有WIFI网络可用，使用运营商网络下载将会产生一定的费用。是否继续下载？", "更新", loadAppFile, "取消" );
				}
				else
				{
					loadAppFile();
				}
			}
			else
			{
				Alert.showAlert( "网络状态", "当前没有可用网络连接，请检查网络！", "关闭" );
			}
			
			if ( bgShape )
				bgShape.visible = true;
		}
		
		private function loadAppFile():void
		{
			var fileStream:FileStream = new FileStream;
			try
			{
				var urlReq:URLRequest = new URLRequest( Global.appUpdateUrl );
				var fileData:ByteArray = new ByteArray();
				var urlStream:URLStream = new URLStream();
				urlStream.addEventListener( ProgressEvent.PROGRESS, progressHandler );
				urlStream.addEventListener( IOErrorEvent.IO_ERROR, loaderIoErrorHandler );
				urlStream.addEventListener( Event.COMPLETE, loaded );
				urlStream.load( urlReq );
			}
			catch ( e:* )
			{
			}
			
			function loaderIoErrorHandler( event:IOErrorEvent ):void
			{
				trace("应用下载错误loaderIoErrorHandler   " + event.text);
			}
			
			function progressHandler( event:ProgressEvent ):void
			{
				var perent:Number = event.bytesLoaded / event.bytesTotal;
				trace( perent, event.bytesLoaded , event.bytesTotal );
				if ( progressBar )
					progressBar.setProgress( event.bytesLoaded / event.bytesTotal );
				else Alert.showAlert("正在下载应用安装包...", "已完成 " + (( perent * 100 ).toFixed( 2 )) + "%", "取消", cancelHandler );
			}
			function cancelHandler():void
			{
				urlStream.close();
				urlStream.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
				urlStream.removeEventListener( IOErrorEvent.IO_ERROR, loaderIoErrorHandler );
				urlStream.removeEventListener( Event.COMPLETE, loaded );
				
				hide();
				
			}
			function loaded( event:Event ):void
			{
				urlStream.readBytes( fileData, 0, urlStream.bytesAvailable );
				writeAirFile();
				
				urlStream.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
				urlStream.removeEventListener( IOErrorEvent.IO_ERROR, loaderIoErrorHandler );
				urlStream.removeEventListener( Event.COMPLETE, loaded );
			}
			function writeAirFile():void
			{
				var file:File = Global.filePath.resolvePath( Global.fileNameStr );
				try
				{
					fileStream.addEventListener( Event.CLOSE, fileClosed );
					fileStream.addEventListener( Event.COMPLETE, fileStreamComplete );
					fileStream.openAsync( file, FileMode.WRITE );
					fileStream.writeBytes( fileData, 0, fileData.length );
				}
				catch ( e:Error )
				{
					trace("写入文件错误！");
				}
			}
			
			function fileStreamComplete( event:Event ):void
			{
				fileStream.removeEventListener( Event.CLOSE, fileClosed );
				fileStream.removeEventListener( Event.COMPLETE, fileStreamComplete );
				fileStream.close();
			}
			
			function fileClosed( event:Event ):void
			{
				Alert.showAlert("安装应用", "应用下载完毕，是否进行安装？", "安装", installAPK, "取消" );
				function installAPK():void
				{
					try
					{
						var airFile:File = Global.filePath.resolvePath( Global.fileNameStr );
						ANEToolkit.intent.installAPK( airFile.url );
					}
					catch ( e:Error )
					{
					}
				}
			}
		}
		
		
	}
}