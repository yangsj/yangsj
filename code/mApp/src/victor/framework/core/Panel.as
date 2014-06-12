package victor.framework.core
{
	import flash.display.Sprite;
	
	import victor.framework.interfaces.IPanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public class Panel extends Sprite implements IPanel
	{

		public function Panel()
		{
			super();
		}
		
		protected function showBefore():void { }
		
		protected function showAfter():void { }
		
		protected function clear():void { }
		
		final public function show():void
		{
			showBefore();
			ViewStruct.addPanel( this, true );
			showAfter();
		}
		
		final public function hide():void
		{
			ViewStruct.removePanel( this );
			clear();
		}
		
		public function dispose():void
		{
			hide();
		}
		
	}
}