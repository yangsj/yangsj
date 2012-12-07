package view.ectypal
{


	/**
	 * 说明：EctypalType
	 * @author Victor
	 * 2012-10-23
	 */

	public class EctypalType
	{


		/** status未解锁状态 */
		public static const STATUS_1 : int = 1;

		/** status已解锁但未过关状态 */
		public static const STATUS_2 : int = 2;

		/** status已过关状态 */
		public static const STATUS_3 : int = 3;


		/** type普通关卡 */
		public static const TYPE_1 : int = 1;

		/** type打boss关卡 */
		public static const TYPE_2 : int = 2;

		/** type向前一个副本 */
		public static const TYPE_3 : int = 3;

		/** type向后一个副本 */
		public static const TYPE_4 : int = 4;
		

		/** 战斗结果【胜利】 */
		public static const RESULT_WIN : int = 1;

		/** 战斗结果【失败】 */
		public static const RESULT_LOSE : int = 0;


		/** 没有分支 */
		public static const BRANCH_0 : int = 0;

		/** 表示有分支（默认分支为2）：计算方式：currentLevel + 1 和 currentLevel + x  */
		public static const BRANCH_X : int = -1;

		/////// 资源 label frame name

		/** 【帧标签】未解锁状态 */
		public static const LABEL_FRAME_1 : String = "lab_1";

		/** 【帧标签】 解锁未过关状态 */
		public static const LABEL_FRAME_2 : String = "lab_2";

		/** 【帧标签】已过关状态 */
		public static const LABEL_FRAME_3 : String = "lab_3";

		/** 【帧标签】打boss状态 */
		public static const LABEL_FRAME_4 : String = "lab_4";

		/** 【帧标签】跳至前一个副本状态 */
		public static const LABEL_FRAME_5 : String = "lab_5";

		/** 【帧标签】跳至后一个副本状态 */
		public static const LABEL_FRAME_6 : String = "lab_6";



	}

}
