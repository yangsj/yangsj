package core.game
{
	public class DispelMainType
	{
		
		/** 行数 */
		static public const ROWS:int = 10;
		/** 列数 */
		static public const COLS:int = 10;
		
		/** 普通特效对象池存取名字 */
		public static const generalEffectName:String	= "generalEffectName";
		/** 興奮（极速）特效对象池存取名字 */
		public static const excitingEffectName:String	= "excitingEffectName";
		/** 道具特效对象池存取名字 */
		public static const usePropEffectName:String 	= "usePropEffectName";
		
		
		/**
		 * 定义钻石颜色种类数目，同时也用于定义钻石各种颜色对应的id，从1到该值之间。
		 * <li>1 blue 蓝色 #0000ff
		 * <li>2 green 绿色 #00ff00
		 * <li>3 red 红色 #ff0000
		 * <li>4 purple 紫色 #660000
		 * <li>5 yellow 黄色 #ffff00
		 */
		static public const DIAMOND_COLOR_NUM:int = 5;
		
		/**
		 * 定义道具的种类数目，同时定义各个道具对应的id，从100到100加该值之间。
		 * <li>101 十字消除
		 * <li>102 沙漏（加时间6秒）
		 * <li>103 炸弹（5*5区域）
		 * <li>104 消除同色钻石（紫色Purple）
		 * <li>105 炸弹（3*3区域）
		 * <li>106 消除同色钻石（蓝色Blue）
		 * <li>107 消除同色钻石（绿色Green）
		 * <li>108 消除同色钻石（红色Red）
		 * <li>109 消除同色钻石（黄色Yellow）
		 */
		static public const DIAMOND_PROP_NUM:int = 9;
		
	}
}