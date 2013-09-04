package app.modules
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import app.utils.appStage;
	
	import victor.framework.core.ViewStruct;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-4
	 */
	public class LoadingEffect extends Sprite
	{
		private static var _instance:LoadingEffect;
		
		private var skin:MovieClip;
		
		public function LoadingEffect()
		{
			super();
			this.graphics.beginFill(0,0);
			this.graphics.drawRect( 0, 0, appStage.stageWidth, appStage.stageHeight );
			this.graphics.endFill();
			
			skin = new UISkingRequestLoading();
			skin.x = width >> 1;
			skin.y = height >> 1;
			addChild( skin );
			
			if ( _instance )
				throw new Error("LoadingEffect 是单例类，不能重复创建！");
			_instance = this;
		}
		
		public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.LOADING );
			
			skin.gotoAndPlay( 1 );
		}
		
		public function hide():void
		{
			ViewStruct.removeChild( this );
			
			skin.gotoAndStop( 1 );
		}
		
		public static function show():void
		{
			instance.show();
		}
		
		public static function hide():void
		{
			instance.hide();
		}

		public static function get instance():LoadingEffect
		{
			if ( _instance == null )
				new LoadingEffect();
			return _instance;
		}

	}
}