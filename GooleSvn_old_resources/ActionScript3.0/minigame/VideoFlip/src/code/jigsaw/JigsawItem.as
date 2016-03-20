package code.jigsaw
{
	import flash.display.Sprite;
	
	
	/**
	 * 说明：JigsawItem
	 * @author victor
	 * 2012-3-7 下午10:43:46
	 */
	
	public class JigsawItem extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function JigsawItem($width:Number, $height:Number)
		{
			super();
			this.graphics.beginFill(0xfff000, 0);
			this.graphics.drawRect(0, 0, $width, $height);
			this.graphics.endFill();
			this.mouseChildren=false;
			this.buttonMode=true;
			this.cacheAsBitmap=true;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// override ///////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}