package victor.framework.core
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.geom.Rectangle;
	
	import victor.framework.utils.DisplayUtil;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BasePanel extends ViewSprite
	{
		public function BasePanel()
		{
		}

		override public function show():void
		{
			ViewStruct.addPanel( this );

			this.scaleX = 0.1;
			this.scaleY = 0.1;
			
			changePos();

			TweenMax.to( this, 0.5, { scaleX: 1, scaleY: 1, alpha: 1, onUpdate: changePos, ease: Back.easeOut });
		}

		override public function hide():void
		{
			TweenMax.killTweensOf( this );
			TweenMax.to( this, 0.5, { scaleX: 0.1, scaleY: 0.1, alpha: 0, onUpdate: changePos, onComplete: DisplayUtil.removedFromParent, onCompleteParams: [ this ]});
		}

		private function changePos():void
		{
			var rect:Rectangle = this.getBounds( this );
			x = (( appStage.stageWidth - rect.width * scaleX ) >> 1 ) - rect.x * scaleX;
			y = (( appStage.stageHeight - rect.height * scaleY ) >> 1 ) - rect.y * scaleY;
		}

	}
}
