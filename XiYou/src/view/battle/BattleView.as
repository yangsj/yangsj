package view.battle
{
	import utils.MathUtils;

	import manager.ui.UIAlertManager;

	import com.greensock.TweenMax;

	import datas.EctypalData;
	import datas.TeamInfoData;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	import global.DeviceType;
	import global.Global;

	import manager.ui.UIMainManager;

	import newview.SpriteBase;
	import newview.navi.MainNaviView;

	import test.HexgonMapTest;
	import test.ScrollSceneBattleTest;

	import view.AlertPanel;
	import view.ArenaScene;
	import view.BattleScene;
	import view.DungeonScene;
	import view.ViewBase;

	/**
	 * 说明：BattleView
	 * @author Victor
	 * 2012-10-3
	 */
	public class BattleView extends SpriteBase
	{
		private const MAX_NUM : int = 4;
		private var myTeamData : Array = TeamInfoData.selected;
		private var opTeamData : Array = TeamInfoData.enemyerTeams;
		private var battleBackGround : Sprite;
		private var battleModule : BattleScene;
		private var arenaModule : ArenaScene;
		private var freeBattleScene : ScrollSceneBattleTest;
		private var roleStatusView : BattleRoleStatusView;
		private var loading : ui_loading_small;

		public function BattleView()
		{
			super();

			myTeamData = myTeamData.length <= MAX_NUM ? myTeamData : myTeamData.slice(0, MAX_NUM);
			opTeamData = opTeamData.length <= MAX_NUM ? opTeamData : opTeamData.slice(0, MAX_NUM);

			// 20121204 Chenzhe 修改 : 现在石普专门做了一个界面
			loading = new ui_loading_small();
			loading.charMC.gotoAndStop(int(Math.random() * 2) + 1);
			UIAlertManager.addChild(loading);
			// AlertPanel.instance.show( "正在加载并初始化资源中……", "初始化", true );
		}

		override protected function addedToStageHandler(event : Event) : void
		{
			freeBattleScene = new ScrollSceneBattleTest();
			this.addChild(freeBattleScene);
			freeBattleScene.addEventListener(Event.COMPLETE, battleCompleteHandler);
			var time : Number = getTimer();
			setTimeout(function() : void
			{
				freeBattleScene.start(myTeamData, opTeamData, battleBackGround, 220);
				UIAlertManager.removeChild(loading);
			}, 800);
			// TweenMax.delayedCall(1, AlertPanel.instance.removed);

			super.addedToStageHandler(event);
		}

		private function callBackFromItemClick(id : int) : void
		{
			if ( freeBattleScene )
			{
				// freeBattleScene.enrage(String(id));
			}
		}

		protected function battleCompleteHandler(event : Event) : void
		{
			event.target.removeEventListener(Event.COMPLETE, battleCompleteHandler);
			TweenMax.delayedCall(3, actionClose);
		}

		protected function actionClose() : void
		{
			MainNaviView.instance.show();
		}
	}
}
