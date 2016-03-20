package code.chapter_03
{
	import flash.display.DisplayObject;
	
	/**
	 * 说明：GraphicTile
	 * @author victor
	 * 2012-7-14 下午10:55:15
	 */
	
	public class GraphicTile extends IsoObject
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function GraphicTile(size:Number, classRef:Class, xoffset:Number, yoffset:Number)
		{
			super(size);
			var gfx:DisplayObject = new classRef() as DisplayObject;
			gfx.x = -xoffset;
			gfx.y = -yoffset;
			addChild(gfx);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}