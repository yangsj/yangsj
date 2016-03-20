package diamonds
{
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-2 下午05:47:45
	 */
	public class ScorePrice
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		/**
		 * 
		 * 
		 */
		public function ScorePrice()
		{
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 第一等级  3-4
		 */
		static public const First_Grade_Single_Price:Number = 100;
		
		/**
		 * 第二等级  5-8
		 */
		static public const Second_Grade_Single_Price:Number = 200;
		
		/**
		 * 第三等级  9-29
		 */
		static public const Third_Grade_Single_Price:Number = 400;
		
		/**
		 * 第四等级  >=30
		 */
		static public const Fourth_Grade_Single_Price:Number = 800;
		
		         /////////////// function /////////////////////
		
		/**
		 * 计算单次点击消除方块的得分
		 * @param num 消除的数目
		 * @return 
		 * 
		 */
		static public function resultValue(num:int):Number
		{
			if (num == 3 || num == 4)
			{
				return num * First_Grade_Single_Price;
			}
			else if (num >= 5 && num <= 8)
			{
				return num * Second_Grade_Single_Price;
			}
			else if (num >= 9 && num <= 29)
			{
				return num * Third_Grade_Single_Price;
			}
			else if (num >= 30)
			{
				return num * Fourth_Grade_Single_Price;
			}
			else
			{
				return num * First_Grade_Single_Price;
			}
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}