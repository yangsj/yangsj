package view.role_train
{
	
	import datas.TeamInfoData;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.resource.role_train.ResourceRoleTrainView;
	
	import utils.TextFieldTyper;
	
	import view.ViewBase;
	
	
	/**
	 * 说明：RoleTrainView
	 * @author Victor
	 * 2012-10-1
	 */
	
	public class RoleTrainView extends ViewBase
	{
		private const PREFIX_ROLE:String = "role_";
		private const PREFIX_EFFECT:String = "roleSelectedEffect_";
		private const PREFIX_LAB_FRAME:String = "lab_";
		private const MAX_LENGTH:int = 4;
		
		private var roleTrainView:ResourceRoleTrainView;
		
		private var roleContainer:Sprite;
		private var skillContainer:Sprite;
		private var textWriteManager:TextFieldTyper;
		
		public function RoleTrainView()
		{
			super();
			
			createResource();
		}
		
		private function createResource():void
		{
			roleTrainView = new ResourceRoleTrainView();
			addChild(roleTrainView);
			
			roleContainer = new Sprite();
			skillContainer = new Sprite();
			roleTrainView.addChild(roleContainer);
			roleTrainView.addChild(skillContainer);
			
			adjustSize(roleTrainView);
			
			createRoleItemLayout();
			
			roleTrainView.skillSelectedEffect_1.visible = false;
			roleTrainView.skillSelectedEffect_2.visible = false;
			roleTrainView.skillSelectedEffect_3.visible = false;
			roleTrainView.skillSelectedEffect_4.visible = false;
			
			roleTrainView.skillSelectedEffect_1.stop();
			roleTrainView.skillSelectedEffect_2.stop();
			roleTrainView.skillSelectedEffect_3.stop();
			roleTrainView.skillSelectedEffect_4.stop();
			
			roleTrainView.txtExp.text = "EXP 8888";
			roleTrainView.txtImmortalValue.text = "666";
			roleTrainView.txtCurrentExp.text = "6666 / 8888";
		}
		
		private function createRoleItemLayout():void
		{
			var dataArray:Array = TeamInfoData.selected;
			var length:int = dataArray.length;
			for (var i:int = 0; i < MAX_LENGTH; i++)
			{
				var role:DisplayObject = roleTrainView[PREFIX_ROLE + (i + 1)] as DisplayObject;
				if (i < length)
				{
					var item:RoleTrainRoleItem = RoleTrainRoleItem.create();
					item.target = role;
					item.selectedEffect = roleTrainView[PREFIX_EFFECT + (i + 1)] as MovieClip;
					item.callBackClick = callBackFun;
					item.isDefault = (i == 0);
					item.data = dataArray[i];
					roleContainer.addChild(role);
					item.initialization();
				}
				else
				{
					if (role.hasOwnProperty("role"))
					{
						role["role"]["gotoAndStop"](PREFIX_LAB_FRAME + "empty");
					}
					else if (role.hasOwnProperty("gotoAndStop"))
					{
						role["gotoAndStop"](PREFIX_LAB_FRAME + "empty");
					}
					roleTrainView[PREFIX_EFFECT + (i + 1)].visible = false;
					roleTrainView[PREFIX_EFFECT + (i + 1)].stop();
				}
				
			}
		}
		
		private function createSkillLayout():void
		{
			
		}
		
		private function callBackFun(item:RoleTrainRoleItem):void
		{
			if (item)
			{
				roleTrainView.txtName.text = "LV " + item.level + "  " + item.name;
				roleTrainView.txtPower.text = item.power.toString();
				roleTrainView.txtWisdom.text = item.wisdom.toString();
				roleTrainView.txtPhysique.text = item.physique.toString();
				roleTrainView.txtAgile.text = item.agile.toString();
				
				roleTrainView.txtExpend.text = item.expendImmortalValue.toString();
				
				if (textWriteManager == null) textWriteManager = TextFieldTyper.create(roleTrainView.txtContent);
				textWriteManager.text = item.skillDes.toString();
				textWriteManager.restartWrite();
			}
		}
		
		override protected function onClick(event:MouseEvent):void
		{
			super.onClick(event);
			if (targetName == roleTrainView.btnReturn.name)
			{
				exit();
			}
		}
		
	}
	
}