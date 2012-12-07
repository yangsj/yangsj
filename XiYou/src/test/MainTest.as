package test
{

	import global.DeviceType;
	import global.Global;

	import flash.display.Sprite;


	/**
	 * @author Administrator
	 */
	[SWF(backgroundColor = "#FFFFFF", frameRate = "24", width = "1024", height = "768")]
	public class MainTest extends Sprite
	{
		public function MainTest()
		{
			Global.isOnDevice = false;
			Global.deviceType = DeviceType.IPAD;
			addChild(new Main);
			stage.addChild(new Stats);
		}
	}
}
