package newview.ui
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import utils.BitmapUtils;
	import utils.Numeric;


	/**
	 * 说明：HeadPhotoBase
	 * @author Victor
	 * 2012-11-19
	 */

	public class HeadPhotoBase extends Sprite
	{
		private const PREFIX_FRAME : String = "lab_";

		protected var headPhoto : MovieClip;
		protected var selectedStatusMc : Sprite;

		private var levelMc : Sprite;

		public function HeadPhotoBase()
		{
			super();
			createResource();
			selectedEffectNo();
		}

		protected function createResource() : void
		{
		}

		/**
		 * 人物id编号
		 * @param id
		 *
		 */
		public function setId( id : int ) : void
		{
			if ( headPhoto )
				headPhoto.gotoAndStop( PREFIX_FRAME + id );
			BitmapUtils.cacheAsBitmap( headPhoto );
		}

		/**
		 * 人物等级值
		 * @param level
		 *
		 */
		public function setLevel( level : int ) : void
		{
			if ( levelMc && levelMc.parent )
				levelMc.parent.removeChild( levelMc );

			levelMc = Numeric.getNumeric( "L" + level, Numeric.NUM_LEVEL_BLACK );
			levelMc.scaleX = levelMc.scaleY = 0.8;
			levelMc.y = ( headPhoto.height - levelMc.height - 5 );
			levelMc.x = ( headPhoto.width - levelMc.width ) * 0.5;
			addChild( levelMc );
			BitmapUtils.cacheAsBitmap( levelMc );
		}

		/**
		 * 选中效果状态
		 */
		public function selectedEffectYes() : void
		{
			if ( selectedStatusMc )
				selectedStatusMc.visible = true;
		}

		/**
		 * 未选中效果状态
		 */
		public function selectedEffectNo() : void
		{
			if ( selectedStatusMc )
				selectedStatusMc.visible = false;
		}



	}

}
