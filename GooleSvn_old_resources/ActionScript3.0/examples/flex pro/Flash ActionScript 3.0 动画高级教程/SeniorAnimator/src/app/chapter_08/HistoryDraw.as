package app.chapter_08
{
	import code.SpriteBase;
	
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	
	/**
	 * 说明：HistoryDraw
	 * @author victor
	 * 2012-9-9 上午1:29:41
	 */
	
	public class HistoryDraw extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var graphicsData:Vector.<IGraphicsData>;
		private var graphicsDataBuffer:Vector.<IGraphicsData>;
		private var commands:Vector.<int>;
		private var data:Vector.<Number>;
		private var index:int = 0;
		
		public function HistoryDraw()
		{
			super();
		}
		
		override protected function initialization():void
		{
			graphicsData = new Vector.<IGraphicsData>();
			graphicsDataBuffer = new Vector.<IGraphicsData>();
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if (event.keyCode == Keyboard.LEFT)
			{
				index -= 2;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				index += 2;
			}
			index = Math.max(0, index);
			index = Math.min(graphicsDataBuffer.length, index);
			
			draw();
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			graphicsDataBuffer.push(new GraphicsPath(commands, data));
			
			index++;
			graphicsDataBuffer.length = index;
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			commands.push(GraphicsPathCommand.LINE_TO);
			data.push(mouseX, mouseY);
			
			graphics.lineTo(mouseX, mouseY);
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var stroke:GraphicsStroke = new GraphicsStroke();
			stroke.thickness = Math.random() * 10;
			stroke.fill = new GraphicsSolidFill(Math.random() * 0xffffff);
			
			graphicsDataBuffer.push(stroke);
			
			index++;
			graphicsDataBuffer.length = index;
			
			commands = new Vector.<int>();
			commands.push(GraphicsPathCommand.MOVE_TO);
			
			data = new Vector.<Number>();
			data.push(mouseX, mouseY);
			
			graphics.lineStyle(0,0,0.5);
			graphics.moveTo(mouseX, mouseY);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function draw():void
		{
			graphicsData.length = 0;
			
			for (var i:int = 0; i < index; i++)
			{
				graphicsData[i] = graphicsDataBuffer[i];
			}
			
			graphics.clear();
			graphics.drawGraphicsData(graphicsData);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}