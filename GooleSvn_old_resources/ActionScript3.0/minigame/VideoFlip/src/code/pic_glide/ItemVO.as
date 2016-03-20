package code.pic_glide
{
	
	/**
	 * 说明：ItemVO
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-5
	 */
	
	public class ItemVO
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		public var x:Number 		= 0;
		public var y:Number 		= 0;
		public var width:Number 	= 1;
		public var height:Number 	= 1;
		public var alpha:Number		= 1;
		public var index:int		= 0;
		
		public function ItemVO($x:Number=0, $y:Number=0, $width:Number=1, $height:Number=1, $alpha:Number=1, $index:int=0)
		{
			x = $x;
			y = $y;
			width = $width;
			height= $height;
			alpha = $alpha;
			index = $index;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}