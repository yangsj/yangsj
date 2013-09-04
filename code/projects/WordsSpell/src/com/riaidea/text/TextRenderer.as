/**
 * RichTextField
 * @author Alex.li - www.riaidea.com
 * @homepage http://code.google.com/p/richtextfield/
 */

package com.riaidea.text
{
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * @private
	 */
	internal class TextRenderer extends TextField
	{
		private var _length:int = 0;
		private var _oldLength:int = 0;
		private var _scrollHeight:Number = 0;
		private var _defaultTextFormat:TextFormat;
		
		public function TextRenderer()
		{
			super();			
			var format:TextFormat = new TextFormat("Arial", 12, 0x000000, false, false, false);
			format.letterSpacing = 0;
			this.defaultTextFormat = format;
			this.multiline = true;
			this.wordWrap = true;
			this.type = TextFieldType.DYNAMIC;
		}
		
		override public function set text(value:String):void 
		{
			super.text = value;
			_length = this.length;
		}
		
		override public function set htmlText(value:String):void 
		{
			super.htmlText = value;
			_length = this.length;
		}
		
		override public function replaceText(beginIndex:int, endIndex:int, newText:String):void 
		{
			super.replaceText(beginIndex, endIndex, newText);
			_length = this.length;
		}
		
		override public function get defaultTextFormat():TextFormat 
		{ 
			return _defaultTextFormat;
		}
		
		override public function set defaultTextFormat(value:TextFormat):void 
		{
			if (value.letterSpacing == null) value.letterSpacing = 0;
			_defaultTextFormat = value;
			super.defaultTextFormat = value;
		}
		
		override public function set type(value:String):void 
		{
			super.type = value;
			this.addEventListener(Event.SCROLL, onScroll);
			if (type == TextFieldType.INPUT)
			{
				this.addEventListener(Event.CHANGE, onTextChange);
				this.addEventListener(TextEvent.TEXT_INPUT, onTextInput);				
			}
		}
		
		private function onScroll(e:Event):void 
		{
			//update _scrollHeight when scrolling
			calcScrollHeight();
		}
		
		private function onTextChange(e:Event):void 
		{
			//record old length before text has been changed
			_oldLength = _length;
			_length = this.length;
		}
		
		private function onTextInput(e:TextEvent):void 
		{
			recoverDefaultFormat();
		}
		
		private function calcScrollHeight():void
		{			
			//avoid the error #2006 when clear text
			if (this.length == 0) 
			{
				_scrollHeight = 0;
				return;
			}
			
			var height:Number = 0;
			for (var i:int = 0; i < this.scrollV - 1; i++)
			{
				height += getLineMetrics(i).height;
			}
			_scrollHeight = height;
		}
		
		internal function recoverDefaultFormat():void
		{
			//force to recover default textFormat
			this.defaultTextFormat = defaultTextFormat;
		}
		
		internal function get scrollHeight():Number 
		{ 
			return _scrollHeight;
		}
		
		/**
		 * 此属性用来获取事件Event.CHANGE发生前的文本字段的长度。
		 * 因此在Event.CHANGE事件处理器中获取它才正确且有意义。
		 * @private
		 */
		public function get oldLength():int 
		{ 
			return _oldLength;
		}
		
		internal function clear():void
		{
			this.text = "";
			_oldLength = 0;
			_scrollHeight = 0;
		}
	}
}