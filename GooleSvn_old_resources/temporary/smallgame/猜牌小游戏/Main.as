package
{
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class Main extends Sprite 
	{
		//private var tt:TextField;
		//private var t1:TextField;
		//private var t2:TextField;
		//private var t3:TextField;
		//private var t4:TextField;
		//private var add_t:TextField;
		//private var total_t:TextField;
		//private var win_t:TextField;
		//private var time_t:TextField;
		
		private var num1:int = 0;
		private var num2:int = 0;
		private var num3:int = 0;
		private var num4:int = 0;
		private var num11:int = 0;
		private var num22:int = 0;
		private var num33:int = 0;
		private var num44:int = 0;
		private var totalScore:int  = 100;
		private var singleScore:int = 5;
		private var winScroe:int = 0;
		private var timeNum:int  = 0;
		private var resultNum:int = 0;
		
		private var timer1:Timer;
		private var timer2:Timer;
		private var timer3:Timer;
		
		private var array1:Array = ['黑桃','红桃','梅花','方块'];
		private var array2:Array = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'];
		
		private var globalText:String = ' ';
		private const CONST_NUM:int = 5;
		
		public function Main()
		{
			if (this.stage)
			{
				addTextContent();
				addEvents();
				init();
			}
		}
		
////////////////////////////////////////// private /////////////////////////////////////////////////////

		/** Timer 计时器开始计时 */
		private function init():void
		{
			timeNum = CONST_NUM;
			timer1.start();
		}
		/** 填充文本框内容 */
		private function addTextContent():void
		{
			total_t.text = String(totalScore);
			win_t.text   = String(winScroe);
			t0.text = '结果等待中...';
			t1.text = '0';
			t2.text = '0'; 
			t3.text = '0';
			t4.text = '0';
			tt1.text = '0';
			tt2.text = '0'; 
			tt3.text = '0';
			tt4.text = '0';
			
			if ( timeNum == 0 )
			{
				setButtonMouseEnabled(false);
			}
			else
			{
				setButtonMouseEnabled(true);
			}
			
			if (timer1 == null)
			{
				timer1 = new Timer(1000); // 每轮出牌倒计时 器
			}
			if (timer2 == null)
			{
				timer2 = new Timer(5000); // 每轮间隔时间  器
			}
			if (timer3 == null)
			{
				timer3 = new Timer(15);
			}
		}
		/** 设置按钮的是否可点击 */
		private function setButtonMouseEnabled($boolean:Boolean):void
		{
			btn1.mouseEnabled = btn2.mouseEnabled = btn3.mouseEnabled = btn4.mouseEnabled = $boolean;
		}
		/** 计算结果 */
		private function calculateResult():void
		{
			trace(this['t' + (resultNum + 1)].text);
			winScroe = int(this['t' + (resultNum + 1)].text) * 4;
			win_t.text = String(winScroe);
			timer3.start();
			
			this['num' + (resultNum + 1) + '' + (resultNum + 1)] += 1;
			this['tt' + (resultNum + 1)].text = String(this['num' + (resultNum + 1) + '' + (resultNum + 1)]);
		}
		
//////////////////////////////////////////// events ////////////////////////////////////////////////////
		
		/** 添加时间侦听器 */
		private function addEvents():void
		{
			this.stage.addEventListener(MouseEvent.CLICK, stageMouseClickHandler);
			time_t.addEventListener(Event.CHANGE, textChangeEventHandler);
			timer1.addEventListener(TimerEvent.TIMER, timer1_eventHandler);
			timer2.addEventListener(TimerEvent.TIMER, timer2_eventHandler);
			timer3.addEventListener(TimerEvent.TIMER, timer3_eventHandler);
		}
		
		/** 计时器时间显示文本 Change 事件侦听函数 */
		private function textChangeEventHandler(e:Event):void 
		{
			if (int(time_t.text) <= 0)
			{
				setButtonMouseEnabled(false);
			}
			else
			{
				setButtonMouseEnabled(true);
			}
		}
		/** stage 侦听函数 */
		private function stageMouseClickHandler(e:MouseEvent):void 
		{
			var targetName:String = e.target.name;
			
			if (targetName == 'btn1')
			{
				if (totalScore >= 5)
				{
					totalScore -= 5;
					num1 += 5;
				}
				else
				{
					num1 += totalScore;
					totalScore = 0;
				}
				t1.text = num1.toString();
			}
			else if (targetName == 'btn2')
			{
				if (totalScore >= 5)
				{
					totalScore -= 5;
					num2 += 5;
				}
				else
				{
					num2 += totalScore;
					totalScore = 0;
				}
				t2.text = num2.toString();
			}
			else if (targetName == 'btn3')
			{
				if (totalScore >= 5)
				{
					totalScore -= 5;
					num3 += 5;
				}
				else
				{
					num3 += totalScore;
					totalScore = 0;
				}
				t3.text = num3.toString();
			}
			else if (targetName == 'btn4')
			{
				if (totalScore >= 5)
				{
					totalScore -= 5;
					num4 += 5;
				}
				else
				{
					num4 += totalScore;
					totalScore = 0;
				}
				t4.text = num4.toString();
			}
			else if (targetName == 'btn_add')
			{
				totalScore += int(add_t.text);
				total_t.text = String(totalScore);
				add_t.text = '0';
			}
			total_t.text = String(totalScore);
		}
		/** Timer 1 侦听函数 */
		private function timer1_eventHandler(e:TimerEvent):void 
		{
			time_t.text = String(timeNum);
			if (timeNum > 0)
			{
				timeNum--;
			}
			else
			{
				timer1.stop();
				setButtonMouseEnabled(false);
				resultNum = int(Math.random() * array1.length);
				var strLab:String = array2[int(Math.random() * array2.length)];
				t0.text = array1[resultNum] + strLab;
				
				var tempStr:String = '【' + t0.text + '】';
				if (resultNum % 2 == 1)
				{
					t0.backgroundColor = 0xff0000;
					tempStr = "<font color='0xff0000'>" + tempStr + "</font>";
				}
				else
				{
					t0.backgroundColor = 0x000000;
					tempStr = "<font color='0x000000'>" + tempStr + "</font>";
				}
				
				globalText += tempStr;
				trace(globalText);
				record_t.htmlText = globalText;
				calculateResult();
			}
		}
		/** Timer 2 侦听函数 */
		private function timer2_eventHandler(e:TimerEvent):void 
		{
			timeNum = CONST_NUM;
			t0.backgroundColor = 0xffffff;
			t0.text = '结果等待中...';
			timer2.stop();
			timer1.start();
			setButtonMouseEnabled(true);
		}
		/** Timer 3 侦听函数 */
		private function timer3_eventHandler(e:TimerEvent):void 
		{
			if (winScroe > 0)
			{
				winScroe -= 1;
				totalScore += 1;
				win_t.text = String(winScroe);
				total_t.text = String(totalScore);
			}
			else
			{
				num1 = num2 = num3 = num4 = 0;
				t1.text = '0';
				t2.text = '0';
				t3.text = '0';
				t4.text = '0';
				timer2.start();
				timer3.stop();
			}
			
			
		}
	}
	
}
