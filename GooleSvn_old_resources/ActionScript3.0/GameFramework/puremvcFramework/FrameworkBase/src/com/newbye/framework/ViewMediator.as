package com.newbye.framework
{
	import com.newbye.framework.interfaces.IViewMediator;
	
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ViewMediator extends Mediator implements IViewMediator
	{
		private var _viewers:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		public function ViewMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		public function get viewers():Vector.<DisplayObject>
		{
			return _viewers;
		}
	}
}