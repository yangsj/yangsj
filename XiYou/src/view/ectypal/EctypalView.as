package view.ectypal
{

	import com.greensock.TweenMax;
	
	import datas.EctypalData;
	import datas.TeamInfoData;
	
	import flash.events.MouseEvent;
	
	import level.Dungeon1;
	import level.Dungeon2;
	import level.Dungeon3;
	import level.Wave;
	
	import manager.ui.UIMainManager;
	
	import ui.resource.ectypal.ResourceEctypalView;
	
	import utils.FunctionUtils;
	import utils.TextFieldTyper;
	
	import view.ViewBase;
	import view.battle.BattleView;


	/**
	 * 说明：EctypalView
	 * @author Victor
	 * 2012-10-1
	 */

	public class EctypalView extends ViewBase
	{
		private const DES_0001 : String = "tap a location on the map to proceed!";
		private const DES_0002 : String = "you have not reached this location yet. ";


		private var ectypalView : ResourceEctypalView;
		private var ectypalSelectLevel : EctypalSelectLevel;
		private var textWriteManager : TextFieldTyper;
		private var selectedItem : EctypalLevelItem;
		private var isBattle : Boolean = false;


		public function EctypalView()
		{
			super();

			createResource();
		}

		private function createResource() : void
		{
			ectypalView = new ResourceEctypalView();
			this.addChild(ectypalView);
			ectypalSelectLevel = new EctypalSelectLevel();
			ectypalSelectLevel.initialization();
			ectypalSelectLevel.callBackWriteTextFunc = displayTextContent;
			ectypalView.addChild(ectypalSelectLevel);

			adjustSize(ectypalView);

			this.mouseChildren = this.mouseEnabled = false;
		}

		override protected function clear() : void
		{
			if (textWriteManager)
			{
				textWriteManager.dispose();
				textWriteManager = null;
			}
			
			selectedItem = null;
			FunctionUtils.removeChild(ectypalView);
			FunctionUtils.removeChild(ectypalSelectLevel);
			
			EctypalLevelItem.dispose();
		}

		override protected function onClick(event : MouseEvent) : void
		{
			super.onClick(event);
			if (targetName == ectypalView.btnReturn.name)
			{
				// 返回
				isBattle = false;
				
				EctypalData.setDefaultCurrentLevel();
				
				exit();
			}
			else if (targetName == ectypalView.btnStart.name)
			{
				// 开始战斗
				isBattle = true;
				
				if (selectedItem) // 设置当前战斗的关卡号
				{
					EctypalData.currentLevel = selectedItem.level;
				}
				else // 未选择任何关卡，设置为默认值
				{
					EctypalData.setDefaultCurrentLevel();
				}
				
				exit();
			}
		}

		override protected function actionOpen() : void
		{
			displayTextContent();
			this.mouseChildren = this.mouseEnabled = true;
			ectypalView.btnStart.mouseEnabled = false;
		}

		private function displayTextContent(item : EctypalLevelItem = null) : void
		{
			if (textWriteManager == null)
			{
				textWriteManager = TextFieldTyper.create(ectypalView.txtDes);
				textWriteManager.delay = 70;
			}
			if (item)
			{
				selectedItem = item;
				if (item.isUnlocked)
				{
					ectypalView.txtName.text = item.name;
					textWriteManager.text = item.des;
					tweenBtnStart(1);
				}
				else
				{
					ectypalView.txtName.text = "? ? ?";
					textWriteManager.text = DES_0002;
					tweenBtnStart(0);
				}
			}
			else
			{
				ectypalView.txtName.text = "";
				textWriteManager.text = DES_0001;
				tweenBtnStart(0);
			}

			textWriteManager.restartWrite();

		}

		private function tweenBtnStart($alpha : Number = 0) : void
		{
			ectypalView.btnStart.mouseEnabled = false;
			if ($alpha != 0)
			{
				ectypalView.btnStart.visible = true;
			}
			TweenMax.killTweensOf(ectypalView.btnStart);
			TweenMax.to(ectypalView.btnStart, 0.4, {alpha: $alpha, onComplete: onCompelteBtnStartTween});
		}

		private function onCompelteBtnStartTween() : void
		{
			TweenMax.killTweensOf(ectypalView.btnStart);
			ectypalView.btnStart.mouseEnabled = ectypalView.btnStart.visible = (ectypalView.btnStart.alpha == 1);
		}

		private function get enemyID() : Array
		{
			var array : Array = [];
			if (selectedItem)
			{
				var teamId : String = selectedItem.teamId;
				switch (teamId)
				{
					case "0":
						array = new Dungeon1().levels;
						break;
					case "1":
						array = new Dungeon2().levels;
						break;
					case "2":
						array = new Dungeon3().levels;
						break;
					default :
						array = new Dungeon1().levels;
				}
			}
			return array;
		}

		override protected function actionClose() : void
		{
			if (isBattle)
			{
				TeamInfoData.enemyerTeams = enemyID;
				UIMainManager.addChild(new BattleView());
				UIMainManager.removeChild(this);
			}
			else
			{
				super.actionClose();
			}
		}


	}

}
