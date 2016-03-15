package net.victor.app.managers
{
	import flash.display.DisplayObject;
	
	import net.victor.app.managers.model.EffectsTypeConst;
	import net.victor.code.app.AppMainMediator;
	import net.victor.code.app.managers.interfaces.IEffectItem;
	import net.victor.code.app.managers.interfaces.IEffectsManager;
	import net.victor.code.framework.AppFacade;
	import net.victor.code.framework.AppViewMediator;
	import net.victor.code.managers.ManagerCenterableBase;
	
	public class EffectsManager extends ManagerCenterableBase implements IEffectsManager
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		public function EffectsManager()
		{
			super();
		}
		
		public function showEffect(effectItem:IEffectItem):void
		{
			switch(effectItem.effectType)
			{
				case EffectsTypeConst.EFFECTS_TYPE_SMIPLE:
					mainMediator.addEffect(effectItem.displayObject);
					if(effectItem.point)
					{
						effectItem.displayObject.x = effectItem.point.x;
						effectItem.displayObject.y = effectItem.point.y;
					}
					effectItem.play();
					break;
			}
		}
		
		public function removeEffect(effectItem:IEffectItem):void
		{
			switch(effectItem.effectType)
			{
				case EffectsTypeConst.EFFECTS_TYPE_SMIPLE:
					mainMediator.removeEffect(effectItem.displayObject);
					effectItem.dispose();
					effectItem = null;
					break;
			}
		}
		
		public function removeAllEffect(effectType:String):void
		{
			
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		public function showEffectByName(meidatorName:String):void
		{
			
		}
	
		public function hideEffectByName(meidatorName:String):void
		{
			
		}

		public function destroyEffectByName(meidatorName:String):void
		{
			hideEffectByName(meidatorName);
			AppFacade.instance.removeMediator(meidatorName);
		}
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		protected function get mainMediator():AppMainMediator
		{
			return AppFacade.instance.retrieveMediator(AppMainMediator.AppMainMediatorName) as AppMainMediator;
		}
		
		protected function getMediator(meidatorName:String):AppViewMediator
		{
			return AppFacade.instance.retrieveMediator(meidatorName) as AppViewMediator;
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}