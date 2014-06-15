package victor.app.panel
{
	import flash.events.MouseEvent;
	
	import victor.app.scene.MemoryTrainningSceme;
	import victor.framework.constant.ScreenType;
	import victor.framework.core.AutoLayout;
	import victor.framework.core.Panel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-16
	 */
	public class MemoryTrainningPanel extends Panel
	{
		private var uiRes:UI_MemoryTrainningPanel;
		
		public function MemoryTrainningPanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			uiRes = new UI_MemoryTrainningPanel();
			addChild( uiRes );
			AutoLayout.layout( uiRes );
			
			this.graphics.clear();
			this.graphics.beginFill(0);
			this.graphics.drawRect(0,0,ScreenType.screenWidth, ScreenType.screenHeight );
			this.graphics.endFill();
		}
		
		override protected function showBefore():void
		{
			super.showBefore();
			var arr:Vector.<String> = MemoryTrainningSceme.CODE;
			var desc:String = "";
			for ( var i:int = 1; i <= arr.length; i++ )
			{
				var s:String = arr[i - 1];
				s = s + ( s.length == 1 ? "  " : "" );
				desc += ( i < 10 ? "0" : "" ) + i + "-" + s + "    " + ( i%4==0 ? "\n" : "" );
			}
			uiRes.mcDesc.txtDesc.text = desc;
			uiRes.mcDesc.txtDesc.width = uiRes.mcDesc.txtDesc.textWidth + 10;
			uiRes.mcDesc.txtDesc.height = uiRes.mcDesc.txtDesc.textHeight + 10;
			uiRes.mcDesc.txtDesc.x = -uiRes.mcDesc.txtDesc.textWidth * 0.5;
			uiRes.mcDesc.txtDesc.y = -uiRes.mcDesc.txtDesc.textHeight * 0.5 + 10;
		}
		
		override protected function clickedHandler(event:MouseEvent):void
		{
			super.clickedHandler( event );
			if ( target == uiRes.btnBack )
			{
				hide();
			}
		}
		
	}
}