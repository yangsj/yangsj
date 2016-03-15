package net.victor.code.managers.interfaces
{
	import flash.display.Stage;
	
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.patterns.observer.Notification;
	
	public interface IKeyboardManager extends IManagerCernterable, INotifier
	{
		/**
		 * 初始化 
		 * @param stage
		 * @param keydownDelay 设置键盘响应延迟
		 * @return 
		 * 
		 */		
		function init(stage:Stage, keydownDelay:Number=1000):void;
		
		/**
		 * 添加键盘事件回调 
		 * @param callBack
		 * @param ctrl Ctrl键是否处于按下状态
		 * @param shift 键是否处于按下状态
		 * @param alt 键是否处于按下状态
		 * @param firstKeyCode 第一个组合键
		 * @param args 其它需要组合的键
		 * 
		 */		
		function addShortcutCallBack(callBack:Function, ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):void;
		/**
		 * 
		 * @param notification
		 * @param ctrl Ctrl键是否处于按下状态
		 * @param shift 键是否处于按下状态
		 * @param alt 键是否处于按下状态
		 * @param firstKeyCode 第一个组合键
		 * @param args 其它需要组合的键
		 * 
		 */		
		function addShortcutNotification(notification:Notification, ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):void;
		/**
		 *  
		 * @param commandName
		 * @param ctrl Ctrl键是否处于按下状态
		 * @param shift 键是否处于按下状态
		 * @param alt 键是否处于按下状态
		 * @param firstKeyCode 第一个组合键
		 * @param args 其它需要组合的键
		 * 
		 */		
		function addShortcutCommand(commandName:String, ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):void;
		
		/**
		 *  
		 * @param ctrl Ctrl键是否处于按下状态
		 * @param shift 键是否处于按下状态
		 * @param alt 键是否处于按下状态
		 * @param firstKeyCode 第一个组合键
		 * @param args 其它需要组合的键
		 * 
		 */		
		function hasShortcut(ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):Boolean;
		/**
		 * 移除快捷键
		 * @param ctrl Ctrl键是否处于按下状态
		 * @param shift 键是否处于按下状态
		 * @param alt 键是否处于按下状态
		 * @param firstKeyCode 第一个组合键
		 * @param args 其它需要组合的键
		 * 
		 */		
		function removeShortcut(ctrl:Boolean, shift:Boolean, alt:Boolean, firstKeyCode:uint, ...args):void
	}
}