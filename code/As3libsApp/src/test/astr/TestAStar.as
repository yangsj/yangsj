package test.astr
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import components.Button;
	
	import victor.astar.AStar;
	import victor.astar.AStarPoint;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-20
	 */
	public class TestAStar extends Sprite
	{
		private var itemwh:Number = 20;
		private var startx:Number = itemwh * 0.5;
		private var starty:Number = itemwh * 0.5;

		private var container:Sprite;
		private var itemCon:Sprite;
		private var line:Shape;

		private var startPos:AStarPoint;
		private var aStar:AStar;
		private var aStarAry:Array;
		private var aryLine:Vector.<AStarPoint>;
		private var aryPos:Array = [];

		public function TestAStar()
		{
			super();

			container = new Sprite();
			addChild( container );

			itemCon = new Sprite();
			container.addChild( itemCon );

			line = new Shape();
			line.x = startx;
			line.y = starty;
			container.addChild( line );

			aStar = new AStar();

			itemCon.addEventListener( MouseEvent.CLICK, itemClickHandler );

			container.y = 40;

			var btnClear:Button = new Button( "清  除", clearHandler );
			btnClear.x = 50;
			btnClear.y = 10;
			addChild( btnClear );

			var btnReset:Button = new Button( "重  置", resetHandler );
			btnReset.x = 150;
			btnReset.y = 10;
			addChild( btnReset );
			
			var btnChangeVar:Button = new Button("改变变量", changeVarHandler);
			btnChangeVar.x = 250;
			btnChangeVar.y = 10;
//			addChild( btnChangeVar );
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			initView();
		}
		
		private function changeVarHandler():void
		{
			aStar.isSort = !aStar.isSort;
		}
		
		private function resetHandler():void
		{
			line.graphics.clear();
			initView();
		}

		private function clearHandler():void
		{
			trace( "清除" );
			startPos = null;
			line.graphics.clear();
		}

		protected function itemClickHandler( event:MouseEvent ):void
		{
			var item:Sprite = event.target as Sprite;
			if ( item )
			{
				var itemx:Number = ( item.x - startx ) / itemwh;
				var itemy:Number = ( item.y - starty ) / itemwh;
				if ( startPos == null )
				{
					startPos = new AStarPoint();
					startPos.x = itemx;
					startPos.y = itemy;
				}
				else
				{
					var endPos:AStarPoint = new AStarPoint();
					endPos.x = itemx;
					endPos.y = itemy;

					aStar.initVars( aStarAry );

					trace( "[startPos]" + JSON.stringify( startPos ));
					trace( "[endPos]" + JSON.stringify( endPos ));

					var time:Number = getTimer();
					var aryL:Vector.<AStarPoint> = aStar.find( startPos, endPos );
					trace("查找耗时：" + (getTimer() - time));
					drawLine( aryL);
					startPos = endPos;

				}
			}
		}

		private function drawLine( array:Vector.<AStarPoint> ):void
		{
			trace( "[result]" + JSON.stringify( array ));
			if ( array.length > 0 )
			{
				var pos:AStarPoint = array.pop();
				var movex:Number = pos.x * itemwh;
				var movey:Number = pos.y * itemwh;
				aryPos = [ movex, movey ];
				aryLine = array;
				line.graphics.lineStyle( int( Math.random() * 4 + 3 ), Math.random() * 0xffffff );
				line.graphics.moveTo( movex, movey );
				tweenLineDraw();
			}
		}

		private function tweenLineDraw():void
		{
			if ( aryLine && aryLine.length > 0 )
			{
				var pos:AStarPoint = aryLine.pop();
				var arr:Array = [ pos.x * itemwh, pos.y * itemwh ];
				TweenMax.to( aryPos, 0.1, { endArray: arr, onUpdate: tweenUpdate, onComplete: tweenLineDraw });
			}
		}

		private function tweenUpdate():void
		{
			line.graphics.lineTo( aryPos[ 0 ], aryPos[ 1 ]);
		}

		private function initView():void
		{
			startPos = null;
			itemCon.removeChildren();
			aStarAry = [];
			var lengi:int = int((stage.stageHeight - 50) / itemwh);
			var lengj:int = int((stage.stageWidth - startx) / itemwh);
			for ( var i:int = 0; i < lengi; i++ )
			{
				var ary:Array = [];
				aStarAry.push( ary );
				for ( var j:int = 0; j < lengj; j++ )
				{
					var num:int = ( Math.random() * 3 ) > 1 ? 1 : 0;
					var item:Sprite = createItem( num == 0 );
					item.x = startx + itemwh * j;
					item.y = starty + itemwh * i;
					itemCon.addChild( item );
					ary.push( num );
				}
			}
		}


		private function createItem( isBlock:Boolean ):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle( 1 );
			sprite.graphics.beginFill( isBlock ? 0xff0000 : 0xffff00, 0.4 );
			sprite.graphics.drawRect( -startx, -starty, itemwh, itemwh );
			sprite.graphics.endFill();
			sprite.mouseChildren = false;

			if ( isBlock )
			{
				var txt:TextField = new TextField();
				txt.text = "阻";
				var bitdata:BitmapData = new BitmapData( txt.textWidth, txt.textHeight, true, 0 );
				bitdata.draw( txt );
				var bitmap:Bitmap = new Bitmap( bitdata, "auto", true );
				bitmap.x = -startx + ( sprite.width - bitmap.width ) * 0.5;
				bitmap.y = -starty + ( sprite.height - bitmap.height ) * 0.5;
				sprite.addChild( bitmap );
			}

			return sprite;
		}

	}
}
