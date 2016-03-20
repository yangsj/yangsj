package code.chapter_05
{
	import flash.display.Sprite;
	
	
	/**
	 * 说明：Snow
	 * @author victor
	 * 2012-8-6 下午8:30:29
	 */
	
	public class Snow extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		public var vx:Number;
		public var vy:Number;
		
		public function Snow()
		{
			super();
			
			this.graphics.beginFill(0xffffff, 0.7);
			this.graphics.drawCircle(0, 0, 2);
			this.graphics.endFill();
			
			vx = 0;
			vy = 1;
		}
		
		public function update():void
		{
			vx += Math.random() * 0.2 - 0.1;
			vx *= 0.95;
			x += vx;
			y += vy;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}