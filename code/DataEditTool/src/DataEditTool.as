package
{

	import code.ResolvingFileList;
	
	import events.EditEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.FileReferenceList;
	import flash.system.System;
	
	import view.MainView;

	[SWF( width = "550", height = "400", frameRate = "24" )]

	/**
	 * ……
	 * @author yangsj
	 */
	public class DataEditTool extends Sprite
	{
		private var mainView:MainView;
		private var storageUrl:String = "";

		public function DataEditTool()
		{
			if ( stage )
				initialization();
			else
				addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}

		protected function addedToStageHandler( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );

			initialization();
		}

		private function initialization():void
		{
			initMainView();
			addEvent();
			
			System.useCodePage = true;
		}

		private function initMainView():void
		{
			mainView = new MainView();
			addChild( mainView );
			initStatus();
			mainView.textArea.text = "解析等待中……";
		}
		
		private function initStatus():void
		{
			mainView.btnBrowerStorage.visible = true;
			mainView.btnBrowerDirectory.visible = false;
			mainView.btnBrowerStorage.enabled = true;
			mainView.btnBrowerDirectory.enabled = false;
			mainView.textDirectoryUrl.htmlText = "请选择<font color=\"#ff0000\">文件保存</font>目录……";
		}

		private function addEvent():void
		{
			mainView.btnBrowerStorage.addEventListener( MouseEvent.CLICK, btnBrowerStorageHandler );
			mainView.btnBrowerDirectory.addEventListener( MouseEvent.CLICK, btnBrowerDirectoryHandler );
			EditEvent.dispatcher.addEventListener( EditEvent.RESOLVING_ALL_COMPLETE, resolvingAllCompleteHandler );
			EditEvent.dispatcher.addEventListener( EditEvent.RESOLVING_ITEM_COMPLETE, resolvingItemCompleteHandler );
		}

		protected function resolvingAllCompleteHandler( event:Event ):void
		{
			initStatus();
			mainView.textArea.appendText("解析已完成……");
		}

		protected function resolvingItemCompleteHandler( event:EditEvent ):void
		{
			mainView.textArea.appendText(event.data.toString() + "\n");
		}

		protected function btnBrowerStorageHandler( event:MouseEvent ):void
		{
			var file:File = new File();
			file.addEventListener( Event.SELECT, selectedStorageHandler );
			file.browseForDirectory( "为导出的数据选择一个保存地址" );
			file = null;
		}

		protected function selectedStorageHandler( evt:Event ):void
		{
			mainView.btnBrowerStorage.visible = false;
			mainView.btnBrowerDirectory.visible = true;
			mainView.btnBrowerDirectory.enabled = true;
			var file:File = evt.target as File;
			file.removeEventListener( Event.SELECT, selectedStorageHandler );

			storageUrl = file.url;
			mainView.textDirectoryUrl.htmlText = storageUrl;
			mainView.textArea.text = "解析等待中……";
		}

		protected function btnBrowerDirectoryHandler( event:MouseEvent ):void
		{
			var fileReferenceList:FileReferenceList = new FileReferenceList();
			fileReferenceList.addEventListener( Event.SELECT, onSelectedHandler );
			fileReferenceList.browse([ new FileFilter( "Documents", "*.csv;*.xls;*.xlsx" )]);

			function onComplete( e:Event ):void
			{
				trace( 11111 );
			}
		}

		protected function onSelectedHandler( evt:Event ):void
		{
			mainView.btnBrowerDirectory.enabled = false;
			mainView.btnBrowerStorage.enabled = false;

			var fileReferenceList:FileReferenceList = evt.target as FileReferenceList;
			fileReferenceList.removeEventListener( Event.SELECT, onSelectedHandler );

			var resolving:ResolvingFileList = new ResolvingFileList( fileReferenceList.fileList, storageUrl );
			resolving.startLoading();
			resolving = null;
		}

	}
}
