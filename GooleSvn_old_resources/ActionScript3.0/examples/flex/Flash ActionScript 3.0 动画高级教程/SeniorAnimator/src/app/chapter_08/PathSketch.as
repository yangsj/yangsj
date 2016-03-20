package app.chapter_08
{
	import code.SpriteBase;
	
	import flash.display.GraphicsPathCommand;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	
	/**
	 * 说明：PathSketch
	 * @author victor
	 * 2012-8-30 下午11:37:47
	 */
	
	public class PathSketch extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var commands:Vector.<int> = new Vector.<int>;
		private var data:Vector.<Number> = new Vector.<Number>();
		
		private var lineWidth:Number = 0;
		private var lineColor:uint = 0;
		
		public function PathSketch()
		{
			super();
		}
		
		override protected function initialization():void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			var keycode:uint = event.keyCode;
			if (keycode == Keyboard.DOWN)
			{
				lineWidth = Math.max(0, lineWidth - 1);
			}
			else if (keycode == Keyboard.UP)
			{
				lineWidth ++;
			}
			else if (keycode == Keyboard.SPACE)
			{
				lineColor = Math.random() * 0xffffff;
			}
			draw();
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			commands.push(GraphicsPathCommand.MOVE_TO);
			data.push(mouseX, mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			draw();
		}
		
		private function draw():void
		{
			// TODO Auto Generated method stub
			graphics.clear();
			graphics.lineStyle(lineWidth, lineColor);
			graphics.drawPath(commands, data);
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			commands.push(GraphicsPathCommand.LINE_TO);
			data.push(mouseX, mouseY);
			draw();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}