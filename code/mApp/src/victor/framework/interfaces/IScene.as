package victor.framework.interfaces
{
	import victor.framework.constant.TransitionType;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public interface IScene extends IDisposable
	{
		function transitionIn( transitionType:int = TransitionType.DEFUALT ):void;
		
		function transitionOut( transitionType:int = TransitionType.DEFUALT ):void;
		
		/**
		 * 是否需要过度特效
		 */
		function get isTransition():Boolean;
		
		function set isTransition( value:Boolean ):void;
	}
}