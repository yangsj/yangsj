package module
{


	/**
	 *
	 * @author Chenzhe
	 */
	public class Rule
	{
		/**
		 * 中断当前进程
		 * @default
		 */
		public static var KILL : String = 'KILL';
		/**
		 * 中断当前进程，当运行完之后重启当前进程
		 * @default
		 */
		public static var KILL_RESTART : String = 'KILL_RESTART';
		/**
		 * 暂停当前进程，在新进程完成之后恢复当前进程
		 * @default
		 */
//		public static var INTERRUPT : String = 'INTERRUPT';
		/**
		 * 当当前进程结束之后再次请求该进程
		 */
		public static var WAIT : String = 'WAIT';

		/**
		 *
		 */
		public function Rule()
		{
		}
	}
}
