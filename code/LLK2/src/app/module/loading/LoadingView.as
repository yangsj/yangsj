package app.module.loading
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	import app.AppStage;
	import app.core.Image;
	import app.core.ProgressBar;
	import app.module.AppUrl;
	import app.module.main.view.ElementConfig;
	import app.utils.DisplayUtil;
	
	import framework.BaseScene;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-22
	 */
	public class LoadingView extends BaseScene
	{
		private var urls:Vector.<String>;
		private var container:Sprite;
		private var txtDes:TextField;
		private var progressBar:ProgressBar;
		private var imgCon:Sprite;
		private var total:int;
		
		public function LoadingView()
		{
			super();
			
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, AppStage.stageWidth, AppStage.stageHeight );
			this.graphics.endFill();
			
			container = new Sprite();
			addChild( container );
			
			txtDes = DisplayUtil.getTextFiled( 34, 0xffffff, TextFormatAlign.CENTER);
			txtDes.text = "资源加载中...";
			txtDes.width = 500;
			txtDes.height = txtDes.textHeight + 10;
			container.addChild( txtDes );
			
			progressBar = new ProgressBar( 500 );
			progressBar.y = txtDes.y + txtDes.height;
			container.addChild( progressBar );
			
			container.x = ( AppStage.stageWidth - container.width ) >> 1;
			container.y = ( AppStage.stageHeight - container.height ) >> 1;
			
			urls = new Vector.<String>();
			imgCon = new Sprite();
			
			bgImageUrl();
			headImageUrl();
			startLoading();
		}
		
		private function bgImageUrl():void
		{
			urls.push( AppUrl.getBgUrl( "a" ));
			for ( var i:int = 0; i <= 17; i++ )
			{
				urls.push( AppUrl.getBgUrl( i ));
			}
		}
		
		private function headImageUrl():void
		{
			for ( var i:int = 1; i <= ElementConfig.MARK_LENGTH; i++ )
			{
				urls.push( AppUrl.getHeadUrl( i ));
			}
		}
		
		private function startLoading():void
		{
			total = urls.length;
			
			loadingItem();
		}
		
		private function loadingItem():void
		{
			if ( urls.length > 0 )
			{
				imgCon.addChild( new Image( urls.pop(), complete, complete ));
			}
			else
			{
				dispatchEvent( new LoadingEvent( LoadingEvent.LOAD_COMPLETE ));
			}
			
			function complete():void
			{
				progressBar.setProgress( 1 - ( urls.length / total) );
				
				loadingItem();
			}
		}
		
	}
}