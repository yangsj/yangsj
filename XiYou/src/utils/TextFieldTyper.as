package utils
{
	import com.greensock.TweenMax;
	
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 * 说明：NewbieDynamicWriteText 该类的主要功能是：模拟打字机的方式将文字呈现出来
	 * @author Victor
	 * acsh_ysj[at]163.com
	 * 2012-9-7
	 */

	public class TextFieldTyper
	{
		private var _textField:TextField;
		private var _text:String;
		private var _isRestart:Boolean;
		private var _isOver:Boolean = false;
		private var _isNull:Boolean = false;
		private var _delay:Number = 100;

		/** 记录想文本框写入文字的次数 */
		private var time:int;
		/** 将要呈现的文字长度 */
		private var wordsLength:int;
		/** 一个TweenMax类的实例 */
		private var tween:TweenMax;
		private var timer:Timer;

		/**
		 * 模拟打字机的方式将文字呈现出来
		 * @param textField 指定一个目标文本框
		 * @param text 指定将要显示的文字内容
		 *
		 */
		public function TextFieldTyper(textField:TextField=null, text:String=null)
		{
			this.textField = textField;
			this.text = text;
			_isNull = false;
		}

		///////////// static public //////////////////
		/**
		 * 创建一个NewbieDynamicWriteText类实例
		 * @param textField 指定一个目标文本框
		 * @param text 指定将要显示的文字内容
		 * @return NewbieDynamicWriteText类的实例
		 */
		public static function create(textField:TextField=null, text:String=null):TextFieldTyper
		{
			return new TextFieldTyper(textField, text);
		}

		/////////////  public functions ////////////////////

		/**
		 * 开始向文本中逐字写入内容
		 */
		public function startWrite():void
		{
			if (_textField && _text)
			{
				isNull = false;
//				tween = TweenMax.delayedCall(_delay * 0.001, writeManager);
				startTimer();
			}
		}
		
		/**
		 * 重新开始新的一次写入
		 */
		public function restartWrite():void
		{
			isOver = false;
			time = 0;
			clearTimer();
			startWrite();
		}
		
		/**
		 * 继续未写完的
		 */
		public function resumeWrite():void
		{
			if (tween)
			{
				isOver = false;
				tween.resume();
			}
			if (timer)
			{
				timer.start();
			}
		}

		/**
		 * 将指定文字内容全写入到指定文本框内，且清除引用
		 */
		public function stopWriteAndClear():void
		{
			clearTimer();
			if (_textField && _text)
			{
				_textField.htmlText=_text;
			}
			if (tween)
			{
				tween.kill();
				tween=null;
			}
			isOver = true;
		}

		/**
		 * 暂停向文本框内写入内容
		 */
		public function pauseWrite():void
		{
			if (timer)
			{
				tween.pause();
			}
			if (timer)
			{
				timer.reset();
			}
		}
		
		public function dispose():void
		{
			stopWriteAndClear();
			_textField=null;
			_text=null;
			tween=null;
			isOver = true;
			_isNull = true;
		}

		///////////////// private functions //////////////

		private function writeManager():void
		{
			if (_textField && _text)
			{
				_isNull = false;
				setTextContent();
				if (time < wordsLength)
				{
					startWrite();
				}
				else
				{
					stopWriteAndClear();
				}
				
			}
		}
		
		private function setTextContent():void
		{
			time++;
			
			if (_text && _textField)
			{
				// 过滤  html 文本格式
				var cutString:String = _text.substr(time, 5);
				if (cutString == "<font")
				{
					var temp:String = _text.substr(time);
					time += temp.indexOf(">") + 1;
				}
				else if (cutString == "</fon")
				{
					time += 7;
				}
				// 过滤  html 文本格式
				
				var tempWord:String = _text.substr(0, time);
				_textField.htmlText = tempWord;	
			}
		}
		
		private function startTimer():void
		{
			if (_textField && _text)
			{
				if (timer == null)
				{
					timer = new Timer(_delay);
					timer.addEventListener(TimerEvent.TIMER, timerHandler);
				}
				timer = new Timer(_delay);
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
				timer.start();
			}
			else
			{
				throw new Error("cannot find _textField and _text");
			}
		}
		
		private function clearTimer():void
		{
			if (timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				timer = null;
			}
			if (tween)
			{
				tween.kill();
				tween=null;
			}
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			setTextContent();
			if (time > wordsLength)
			{
				stopWriteAndClear();
			}
		}

		////////////// getter/setter ////////////////////
		
		/** 是否结束 */
		public function get isOver():Boolean { return _isOver; }
		
		/**
		 * @private
		 */
		public function set isOver(value:Boolean):void
		{
			_isOver = value;
		}

		/** 需要写入文字内容的目标文本框对象 */
		public function get textField():TextField
		{
			return _textField;
		}

		/**
		 * @private
		 */
		public function set textField(value:TextField):void
		{
			_textField=value;
		}

		/** 需要写入文字内容 */
		public function get text():String
		{
			return _text;
		}

		/**
		 * @private
		 */
		public function set text(value:String):void
		{
			_text=value;
			if (_text)
			{
				wordsLength = _text.length;
			}

		}

		/** 是否设置为重新开始 */
		public function get isRestart():Boolean
		{
			return _isRestart;
		}

		/**
		 * @private
		 */
		public function set isRestart(value:Boolean):void
		{
			_isRestart = value;
		}

		/** 是否已经执行dispose方法 */
		public function get isNull():Boolean { return _isNull; }

		/**
		 * @private
		 */
		public function set isNull(value:Boolean):void
		{
			_isNull = value;
		}

		/**
		 * 两个字之间的间隔时间
		 */
		public function get delay():Number
		{
			return _delay;
		}

		/**
		 * @private
		 */
		public function set delay(value:Number):void
		{
			_delay = value;
		}


	}

}
