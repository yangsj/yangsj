package diamonds
{
	
	/**
	 * 说明：AddDiamondProbabilityCalculations 定义新增加的 Diamonds 条件常量 概率计算
	 * @author 杨胜金<br>
	 * 2012-2-6上午10:37:48
	 */
	
	public class AddDiamondProbabilityCalculations
	{
		
		/////////////////////////////////static ////////////////////////////
		
		/** 连续添加的方块是同种颜色的次数 */
		static private var addOneColorNum:int = 0;
		/** 连续添加的方块是同种颜色的最大次数 */
		static private const addOneColorMaxNum:int = 3;
		
		/**　第一个范围（3 < x <= 4） */
		static public const ADD_RANGE_ONE:int = 3;
		/**　第二个范围（5 < x <= 6） */
		static public const ADD_RANGE_TWO:int = 5;
		/**　第三个范围（7 < x <= 9）*/
		static public const ADD_RANGE_THREE:int = 7;
		/**　第四个范围（10 < x <= 50）*/
		static public const ADD_RANGE_FOUR:int = 10;
		/**　第五个范围（ >= 51）　*/
		static public const ADD_RANGE_FIVE:int = 51;
		
			//////////　定义概率　////////////
		
		static public const max:Number = 100;
		
		/** 第一个范围取 1 种颜色的概率 */
		static public const ADD_RANGE_ONE_NUM_1:int = 10; // 10%
		/** 第一个范围取 2 种颜色的概率 */
		static public const ADD_RANGE_ONE_NUM_2:int = 20; // 20%
		/** 第一个范围取 3 种颜色的概率 */
		static public const ADD_RANGE_ONE_NUM_3:int = 0; // 0%
		/** 第一个范围取 4 种颜色的概率 */
		static public const ADD_RANGE_ONE_NUM_4:int = 0; // 0%
		/** 第三个范围取 5 种颜色的概率 */
		static public const ADD_RANGE_ONE_NUM_5:int = 70;  // 70%
		
		/** 第二个范围取 1 种颜色的概率 */
		static public const ADD_RANGE_TWO_NUM_1:int = 20; // 20%
		/** 第二个范围取 2 种颜色的概率 */
		static public const ADD_RANGE_TWO_NUM_2:int = 5; // 5%
		/** 第二个范围取 3 种颜色的概率 */
		static public const ADD_RANGE_TWO_NUM_3:int = 10; // 10%
		/** 第二个范围取 4 种颜色的概率 */
		static public const ADD_RANGE_TWO_NUM_4:int = 20; // 20%
		/** 第二个范围取 5 种颜色的概率 */
		static public const ADD_RANGE_TWO_NUM_5:int = 45;  // 45%
		
		/** 第三个范围取 1 种颜色的概率 */
		static public const ADD_RANGE_THREE_NUM_1:int = 10; // 10%
		/** 第三个范围取 2 种颜色的概率 */
		static public const ADD_RANGE_THREE_NUM_2:int = 0; // 0%
		/** 第三个范围取 3 种颜色的概率 */
		static public const ADD_RANGE_THREE_NUM_3:int = 0; // 0%
		/** 第三个范围取 4 种颜色的概率 */
		static public const ADD_RANGE_THREE_NUM_4:int = 0; // 0%
		/** 第三个范围取 5 种颜色的概率 */
		static public const ADD_RANGE_THREE_NUM_5:int = 90;  // 90%
		
		/** 第四个范围取 1 种颜色的概率 */
		static public const ADD_RANGE_FOUR_NUM_1:int = 5; // 5%
		/** 第四个范围取 2 种颜色的概率 */
		static public const ADD_RANGE_FOUR_NUM_2:int = 0; // 0%
		/** 第四个范围取 3 种颜色的概率 */
		static public const ADD_RANGE_FOUR_NUM_3:int = 0; // 0%
		/** 第四个范围取 4 种颜色的概率 */
		static public const ADD_RANGE_FOUR_NUM_4:int = 0; // 0%
		/** 第四个范围取 5 种颜色的概率 */
		static public const ADD_RANGE_FOUR_NUM_5:int = 95; // 95%
		
		/** 第五个范围取 1 种颜色的概率 */
		static public const ADD_RANGE_FIVE_NUM_1:int = 0; // 0%
		/** 第五个范围取 2 种颜色的概率 */
		static public const ADD_RANGE_FIVE_NUM_2:int = 0; // 0%
		/** 第五个范围取 3 种颜色的概率 */
		static public const ADD_RANGE_FIVE_NUM_3:int = 0; // 0%
		/** 第五个范围取 4 种颜色的概率 */
		static public const ADD_RANGE_FIVE_NUM_4:int = 0; // 0%
		/** 第五个范围取 5 种颜色的概率 */
		static public const ADD_RANGE_FIVE_NUM_5:int = 100;  // 100%
		
		///////////////////////////////// vars /////////////////////////////////
		
		
		
		public function AddDiamondProbabilityCalculations()
		{
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 根据添加的数目 计算相应情况下出现钻石的种类数
		 * @param addDiamondsNum 新添加（补充）的钻石数
		 * @return len：钻石的种类数
		 * 
		 */
		public static function probabilityCalculations(addDiamondsNum:int):int
		{
			var len:int = 4; // 选取 需要添加的钻石的种类数目
			var lenRd:int=int(Math.random() * 100); // 一个计算概率的随机数值
			
			var num1:int;
			var num2:int;
			var num3:int;
			var num4:int;
			
			if (addDiamondsNum >= ADD_RANGE_FIVE)
			{
				len = 5;
			}
			else if (addDiamondsNum >= ADD_RANGE_FOUR)
			{
				if (lenRd >= (num1 = max - ADD_RANGE_FOUR_NUM_1))
				{
					len=1;
				}
				else if (lenRd >= (num2 = num1 - ADD_RANGE_FOUR_NUM_2))
				{
					len=2;
				}
				else if (lenRd >= (num3 = num2 - ADD_RANGE_FOUR_NUM_3))
				{
					len=3;
				}
				else if (lenRd >= (num4 = num3 - ADD_RANGE_FOUR_NUM_4))
				{
					len=3;//4;
				}
				else if (lenRd >= num4 - ADD_RANGE_FOUR_NUM_5)
				{
					len=3;//5;
				}
			}
			else if (addDiamondsNum >= ADD_RANGE_THREE)
			{
				if (lenRd >= (num1 = max - ADD_RANGE_THREE_NUM_1))
				{
					len=1;
				}
				else if (lenRd >= (num2 = num1 - ADD_RANGE_THREE_NUM_2))
				{
					len=2;
				}
				else if (lenRd >= (num3 = num2 - ADD_RANGE_THREE_NUM_3))
				{
					len=3;
				}
				else if (lenRd >= (num4 = num3 - ADD_RANGE_THREE_NUM_4))
				{
					len=3;//4;
				}
				else if (lenRd >= num4 - ADD_RANGE_THREE_NUM_5)
				{
					len=3;//5;
				}
			}
			else if (addDiamondsNum >= ADD_RANGE_TWO)
			{
				if (lenRd >= (num1 = max - ADD_RANGE_TWO_NUM_1))
				{
					len=1;
				}
				else if (lenRd >= (num2 = num1 - ADD_RANGE_TWO_NUM_2))
				{
					len=2;
				}
				else if (lenRd >= (num3 = num2 - ADD_RANGE_TWO_NUM_3))
				{
					len=3;
				}
				else if (lenRd >= (num4 = num3 - ADD_RANGE_TWO_NUM_4))
				{
					len=3;//4;
				}
				else if (lenRd >= num4 - ADD_RANGE_TWO_NUM_5)
				{
					len=3;//5;
				}
			}
			else
			{
				if (lenRd >= (num1 = max - ADD_RANGE_ONE_NUM_1))
				{
					len=1;
				}
				else if (lenRd >= (num2 = num1 - ADD_RANGE_ONE_NUM_2))
				{
					len=2;
				}
				else if (lenRd >= (num3 = num2 - ADD_RANGE_ONE_NUM_3))
				{
					len=3;
				}
				else if (lenRd >= (num4 = num3 - ADD_RANGE_ONE_NUM_4))
				{
					len=3;//4;
				}
				else if (lenRd >= num4 - ADD_RANGE_ONE_NUM_5)
				{
					len=3;//5;
				}
			}
			
			if (len == 1)
			{
				addOneColorNum++;
				len = addOneColorNum <= addOneColorMaxNum ? len : 3;//5;
			}
			else 
			{
				clear();
			}
			
			return len;
		}
		
		public static function clear():void
		{
			addOneColorNum = 0;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}