package victor.framework
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.apps;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public class Entry extends Sprite
	{
		
		public function Entry()
		{
			this.addEventListener( Event.ADDED_TO_STAGE, addedToStage );
		}
		
		private function addedToStage( event:Event ):void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE, addedToStage );
			
			// 设置全局stage
			apps = stage;
			apps.frameRate = 60;
			apps.color = 0;
			
			// 创建并初始化显示层管理器
			ViewStruct.initialize( this );
			
			initialized();
		}
		
		protected function initialized():void
		{
			
		}
		
	}
}