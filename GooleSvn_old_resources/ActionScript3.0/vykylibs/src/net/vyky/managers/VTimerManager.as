package net.vyky.managers
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 说明：TimerManager
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-3-17
	 */

	public class VTimerManager
	{

		/////////////////////////////////static ////////////////////////////

		/**
		 * 记录添加的 计时器 清单
		 */
		private static var timerList:Array = new Array();
		/**
		 * 记录添加的计时器想对应的定时执行的函数
		 */
		private static var callBList:Array = new Array();
		/**
		 * 记录添加计时器停止计时器的限制条件函数
		 */
		private static var limitList:Array = new Array();
		/**
		 * 每个name对应的一个timer的timer监听函数
		 */
		private static var timerFunc:Array = new Array();

		public function VTimerManager()
		{
		}

		/////////////////////////////////////////public /////////////////////////////////

		/**
		 * 向管理器添加一个要定时执行的函数，执行此函数后，将自动开启timer,而无需手动开启。
		 * 当满足条件后将根据条件移除某个函数。当函数列表为空时，将停止timer,节省资源。
		 * @param $name 一个存取的名字
		 * @param $callFunc 每次执行的回调函数
		 * @param $timerInter 时间间隔
		 * @param $limitFunc 必须有返回值,当返回值为true的时候,将停止此绑定函数的循环
		 * 
		 */
		public static function addTimer($name:String, $callFunc:Function, $timerInter:int = 50, $limitFunc:Function = null):void
		{
			if ($limitFunc == null)
			{
				$limitFunc = function():Boolean
				{
					return false;
				}
			}
			//如果还没有定义这个间隔的timer,则定义之
			if (timerList[$name] == undefined || timerList[$name] == null)
			{
				timerList[$name] = new Timer($timerInter);
			}
			
			//向某个定时器添加一个要定时执行的函数
			if (callBList[$name] == undefined || callBList[$name] == null)
			{
				callBList[$name] = new Array();
				limitList[$name] = new Array();
				
				callBList[$name].push($callFunc);
				limitList[$name].push($limitFunc);
			}
			else
			{
				callBList[$name].push($callFunc);
				limitList[$name].push($limitFunc);
			}
			
			if (timerFunc[$name] == undefined || timerFunc[$name] == null)
			{
				timerFunc[$name] = function ():void
				{
					try
					{
						for each (var funclimit:Function in limitList[$name])
						{
							if (funclimit() == true)
							{
								removeTimer($name, funclimit);
							}
						}
					}
					catch (e:Error) { }
					
					var length:int = callBList[$name].length;
					if (length == 0)
					{
						timerList[$name].stop();
					}
					for each (var funccallb:Function in callBList[$name])
					{
						funccallb();
					}
				}
			}
			timerList[$name].addEventListener(TimerEvent.TIMER, timerFunc[$name]);
			if (timerList[$name].running == false)
			{
				timerList[$name].start();
			}
		}
		
		/**
		 * 管理器中是否存在指定名字的Timer或指定的 callBack　函数。若$callFunc的值不存在将直接断定是
		 * 否有指定的Timer，若$callFunc存在则会判定在指定Timer中是否有该函数存在于列表中
		 * @param $name　Timer名字
		 * @param $callFunc　指定Timer中的一个回调函数
		 * @return 
		 * 
		 */
		public static function hasTimer($name:String, $callFunc:Function = null):Boolean
		{
			if ($callFunc != null)
			{
				var ary1:Array = callBList[$name];
				var ary2:Array = limitList[$name];
				var ii:*;
				for each (ii in ary1)
				{
					if (ii == $callFunc)
					{
						return true;
					}
				}
				for each (ii in ary2)
				{
					if (ii == $callFunc)
					{
						return true;
					}
				}
			}
			else
			{
				if (timerList[$name]) return true;
			}
			return false;
		}
		
		/**
		 * 暂停指定名字的计时器
		 * @param $name
		 * 
		 */
		public static function pauseTimer($name:String):void
		{
			if (timerList[$name]) 
			{
				if (timerList[$name].running)
				{
					timerList[$name].stop();
				}
			}
		}
		
		/**
		 * 启动指定的计时器
		 * @param $name
		 * 
		 */
		public static function resumeTimer($name:String):void
		{
			if (timerList[$name]) 
			{
				if (timerList[$name].running == false)
				{
					timerList[$name].start();
				}
			}
		}
		
		/**
		 * 移除指定名字的计时器或从指定计时器回调函数列表中删除是定的回调函数
		 * @param $name　指定名字的计时器
		 * @param $callFunc　可以是判定条件的函数，也可是每次执行的回调函数
		 * 
		 */
		public static function removeTimer($name:String, $callFunc:Function = null):void
		{
			if ($callFunc == null)
			{
				var timer:Timer = timerList[$name] as Timer;
				if (timer)
				{
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER, timerFunc[$name]);
					timerList[$name] = null;
					timerFunc[$name] = null;
					callBList[$name] = [];
					limitList[$name] = [];
					timer = null;
				}
				
			}
			else
			{
				var ary1:Array = callBList[$name];
				var ary2:Array = limitList[$name];
				var num:int;
				var func:Function;
				if (ary1)
				{
					for each (func in ary1)
					{
						if (func == $callFunc)
						{
							num = ary1.indexOf(func);
							if (num >= 0)
							{
								ary1.splice(num, 1);
								ary2.splice(num, 1);
								callBList[$name] = ary1;
								limitList[$name] = ary2;
								return ;
							}
						}
					}
				}
				if (ary2)
				{
					for each (func in ary2)
					{
						if (func == $callFunc)
						{
							num = ary2.indexOf(func);
							if (num >= 0)
							{
								ary1.splice(num, 1);
								ary2.splice(num, 1);
								callBList[$name] = ary1;
								limitList[$name] = ary2;
								return ;
							}
						}
					}
				}
			}
		}


	}

}
