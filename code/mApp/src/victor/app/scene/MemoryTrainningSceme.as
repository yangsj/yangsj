package victor.app.scene
{
	import com.greensock.TweenLite;
	
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import victor.app.Main;
	import victor.app.panel.MemoryTrainningPanel;
	import victor.framework.core.AutoLayout;
	import victor.framework.core.Scene;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-14
	 */
	public class MemoryTrainningSceme extends Scene
	{
		public static const CODE:Vector.<String> = new <String>[	"衣","鹅","山","尸","舞","牛","漆","耙","酒","石",
															"雨衣","鱼儿","雨伞","鱼市","鹦鹉","衣钮","玉器","一把","一脚","恶灵",
															"鳄鱼","鹅儿","和尚","恶狮","二胡","二楼","耳机","恶霸","二舅","山林",
															"鲨鱼","沙鸥","闪闪","沙子","珊瑚","山路","山鸡","三八","三角","司令",
															"石椅","死鹅","石山","石狮","食物","死牛","司机","丝帕","死囚","武林",
															"舞衣","虎儿","火山","武士","五虎","蜗牛","武器","尾巴","五角","榴莲",
															"纽约","牛耳","硫酸","牛屎","绿屋","溜溜","楼梯","牛排","牛角","麒麟",
															"鲸鱼","企鹅","纸扇","骑士","骑虎","骑牛","机器","旗袍","气球","巴黎",
															"白蚁","拔河","爬山","巴士","白虎","白鹭","白旗","爸爸","排球","旧玲",
															"球衣","球儿","球赛","酒师","酒壶","酒楼","酒席","酒吧","舅舅","眼镜"];
		
		private var uiRes:UI_MemoryTrainningSceme;
		
		private var _trainningTime:int = 100;
		private var _isRandom:Boolean = false;
		private var _isTrainningNumber:Boolean = true;
		private var _index:int = 0;
		private var _isStarting:Boolean = false;
		
		private var gapTime:Number = 1;
		private var codePanel:MemoryTrainningPanel;
		
		public function MemoryTrainningSceme()
		{
			super();
		}
		
		override public function dispose():void
		{
			TweenLite.killDelayedCallsTo( startCd );
			if ( codePanel )
			{
				codePanel.dispose();
				codePanel = null;
			}
			if ( uiRes )
			{
				uiRes.removeEventListener( MouseEvent.CLICK, uiSettingClickHandler );
				uiRes = null;
			}
			super.dispose();
		}
		
		override protected function createUI():void
		{
			uiRes = new UI_MemoryTrainningSceme();
			addChild( uiRes );
			AutoLayout.layout( uiRes );
			uiRes.boxCheck1.mouseChildren = false;
			uiRes.boxCheck2.mouseChildren = false;
			uiRes.boxCheck1.txtLabel.text = "随机打乱";
			uiRes.boxCheck2.txtLabel.text = "数字→代码";
			uiRes.mcDesc1.txtDesc.text = "";
			uiRes.mcDesc2.txtDesc.text = "";
			uiRes.mcHelp.visible = true;
			isStarting = false;
			isRandom = false;
			isTrainningNumber = true;
			uiRes.addEventListener( MouseEvent.CLICK, uiSettingClickHandler );
			
			index = 0;
			trainningTime = 100;
		}
		
		private function setTextTimeString():void
		{
			_trainningTime = Math.max( 24, _trainningTime );
			_trainningTime = Math.min( 999, _trainningTime );
			uiRes.mcNum.txtNum.text = _trainningTime + "";
		}
		
		protected function uiSettingClickHandler(event:MouseEvent):void
		{
			var target:InteractiveObject = event.target as InteractiveObject;
			if ( target == uiRes.btnTrainning )
			{
				isTrainningNumber = isTrainningNumber;
				uiRes.mcHelp.visible = false;
				isStarting = true;
				gapTime = trainningTime * 0.01;
				startCd();
			}
			else if ( target == uiRes.btnStop )
			{
				isStarting = false;
				TweenLite.killDelayedCallsTo( startCd );
				uiRes.mcDesc1.txtDesc.text = "已停止";
				uiRes.mcDesc1.visible = true;
				uiRes.mcDesc2.visible = false;
			}
			else if ( target == uiRes.btnBack )
			{
				Main.openScene();
			}
			else if ( target == uiRes.btnShowCode )
			{
				if ( codePanel == null )
				{
					codePanel = new MemoryTrainningPanel();
				}
				codePanel.show();
			}
			else if ( target == uiRes.boxCheck1 && isStarting == false )
			{
				isRandom = !isRandom;
			}
			else if ( target == uiRes.boxCheck2 && isStarting == false )
			{
				isTrainningNumber = !isTrainningNumber;
			}
			else if ( target == uiRes.btnPrev && isStarting == false )
			{
				trainningTime--;
			}
			else if ( target == uiRes.btnNext && isStarting == false )
			{
				trainningTime++;
			}
		}
		
		private function startCd():void
		{
			if ( ( index >= CODE.length && !isRandom ) || ( index >= CODE.length * 3 && isRandom ) )
			{
				isStarting = false;
				uiRes.mcDesc1.txtDesc.text = "已结束";
				uiRes.mcDesc1.visible = true;
				uiRes.mcDesc2.visible = false;
				return ;
			}
			var curNum:int = index % CODE.length;
			if ( isRandom )
			{
				curNum = Math.random() * CODE.length;
			}
			uiRes.mcDesc1.txtDesc.text = CODE[ curNum ]
			uiRes.mcDesc2.txtDesc.text = curNum.toString();
			
			TweenLite.delayedCall( gapTime, startCd );
			
			index++;
		}

		public function get trainningTime():int
		{
			return _trainningTime;
		}

		public function set trainningTime(value:int):void
		{
			_trainningTime = value;
			setTextTimeString();
		}

		public function get isRandom():Boolean
		{
			return _isRandom;
		}

		public function set isRandom(value:Boolean):void
		{
			_isRandom = value;
			uiRes.boxCheck1.gotoAndStop( value ? 2 : 1 );
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}

		public function get isTrainningNumber():Boolean
		{
			return _isTrainningNumber;
		}

		public function set isTrainningNumber(value:Boolean):void
		{
			_isTrainningNumber = value;
			uiRes.boxCheck2.gotoAndStop( value ? 2 : 1 );
			if ( isStarting == false )
			{
				uiRes.mcDesc1.visible = !value;
				uiRes.mcDesc2.visible = value;
			}
		}

		public function get isStarting():Boolean
		{
			return _isStarting;
		}

		public function set isStarting(value:Boolean):void
		{
			_isStarting = value;
			uiRes.btnTrainning.visible = !value;
			uiRes.btnStop.visible = value;
		}
		
		
	}
}