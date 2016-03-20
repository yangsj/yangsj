package
{
	import code.jigsaw.JigsawMain;
	import code.pic_glide.PicGlideMain;
	
	import flash.display.Sprite;
	
	
	[SWF(width="800", height="400")]
	
	/**
	 * 说明：VideoFlip
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-5
	 */
	public class VideoFlip extends Sprite
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		private var picGlideMain:PicGlideMain;
		private var jigsawMain:JigsawMain;
		
		public function VideoFlip()
		{
			inits();
			picGlideMain = new PicGlideMain();
			this.addChild(picGlideMain);
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function inits():void
		{
			this.graphics.beginFill(0xFFFFCC);
			this.graphics.drawRect(0,0,this.stage.stageWidth, this.stage.stageHeight);
			this.graphics.endFill();
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}