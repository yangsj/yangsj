package app.module.panel.rank
{
	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;

	import framework.BasePanel;

	import app.AppStage;
	import app.utils.DisplayUtil;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-1
	 */
	public class RankView extends BasePanel
	{
		private var listContainer:Sprite;

		public function RankView()
		{
			super();
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, AppStage.stageWidth, AppStage.stageHeight );
			this.graphics.endFill();

			listContainer = new Sprite();
			listContainer.y = 180;
			listContainer.x = 26;
			addChild( listContainer );

			var txtTitle:TextField = DisplayUtil.getTextFiled( 35, 0xffffff );
			txtTitle.appendText( "排 行 榜" );
			txtTitle.width = txtTitle.textWidth + 10;
			txtTitle.height = txtTitle.textHeight + 5;
			txtTitle.x = ( width - txtTitle.textWidth ) >> 1;
			txtTitle.y = ( 180 - txtTitle.textHeight ) >> 1;
			addChild( txtTitle );

			var txtTips:TextField = DisplayUtil.getTextFiled( 26, 0xffffff );
			txtTips.appendText( "点击屏幕退出" );
			txtTips.width = txtTips.textWidth + 5;
			txtTips.height = txtTips.textHeight + 2;
			txtTips.x = ( width - txtTips.textWidth ) >> 1;
			txtTips.y = height - txtTips.textHeight - 5;
			addChild( txtTips );
			
			trace("*****************************************************************************************");
		}

		override public function show():void
		{
			super.show();

			addDisplay();
		}

		private function addDisplay():void
		{
			addEventListener( MouseEvent.CLICK, clickHandler );

			addList();

			this.y = AppStage.stageHeight;
			TweenMax.to( this, 0.5, { y: 0 });
		}

		protected function clickHandler( event:MouseEvent ):void
		{
			removeEventListener( MouseEvent.CLICK, clickHandler );
			TweenMax.killTweensOf( this );
			TweenMax.to( this, 0.5, { y: -AppStage.stageHeight, onComplete: hide });
		}

		private function addList():void
		{
			var ary:Array = [[ 1000000, new Date().time ], [ 1000009, new Date().time - 1000000 ], [ 1000008, new Date().time - 2000000 ], [ 1000007, new Date().time - 3000000 ], [ 1000006, new Date().time - 4000000 ], [ 1000005, new Date().time - 5000000 ], [ 1000004, new Date().time - 6000000 ], [ 1000003, new Date().time - 7000000 ], [ 1000002, new Date().time - 8000000 ], [ 1000001, new Date().time - 9000000 ]];
			var txt1:TextField;
			var txt2:TextField;
			var txt3:TextField;
			var length:uint = ary.length;
			var tdata:Array;
			DisplayUtil.removedAll( listContainer );
			for ( var i:uint = 0; i < length; i++ )
			{
				tdata = ary[ i ];
				txt1 = DisplayUtil.getTextFiled( 28, 0xffffff, TextFormatAlign.CENTER );
				txt2 = DisplayUtil.getTextFiled( 28, 0xffffff, TextFormatAlign.CENTER );
				txt3 = DisplayUtil.getTextFiled( 24, 0xffffff, TextFormatAlign.CENTER );
				txt1.width = 48;
				txt1.height = 41;
				txt2.width = 195;
				txt2.height = 41;
				txt3.width = 315;
				txt3.height = 34;

				txt1.text = ( i + 1 ) + "";
				txt1.y = 63 * i;
				txt2.text = tdata[ 0 ] + "";
				txt2.x = 62;
				txt2.y = 63 * i;
				txt3.text = getString( tdata[ 1 ]);
				txt3.x = 271;
				txt3.y = 4 + 63 * i;

				listContainer.addChild( txt1 );
				listContainer.addChild( txt2 );
				listContainer.addChild( txt3 );
			}
		}

		private function getString( time:Number ):String
		{
			var date:Date = new Date();
			date.setTime( time );
			return date.fullYear + "-" + ( date.month + 1 ) + "-" + date.date + " " + ( date.toTimeString().substr( 0, 8 ));
		}

	}
}
