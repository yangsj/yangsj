package character
{


	/**
	 * 动画的帧标签
	 */
	public class FrameLabels
	{
		/**
		 * 行走
		 */
		public static const WALK : String = 'walk';

		/**
		 * 站立
		 */
		public static const STAND : String = 'stand';

		/**
		 * 死亡
		 */
		public static const DEAD : String = 'dead1';

		/**
		 * 攻击
		 */
		public static const ATTACK : String = 'attack';

		/**
		 * 被攻击
		 */
		public static const HURT : String = 'hurt';

		/**
		 * 暴怒开始（不一定每个人都有）
		 * @default
		 */
		public static const S_START : String = 's_start';

		/**
		 *
		 * @default
		 */
		public static const S_WALK : String = 's_walk';

		/**
		 * 暴怒攻击（不一定每个人都有）
		 * @default
		 */
		public static const S_ATTACK : String = 's_attack';

		/**
		 * 点头，表示已经准备好了
		 * @default
		 */
		public static const READY : String = 'ready';
	}
}
