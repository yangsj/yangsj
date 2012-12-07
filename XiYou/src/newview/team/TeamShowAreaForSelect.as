package newview.team
{

	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;

	import global.Global;

	import utils.BitmapUtils;


	/**
	 * 说明：TeamShowAreaForSelect
	 * @author Victor
	 * 2012-11-14
	 */

	public class TeamShowAreaForSelect extends Sprite
	{
		private const RES_LINKAGE_PREFIX : String = "ui.role.ResourceRoleWholeBodyImage_";

		private var target1 : Sprite;
		private var target2 : Sprite;

		public function TeamShowAreaForSelect()
		{
			super();
		}

		public function show( item : TeamItemBase ) : void
		{
			if ( target1 )
				TweenMax.killTweensOf( target1 );
			if ( target2 )
				killTargetTweenMax();

			target2 = target1;
			target1 = getRoleRes( item.getId );
			BitmapUtils.cacheAsBitmap( target1 );
			target1.y = -Global.stageHeight;
			addChild( target1 );

			if ( target1 )
				TweenMax.to( target1, 0.8, { x: 0, y: 0, onComplete: function() : void
				{
					TweenMax.killTweensOf( target1 );
				}});

			if ( target2 )
				TweenMax.to( target2, 0.8, { x: 0, y: Global.stageHeight, onComplete: killTargetTweenMax });
		}

		public function clear() : void
		{
			target2 = target1;
			if ( target2 )
				TweenMax.to( target2, 0.8, { x: 0, y: Global.stageHeight, onComplete: killTargetTweenMax });
		}

		private function killTargetTweenMax() : void
		{
			target2.visible = false;
			TweenMax.killTweensOf( target2 );
			if ( target2.parent )
				target2.parent.removeChild( target2 );
			target2 = null;
		}

		private function getRoleRes( id : int ) : Sprite
		{
			var cls : Class = getDefinitionByName( RES_LINKAGE_PREFIX + id ) as Class;
			var sprite : Sprite = new cls();
			return sprite;
		}


	}

}
