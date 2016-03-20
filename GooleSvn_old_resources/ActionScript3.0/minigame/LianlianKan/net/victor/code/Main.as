package net.victor.code
{

	import flash.display.MovieClip;


	public class Main extends MovieClip
	{
		var appCode:AppCode;
		
		public function Main()
		{
			super();
			
			initVars();
		}
		
		private function initVars():void
		{
			appCode = new AppCode();
			
			appCode.x = (this.stage.stageWidth - appCode.width) * 0.5 - appCode.getBounds(appCode).x;
			appCode.y = (this.stage.stageHeight- appCode.height)* 0.5 - appCode.getBounds(appCode).y;
			
			this.stage.addChild(appCode);
		}
		
	}

}