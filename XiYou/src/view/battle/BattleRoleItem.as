package view.battle
{

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import ui.resource.ResourceAllRoleHeadPicture2;
	import ui.resource.battle.ResourceSkillReleaseEffectIcon;


	/**
	 * 说明：BattleRoleItem
	 * @author Victor
	 * 2012-10-18
	 */

	public class BattleRoleItem extends Sprite
	{
		private var FRAMELAB : String = "lab_";

		private var headPhoto : MovieClip;
		private var effectRes : MovieClip;
		private var shape : Shape;
		private var shapeMask : Shape;
		private var canClick : Boolean = false;

		private var const_width : Number = 132;
		private var const_height : Number = 132;
		private var const_radius : Number = 100;

		private var sectorStartAngle : Array = [-360];
		private var tween : TweenMax;


		private var _id : int = -1;
		private var _data : Object;

		public var callBackFun : Function;
		/** 指定该角色是否能用技能 */
		public var isSkillEnabled : Boolean = true;

		public function BattleRoleItem()
		{
			createResource();

			this.mouseChildren = false;
		}

		public function initialize() : void
		{
			addEvents();

			if (isSkillEnabled == false)
			{
				this.mouseEnabled = false;
				drawSector(shape, 0, 0, const_radius, 360, 270);
				stopEffect();
				shape.alpha = 0.5;
			}
			else
			{
				delayPlayEffect();
				shape.alpha = 0.8;
			}
		}

		private function dispose() : void
		{
			headPhoto = null;
			shape.mask = null;
			shape = null;
			shapeMask = null;
			_data = null;

			callBackFun = null;

			killTween();
		}

		private function createResource() : void
		{
			headPhoto = new ResourceAllRoleHeadPicture2();
			headPhoto.x = headPhoto.y = 1;
			addChild(headPhoto);

			const_width = headPhoto.width + 2;
			const_height = headPhoto.height + 2;

			shape = new Shape();
			shape.x = const_width * 0.5;
			shape.y = const_width * 0.5;
			addChild(shape);
			shape.alpha = 0.8;

			shapeMask = new Shape();
			shapeMask.graphics.beginFill(0xff0000);
			shapeMask.graphics.drawRoundRect(1, 1, const_width - 2, const_height - 2, 10, 10);
			shapeMask.graphics.endFill();
			addChild(shapeMask);

			effectRes = new ResourceSkillReleaseEffectIcon();
			effectRes.x = shape.x;
			effectRes.y = shape.y;
			addChild(effectRes);

			stopEffect();

			shape.mask = shapeMask;
		}

		private function delayPlayEffect() : void
		{
			tween = TweenMax.delayedCall(5, playEffect);
		}

		private function playEffect() : void
		{
			killTween();
			if (effectRes)
			{
				effectRes.gotoAndPlay(1);
				effectRes.visible = true;
				canClick = true;
			}
		}

		private function stopEffect() : void
		{
			if (effectRes)
			{
				effectRes.gotoAndStop(1);
				effectRes.visible = false;
				canClick = false;
			}
		}

		private function drawSector(dis : Shape, x : Number = 0, y : Number = 0, radius : Number = 100, angle : Number = 45, startFrom : Number = 0, color : Number = 0x000000) : void
		{
			dis.graphics.clear();
			dis.graphics.beginFill(color);
			dis.graphics.moveTo(x, y);
			angle = (Math.abs(angle) > 360) ? 360 : angle;
			var n : Number = Math.ceil(Math.abs(angle) / 45);
			var angleA : Number = angle / n;
			angleA = angleA * Math.PI / 180;
			startFrom = startFrom * Math.PI / 180;
			dis.graphics.lineTo(x + radius * Math.cos(startFrom), y + radius * Math.sin(startFrom));
			for (var i : int = 1; i <= n; i++)
			{
				startFrom += angleA;
				var angleMid : Number = startFrom - angleA / 2;
				var bx : Number = x + radius / Math.cos(angleA / 2) * Math.cos(angleMid);
				var by : Number = y + radius / Math.cos(angleA / 2) * Math.sin(angleMid);
				var cx : Number = x + radius * Math.cos(startFrom);
				var cy : Number = y + radius * Math.sin(startFrom);
				dis.graphics.curveTo(bx, by, cx, cy);
			}
			if (angle != 360)
			{
				dis.graphics.lineTo(x, y);
			}
			dis.graphics.endFill();
		}

		private function addEvents() : void
		{
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
		}

		private function removeEvents() : void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
		}

		protected function removedFromStageHandler(event : Event) : void
		{
			removeEvents();

			dispose();
		}

		protected function mouseHandler(event : MouseEvent) : void
		{
			var type : String = event.type;
			if (type == MouseEvent.MOUSE_DOWN)
			{
				if (canClick)
				{
					stopEffect();
					canClick = false;
					sectorStartAngle = [-360];
					if (callBackFun != null)
					{
						callBackFun.call(this, id);
					}
					tween = TweenMax.to(sectorStartAngle, 5, {endArray: [0], onUpdate: tweenOnUpdate, onComplete: tweenOnComplete});
				}
			}
		}

		private function tweenOnUpdate() : void
		{
			drawSector(shape, 0, 0, const_radius, sectorStartAngle[0], 270);
		}

		private function tweenOnComplete() : void
		{
			killTween();
			delayPlayEffect();
		}

		private function killTween() : void
		{
			if (tween)
			{
				tween.pause();
				tween.kill();
				tween = null;
			}
		}

		public function get id() : int
		{
			return _id;
		}

		public function set id(value : int) : void
		{
			_id = value;
			if (value > -1)
			{
				if (headPhoto)
				{
					headPhoto.gotoAndStop(FRAMELAB + value);
				}
			}
		}

		public function get data() : Object
		{
			return _data;
		}

		public function set data(value : Object) : void
		{
			_data = value;
		}


	}

}
