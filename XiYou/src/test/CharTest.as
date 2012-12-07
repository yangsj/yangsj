package test
{

	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.display.Bitmap;
	import character.ComplexPawn;
	import battle.SunWuKong;
	import battle.XiaBin;
	import character.Pawn;
	import flash.display.Sprite;




	/**
	 * @author Administrator
	 */
	[SWF(backgroundColor = "#000000", frameRate = "20", width = "1024", height = "768")]
	public class CharTest extends Sprite
	{
		private var xiabing : Pawn;

		private var sunwukong : Pawn;

		public function CharTest()
		{
			trace(new <String>['stand', 'walk', 'attack', 'hurt', 's_start', 's_attack', 'dead1'] is Vector.<String>)
			xiabing = new ComplexPawn('1');
			xiabing.x = xiabing.y = 200;

			sunwukong = new ComplexPawn('20');
			sunwukong.x = 280;
			sunwukong.y = 200;
			addChild(xiabing);
			addChild(sunwukong);
			xiabing.attack([sunwukong]);
			//xiabing.moveTo(new Point(400, 200));
			trace(bg_panSiDong is BitmapData)
			

			var bg : bg_panSiDong = new bg_panSiDong();
			bg.scroll(50,0);
			addChild(new Bitmap(bg));
		}
	}
}
