package framework
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.AppStage;
	import app.utils.BitmapUtil;
	import app.utils.DisplayUtil;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BasePanel extends BaseView
	{
		private var txtTips:TextField;
		
		public function BasePanel()
		{
			this.graphics.beginFill( 0, 0 );
			this.graphics.drawRect( 0, 0, AppStage.stageWidth, AppStage.stageHeight );
			this.graphics.endFill();
			
			addEventListener( MouseEvent.CLICK, clickHandler );
		}
		
		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler( event );
			
			if (txtTips == null)
			{
				txtTips = DisplayUtil.getTextFiled( 26, 0xffffff );
				txtTips.appendText( "点击屏幕退出" );
				txtTips.width = txtTips.textWidth + 5;
				txtTips.height = txtTips.textHeight + 2;
				
				var bitmap:Bitmap = BitmapUtil.drawBitmapFromTextFeild( txtTips );
				bitmap.x = ( width - bitmap.width ) >> 1;
				bitmap.y = height - bitmap.height - 5;
				addChild( bitmap );
			}
			
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			removeEventListener( MouseEvent.CLICK, clickHandler );
		}

		override public function show():void
		{
			ViewStruct.addPanel( this );
			
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			
			TweenMax.to( this, 0.5, { scaleX: 1, scaleY: 1, alpha: 1, onUpdate: changePos });
		}
		
		protected function clickHandler( event:MouseEvent ):void
		{
			TweenMax.killTweensOf( this );
			TweenMax.to( this, 0.5, { scaleX: 0.1, scaleY: 0.1, alpha:0, onUpdate: changePos, onComplete: hide});
		}
		
		private function changePos():void
		{
			x = ( AppStage.stageWidth - width ) >> 1;
			y = ( AppStage.stageHeight - height ) >> 1;
		}

	}
}
