package view.arena
{
	import datas.RolesID;
	import datas.TeamInfoData;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import global.DeviceType;
	import global.Global;
	
	import manager.ui.UIMainManager;
	
	import ui.resource.arena.ResourceArenaView;
	
	import utils.ArrayUtils;
	
	import view.ViewBase;
	import view.arena.battle.ArenaBattleScene;
	import view.battle.BattleView;
	import view.home.MainView;
	
	
	/**
	 * 说明：ArenaView
	 * @author Victor
	 * 2012-10-1
	 */
	
	public class ArenaView extends ViewBase
	{
		private const DISTANCE_Y:Number = (Global.isDifferenceSwf && Global.deviceType == DeviceType.ANDROID) ? 54 : 72; // item list y axis distance
		
		private var arenaView:ResourceArenaView;
		
		private var data:Array = [];
		
		private var testValue:Boolean = false;
		
		public function ArenaView(testValue:Boolean=false)
		{
			super();
			
			this.testValue = testValue;
			
			// test data
			var tempArr:Array = RolesID.canUseRoleId;
			var length:int = tempArr.length;
			var num0:int = int(Math.random() * length);
			var num1:int = int(Math.random() * length);
			var num2:int = int(Math.random() * length);
			var num3:int = int(Math.random() * length);
			var num4:int = int(Math.random() * length);
			var num5:int = int(Math.random() * length);
			var num6:int = int(Math.random() * length);
			var num7:int = int(Math.random() * length);
			var num8:int = int(Math.random() * length);
			var num9:int = int(Math.random() * length);
			
			data = [{name:"盖东宁", power:232, award:10, team:[tempArr[num0], tempArr[num1]]}, {name:"卸际滨", power:242, award:11, team:[tempArr[num0], tempArr[num1], tempArr[num2]]},
					{name:"秦风累", power:222, award:30, team:[tempArr[num3], tempArr[num4]]}, {name:"李井泉", power:321, award:16, team:[tempArr[num3], tempArr[num4], tempArr[num5]]}, 
					{name:"涂玉卫", power:300, award:52, team:[tempArr[num5], tempArr[num6]]}, {name:"石普娟", power:124, award:20, team:[tempArr[num4], tempArr[num5], tempArr[num6], tempArr[num7]]},
					{name:"李佳毅", power:221, award:14, team:[tempArr[num7], tempArr[num8]]}, {name:"龙  娟", power:234, award:23, team:[tempArr[num9], tempArr[num8], tempArr[num6], tempArr[num7]]},
					{name:"测 试1", power:221, award:14, team:[0, 1, 3]}, {name:"测 试2", power:221, award:14, team:[14, 19, 20, tempArr[num8]]}];
			
			createResource();
			
			createItemList();
		}
		
		private function createResource():void
		{
			arenaView = new ResourceArenaView();
			this.addChild(arenaView);
			
			adjustSize(arenaView);
		}
		
		private function createItemList():void
		{
			while (arenaView.container.numChildren > 0) arenaView.container.removeChildAt(0);
			
			ArrayUtils.randomSortOn(data);
			var length:int = 4;
			var array:Array = data.slice(0,length);
			length = array.length;
			for (var i:int = 0; i < length; i++)
			{
				var item:ArenaItem = new ArenaItem();
				item.callBackFunction = callBackFunction;
				item.data = array[i];
				item.initialization();
				item.y = DISTANCE_Y * i;
				arenaView.container.addChild(item);
			}
		}
		
		private function callBackFunction(item:ArenaItem):void
		{
			var opTeam:Array = item.team; // 将要挑战的对手的战队
			// 启动战斗系统
			UIMainManager.removeChild(this);
			
//			UIMainManager.addChild(new BattleView(opTeam, false, testValue));
			
			TeamInfoData.enemyerTeams = opTeam;
			
			UIMainManager.addChild(new ArenaBattleScene());
		}
		
		override protected function onClick(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if (targetName == arenaView.btnRefresh.name)
			{
				// 刷新列表
				createItemList();
			}
			else if (targetName == arenaView.btnReturn.name)
			{
				// 返回
				exit();
			}
		}
		
		
	}
	
}