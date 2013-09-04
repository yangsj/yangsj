/**
 * RichTextField
 * @author Alex.li - www.riaidea.com
 * @homepage http://code.google.com/p/richtextfield/
 */

package com.riaidea.text.plugins
{
	import com.riaidea.text.RichTextField;
	import flash.events.Event;
	
	/**
	 * 显示元素快捷符号输入插件，方便显示元素的快速输入。一般适用于input类型的RichTextField。
	 * 
	 * @example 下面的例子演示了基本使用方法：
	 * <listing>
	   var input:RichTextField = new RichTextField();
	   input.type = RichTextField.INPUT;
	
	   var plugin:ShortcutPlugin = new ShortcutPlugin();			
	   var shortcuts:Array = [ 
	     { shortcut:"/a", src:SpriteClassA },
	     { shortcut:"/b", src:SpriteClassB },
	     { shortcut:"/c", src:SpriteClassC }];
	   plugin.addShortcut(shortcuts);
	   input.addPlugin(plugin);</listing>
	 *	 
	 */
	public class ShortcutPlugin implements IRTFPlugin
	{		
		private var _target:RichTextField;
		private var _shortcuts:Array;
		private var _enabled:Boolean;
		
		/**
		 * 构造函数。
		 */
		public function ShortcutPlugin()
		{
			_shortcuts = [];
			_enabled = false;
		}
		
		/**
		 * @private
		 */
		public function setup(target:RichTextField):void
		{
			_target = target;
			this.enabled = true;
		}
		
		/**
		 * 增加快捷项shortcut。
		 * @param	shortcuts 快捷项shortcut数组，每个元素必须包含src和shortcut两个属性，如：{src:smileClass, shortcut:":)"}。
		 */
		public function addShortcut(shortcuts:Array):void
		{
			_shortcuts = _shortcuts.concat(shortcuts);
		}
		
		private function onTextChange(e:Event):void 
		{
			if (_target.caretIndex > 0)
			{
				convertShortcut();
			}
		}
		
		private function convertShortcut():void
		{			
			var offset:int = _target.contentLength - _target.textfield["oldLength"];
			//删除文本内容无需处理
			if (offset < 0) return;
			
			var caret:int = _target.caretIndex;
			for (var i:int = 0; i < _shortcuts.length; i++)
			{
				var item:Object = _shortcuts[i];
				var len:int = item.shortcut.length;
				var index:int = _target.content.lastIndexOf(item.shortcut, caret);
				if (index > -1)
				{
					_target.replace(index, index + len, "", [ { src:item.src } ]);
					caret--;
					//当改变的文本长度为1时，只需匹配一次即可
					if (offset == 1) break;
				}
			}
			_target.caretIndex = caret;
		}
		
		/**
		 * 一个布尔值，指示插件是否启用。
		 */
		public function get enabled():Boolean
		{ 
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
			if (_target != null)
			{
				if (_enabled) _target.addEventListener(Event.CHANGE, onTextChange, false, 0, true);
				else _target.removeEventListener(Event.CHANGE, onTextChange);
			}
		}
	}	
}