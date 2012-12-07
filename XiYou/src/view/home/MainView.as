package view.home
{

	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import global.Global;
	
	import manager.ui.UIMainManager;
	
	import ui.resource.ResourceMainView;
	
	import utils.FunctionUtils;
	
	import view.ViewBase;
	import view.arena.ArenaView;
	import view.ectypal.EctypalView;
	import view.egg_extract.EggExtractView;
	import view.prestige_exchange.PrestigeExchangeView;
	import view.role_train.RoleTrainView;
	import view.synthetize.SynthetizeView;
	import view.team_into.TeamInfoView;


	/**
	 * 说明：MainView
	 * @author Victor
	 * 2012-9-29
	 */

	public class MainView extends ViewBase
	{

		/** 资源 */
		private var mainView : ResourceMainView;

		private var inputMode : String;
		private var openViewNeed : DisplayObject;

		public function MainView()
		{
			super();

			createResource();
		}

		private function createResource() : void
		{
			mainView = new ResourceMainView();
			this.addChild(mainView);

			adjustSize(mainView);
		}

		override protected function addedToStageHandler(event : Event) : void
		{
			// 设置只侦听鼠标事件
			inputMode = Multitouch.inputMode;
			Multitouch.inputMode = MultitouchInputMode.NONE;

			super.addedToStageHandler(event);
		}

		override protected function removedFromStageHandler(event : Event) : void
		{
			Multitouch.inputMode = inputMode;
			FunctionUtils.removeChild(mainView);
			mainView = null;
			
			super.removedFromStageHandler(event);
		}

		override protected function onClick(event : MouseEvent) : void
		{
			super.onClick(event);
			
			switch (targetName)
			{
				case "btn0": // log("队伍编成");
					openViewNeed = new TeamInfoView();
					break;
				case "btn1": // log("队伍编成");
					openViewNeed = new TeamInfoView();
					break;
				case "btn2": // log("角色培养");
					return ;
					openViewNeed = new RoleTrainView();
					break;
				case "btn3": // log("扭蛋抽取");
					openViewNeed = new EggExtractView();
					break;
				case "btn4": // log("炼妖合成");
					openViewNeed = new SynthetizeView();
					break;
				case "btn5": // log("声望兑换");
					return ;
					//openViewNeed = new PrestigeExchangeView();
					openViewNeed = new ArenaView(true); // use test
					break;
				case "btn6": // log("竞技场");
//					return ;
					openViewNeed = new ArenaView();
					break;
				case "btnEctypal": // log("副本");
					openViewNeed = new EctypalView();
					break;
				case "btnExit": // log("退出");
					if (Global.exitApp != null)
					{
						Global.exitApp.apply(this);
					}
					break;
				default :
					
			}
			if (openViewNeed)
			{
				exit();
			}
		}

		override protected function actionClose() : void
		{
			UIMainManager.removeChild(this);
			if (openViewNeed)
			{
				UIMainManager.addChild(openViewNeed);
			}
			openViewNeed = null;
		}

	}

}
