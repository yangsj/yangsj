package test.ram.code
{
	import flash.display.Sprite;
	
	
	/**
	 * 说明：Ball
	 * @author victor
	 * 2012-8-5 上午12:36:40
	 */
	
	public class Ball extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private var radius:int = 25;
		
		public function Ball($radius:int=25)
		{
			super();
			radius = $radius;
			drawRamdonColorBall();
		}
		
		public function drawRamdonColorBall():void
		{
			var color:uint = uint(Math.random() * 0xffffff);
			this.graphics.clear();
			this.graphics.beginFill(color);
			this.graphics.drawCircle(0,0, radius);
			this.graphics.endFill();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}