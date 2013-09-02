package app.modules.panel.test
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.utils.log;
	
	import victor.framework.drag.DragItem;
	import victor.framework.drag.DragManager;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.TextFiledUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-2
	 */
	public class TestItem extends DragItem
	{
		public function TestItem()
		{
			super();
			
			this.graphics.beginFill( 0 );
			this.graphics.drawRect(0,0,100,100);
			this.graphics.endFill();
			
			addEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			DragManager.instance.drag( this );
		}
		
		public function setIndex(index:int, colNum:int = 4):void
		{
			x = 110 * ( index % colNum );
			y = 110 * int( index / colNum );
			
			DisplayUtil.removedAll( this );
			
			var txt:TextField = TextFiledUtil.create("", 25, 0xffffff);
			txt.text = "NO." + ( index + 1 );
			txt.width = txt.textWidth + 10;
			txt.height = txt.textHeight + 2;
			txt.x = ( width - txt.textWidth ) >> 1;
			txt.y = ( height - txt.textHeight ) >> 1;
			addChild( txt );
		}
		
		override public function onDragFailed():void
		{
			super.onDragFailed();
			log( "onDragFailed" );
		}
		
		override public function onDragStart():void
		{
			log( "onDragStart" );
		}
		
		override public function onDragSuccess():void
		{
			log( "onDragSuccess" );
		}
	}
}