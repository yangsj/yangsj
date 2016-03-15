package com.newbye.framework.interfaces
{
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.IMediator;
	
	public interface IViewMediator extends IMediator
	{
		function get viewers():Vector.<DisplayObject>;
	}
}