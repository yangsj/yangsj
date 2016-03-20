package diamonds.house
{
	
	/** 
	 * 说明：
	 * @author Victor
	 * 2011-12-7 下午02:24:55
	 */
	public class HouseType
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function HouseType()
		{
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * 普通消除
		 */
		static public const TYPE_EFFECT_CLICK_GENERAL:String = "general";
		
		/**
		 * 少于3次道具使用
		 */
		static public const TYPE_EFFECT_CLICK_SPECIAL:String = "special";
		
		/**
		 * 大于3次道具使用
		 */
		static public const TYPE_EFFECT_CLICK_PARTICULAR:String = "particular";
		
		
		// framelabal 
		
		/**
		 * 普通消除时房子抖动
		 */
		static public const framelabal_general_1:String = "lab_number";
		
		/**
		 * 第一次普通消除房子摧毁过程
		 */
		static public const framelabal_general_2:String = "lab_number_start";
		
		/**
		 * 第一次特殊消除房子抖动
		 */
		static public const framelabal_special_1:String = "lab_special";
		
		/**
		 * 第一次特殊消除房子摧毁过程
		 */
		static public const framelabal_special_2:String = "lab_special__start";
		
		/**
		 * 第一次大于3次道具消除房子抖动
		 */
		static public const framelabal_particular_1:String = "lab_special3";
		
		/**
		 * 第一次大于3次道具房子摧毁过程
		 */
		static public const framelabal_particular_2:String = "lab_special3__start";
		
		
		
			//////////////////////// new ////////////////////////
		
		
				//////////////////framelabal///////////////////
		
		static public const LAB_START:String = "lab_start";
		static public const LAB_1:String = "lab_1";
		static public const LAB_2:String = "lab_2";
		static public const LAB_3:String = "lab_3";
		static public const LAB_4:String = "lab_4";
		static public const LAB_END:String = "lab_end";
		
				//////////////////framelabal///////////////////
		
			//////////////////////// new ////////////////////////
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
	}
	
}