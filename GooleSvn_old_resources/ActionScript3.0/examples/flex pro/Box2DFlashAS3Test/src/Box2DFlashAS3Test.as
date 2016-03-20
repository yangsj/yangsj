package
{
	import flash.display.Sprite;
	
	import victor.test.TestBed;
	import victor.test.TestHelloworld;
	
	[SWF(width='640', height='360', backgroundColor='#292C2C', frameRate='30')]
	
	/**
	 * 说明：Box2DFlashAS3Test
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-6-14
	 */
	
	public class Box2DFlashAS3Test extends Sprite
	{
		
		private var helloWorld:TestHelloworld;
		
		public function Box2DFlashAS3Test()
		{
//			initTestHelloWorld();
			initTestBed();
		}
		
		private function initTestHelloWorld():void
		{
			helloWorld = new TestHelloworld();
			this.addChild(helloWorld);
			
		}
		
		private function initTestBed():void
		{
			var testBed:TestBed = new TestBed();
			this.addChild(testBed);
		}
		
	}
	
}