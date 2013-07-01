package victor.view
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-6-28
	 */
	public class URL
	{
		public function URL()
		{
		}
		
		/**
		 * 获取头像资源地址
		 * @param index 编号
		 * @return 
		 */
		public static function getHeadUrl(index:int):String
		{
			return "assets/head/" + index + ".jpg";
		}
		
		/**
		 * 获取背景资源地址
		 * @param index
		 * @return 
		 */
		public static function getBgUrl(index:int):String
		{
			return "assets/bg/" + index + ".jpg";
		}
		
		
	}
}