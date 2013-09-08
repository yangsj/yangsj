package app.modules.chat.view
{
	import victor.framework.core.ViewSprite;
	import victor.framework.core.ViewStruct;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class ChatView extends ViewSprite
	{
		public function ChatView()
		{
			super();
		}
		
		override public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.CHAT );
		}
		
	}
}