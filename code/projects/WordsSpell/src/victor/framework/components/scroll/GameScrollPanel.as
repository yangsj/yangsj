package victor.framework.components.scroll
{

	import flash.display.Sprite;
	
	import app.managers.LoaderManager;

	/**
	 * @author fireyang
	 */
	public class GameScrollPanel extends BaseScrollPanel
	{
		public function set speed( value:int ):void
		{
			_bar.setSpeed( value );
		}

		public function GameScrollPanel( skinName:String = null )
		{
			if ( skinName == null )
			{
				skinName = "ui_scrollBar5";
			}
			var skin:Sprite = LoaderManager.instance.getObj( skinName ) as Sprite;
			super( skin );
		}

		public function get bar():ScrollBar
		{
			return _bar;
		}

		public function setTargetShow( target:Sprite, x:int, y:int, w:int, h:int ):void
		{
			setTarget( target );
			setContent( x, y, w, h );
		}

		public function setTargetAndHeight( target:Sprite, showHeight:int, showWidth:int = 0 ):void
		{
			setTarget( target );
			if ( showWidth == 0 )
			{
				showWidth = target.width;
			}
			setContent( 0, 0, showWidth, showHeight );
		}

		public function changeShowRect( x:int, y:int, w:int, h:int ):void
		{
			if ( _contentRect == null )
			{
				return;
			}
			_bar.goFirst();
			setContent( x, y, w, h );
		}

		public function setBarWidth( w:int ):void
		{
			_bar.width = w;
			_bar.x = _maskSp.x + _maskSp.width - _bar.width;
		}

		public function setBarPos( x:int, y:int, height:int ):void
		{
			_bar.x = x;
			_bar.y = y;
			_bar.setBarHeight( height );
		}

		public function setSpeed( i:int ):void
		{
			_bar.setSpeed( i );
		}

		public function reset():void
		{
			_bar.goFirst();
		}

		/**
		 * 当前位置
		 */
		public function get curPos():Number
		{
			return _bar.curPos;
		}

		public function setPos( value:Number ):void
		{
			_bar.pos = value;
		}

		public function clear():void
		{
			updateMainHeight( 0 );
		}
	}
}
