package app.chapter_08
{
	import code.SpriteBase;
	
	import flash.display.GraphicsPathCommand;
	
	
	/**
	 * 说明：SingleLine
	 * @author victor
	 * 2012-8-30 下午11:29:35
	 */
	
	public class SingleLine extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function SingleLine()
		{
			super();
		}
		
		override protected function initialization():void
		{
//			super.initialization();
			
			var commands:Vector.<int> = new Vector.<int>();
			commands[0] = GraphicsPathCommand.MOVE_TO;
			commands[1] = GraphicsPathCommand.LINE_TO;
			
			var data:Vector.<Number> = new Vector.<Number>();
			data[0] = 100;
			data[1] = 100;
			data[2] = 250;
			data[3] = 200;
			
			graphics.lineStyle(0);
			graphics.drawPath(commands, data);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}