package net.vyky.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/** 
	 * 说明：
	 * @author 杨胜金
	 * 2011-10-27 下午02:48:55
	 */
	public class VTimeToString
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		
		public function VTimeToString()
		{
		}
		
		/**
		 * 返回格式为 00:00:00(小时:分钟:秒)
		 * @param $second 秒（'）为单位
		 * @return 
		 * 
		 */
		static public function secondToTextString($second:int):String
		{
			var textString:String;
			
			var hour:String = "hours ";
			var minu:String = "minutes ";
			var seco:String = "seconds ";
			
			var h_short:String = "hours ";
			var m_short:String = "minutes ";
			
			if ($second < 3600)
			{
				if ($second % 60 == 0)
				{
					textString = String($second / 60) + minu;
				}
				else
				{
					textString = String(int($second / 60)) + m_short + String($second % 60) + seco;
				}
			}
			else
			{
				if ($second % 3600 == 0)
				{
					textString = String(int($second / 3600)) + hour;
				}
				else
				{
					var temp_minu:Number = $second % 3600;
					if ( temp_minu % 60 == 0)
					{
						textString = String(int($second / 3600)) + h_short + String(temp_minu / 60) + m_short;
					}
					else
					{
						textString = String(int($second / 3600)) + h_short + String(int(temp_minu / 60)) + m_short + String(temp_minu % 60) + seco;
					}
				}
			}
			
			return textString;
		}
		
		/**
		 * 返回格式为 00:00(小时:分钟)
		 * @param $second 秒（'）为单位
		 * @return 字符串String
		 */
		static public function minutesToTextString($second:int):String
		{
			var textString:String;
			var hour:String = "hours ";
			var minu:String = "minutes ";
			var h_short:String = "hours ";
			var m_short:String = "minutes ";
			
			if ($second < 3600)
			{
				textString = String($second) + minu;
			}
			else
			{
				if ($second % 3600 == 0)
				{
					textString = String(int($second / 3600)) + hour;
				}
				else
				{
					textString = String(int($second / 3600)) + h_short + String(int($second % 3600 / 60 )) + m_short;
				}
			}
			
			return textString;
		}
		
		/** 
		 * 返回的格式如2011-06-29  17:12(今天 17:12， 昨天 17:12)
		 * @param value 秒（'）（从1970年经过的秒数）
		 * @param len 时分秒长度（显示到分len = 5, 显示到秒len = 8）默认到分
		 * @return 字符串String
		 */
		static public function timeToYearMonthDay(value:int, len:int = 5):String
		{
			if (len != 5 && len != 8)
			{
				len = 5;
			}
			
			var rest:Date = new Date(value * 1000);
			var r_Y:Number = rest.fullYear;
			var r_M:Number = rest.month + 1;
			var r_D:Number = rest.date;
			var r_HM:String = rest.toTimeString().substr(0, len);
			
			var dayToday:String = "today";
			var yesterday:String = "yesterday";
			var last:String;
			
			last = r_Y + '-'+ (r_M < 10 ? '0'+r_M : r_M) + '-'+ (r_D < 10 ? '0' + r_D : r_D) + '  '+ r_HM;
			
			return last;
		}
		
		/**
		 * 以指定的间隔（以毫秒为单位）的Timer。
		 * @param $onCompleted	结束时运行的函数（TimerEvent.TIMER_COMPLETE派发运行函数
		 * @param $delay	间隔时间
		 * @param $overArgs	结束时运行函数的参数（将参数顺序定义到数字中
		 * @param $repeatCount	重复次数
		 * @param $onUpdate	更新运行函数（TimerEvent.TIMER派发运行
		 * @param $updateArgs	更新运行函数参数
		 * 
		 */
		static public function setIntervalTimer($onCompleted:Function, $delay:Number, $overArgs:Array=null, $repeatCount:int=1, $onUpdate:Function=null, $updateArgs:Array=null):void
		{
			var timer:Timer = new Timer($delay, $repeatCount);
			timer.addEventListener(TimerEvent.TIMER, onUpdateTimerHandler);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onCompletedTimerHandler);
			timer.start();
			function onUpdateTimerHandler(e:TimerEvent):void
			{
				if ($onUpdate != null)
				{
					$onUpdate.apply(null, $updateArgs);
				}
			}
			function onCompletedTimerHandler(e:TimerEvent):void
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onCompletedTimerHandler);
				timer = null;
				$onCompleted.apply(null, $overArgs);
			}
		}
		
		
		
		
		
	}
	
}