package app.module.panel.help
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import framework.BasePanel;
	
	import app.AppStage;
	import app.utils.DisplayUtil;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-1
	 */
	public class HelpView extends BasePanel
	{
		public function HelpView()
		{
			super();
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, AppStage.stageWidth, AppStage.stageHeight );
			this.graphics.endFill();
			/*
			游戏规则：
			(1) 概要：玩家可以将2个相同图案连接起来，连接线不多于3根直线，就可以成功将两个图案消除：

			(2) 操作：点击游戏界面中的图案，该图案此时为'被选中'；再次点击其他图案，若该图案与被选中的图案相同，且把第一个图案第二个图案连起来，中间的直线不超过三根，则消掉这一对图案，否则第一个图案恢复成未被选中状态。

			(3) 成功连接一次加10分，失败不扣分，提示和刷新时间每局有各有3次机会。

			(4) 胜利条件：将游戏界面上的图案全部消除。

			(5) 失败条件：到规定时间，界面上的图案仍未全部消除
			*/

			var txtField:TextField = DisplayUtil.getTextFiled( 26, 0xffffff, null, true );
			txtField.width = 490;
			txtField.appendText( "游戏规则：\n" );
			txtField.appendText( "(1) 概要：玩家可以将2个相同图案连接起来，连接线不多于3根直线，就可以成功将两个图案消除。\n" );
			txtField.appendText( "(2) 操作：点击游戏界面中的图案，该图案此时为'被选中'；再次点击其他图案，若该图案与被选中的图案相同，且把第一个图案第二个图案连起来，中间的直线不超过三根，则消掉这一对图案，否则第一个图案恢复成未被选中状态。\n" );
			txtField.appendText( "(3) 成功连接一次获得加分，失败不扣分，每连击一次会在当前单次基分累加5分额外奖励。连接一次奖励时间1秒。\n" );
			txtField.appendText( "(4) 胜利条件：在规定时间内将游戏界面上的图案全部消除。\n" );
			txtField.appendText( "(5) 失败条件：到规定时间，界面上的图案仍未全部消除。\n" );
			txtField.height = txtField.textHeight + 15;
			txtField.x = ( width - txtField.width ) >> 1;
			txtField.y = ( height - txtField.height ) >> 1;
			addChild( txtField );

			var txtTips:TextField = DisplayUtil.getTextFiled( 26, 0xffffff );
			txtTips.appendText( "点击屏幕退出" );
			txtTips.width = txtTips.textWidth + 5;
			txtTips.height = txtTips.textHeight + 2;
			txtTips.x = ( width - txtTips.textWidth ) >> 1;
			txtTips.y = height - txtTips.textHeight - 5;
			addChild( txtTips );
		}
		
		override public function show():void
		{
			super.show();
			
			addEventListener( MouseEvent.CLICK, clickHandler );
			
			this.y = AppStage.stageHeight;
			TweenMax.to( this, 0.5, { y: 0 });
		}
		
		protected function clickHandler( event:MouseEvent ):void
		{
			removeEventListener( MouseEvent.CLICK, clickHandler );
			TweenMax.killTweensOf( this );
			TweenMax.to( this, 0.5, { y: -AppStage.stageHeight, onComplete: hide});
		}

	}
}
