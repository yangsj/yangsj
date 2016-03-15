package net.victor.code.app.managers.interfaces
{
	import net.victor.code.managers.interfaces.IManagerCernterable;
	
	public interface IEffectsManager extends IManagerCernterable
	{
		function showEffect(effectItem:IEffectItem):void;
		
		function removeEffect(effectItem:IEffectItem):void;
		/**
		 *  
		 * @param effectType
		 * @see com.jt.ep.models.effects.EffectsTypeConst
		 * 
		 */		
		function removeAllEffect(effectType:String):void;
		
		/**
		 *  显示特效
		 * @param meidatorName
		 * 
		 */		
		function showEffectByName(meidatorName:String):void;
		/**
		 * 从显示列表中移特效
		 * @param meidatorName
		 * 
		 */		
		function hideEffectByName(meidatorName:String):void;
		/**
		 * 从内存中清除 
		 * @param meidatorName
		 * 
		 */		
		function destroyEffectByName(meidatorName:String):void;
	}
}