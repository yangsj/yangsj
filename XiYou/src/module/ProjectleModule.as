package module
{

	import charactersOld.Character;
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import global.Orientation;
	import interfaces.ICombatant;
	import interfaces.IRushCombatant;
	import utils.Heartbeat;
	import utils.SpriteUtils;
	
	
	
	
	


	public class ProjectleModule
	{
		private var host : IRushCombatant;
		private var projectle : MovieClip;
		private var getEnemiesFunc : Function;
		private var range : Number;
		private var tween : int;
		private var duration : Number;
		private var _hit : Boolean;
		public function ProjectleModule(host : IRushCombatant, projectle : MovieClip, getEnemiesFunc : Function)
		{
			this.host = host;
			range = host.attackRange;
			duration = (range / (IRushCombatant(host).projectileSpeed * 24)) * 1000;
			
			this.getEnemiesFunc = getEnemiesFunc;
			this.projectle = projectle;
		}

		public function shoot(onHit : Function) : void
		{
			projectle.scaleX = host.orientation * -1;
			projectle.x = host.x + 50 * host.orientation;
			projectle.y = host.y - 40;
			projectle.visible = true;
			projectle.play();
			_hit = false;
			tween = Heartbeat.instance.tween(projectle, duration, {x: (projectle.x + range) * host.orientation, onUpdate : function() : void
			{
				var enemies : Array = getEnemiesFunc();	
				enemies.sortOn('x', Array.NUMERIC | ((host.orientation == Orientation.LEFT) ? Array.DESCENDING : 0));
				var target : Character = enemies[0];
				if (target){
					var cond : Boolean = host.orientation == 1 ? projectle.x > target.x : projectle.x < target.x;
					if (cond)
					{
						if (_hit)
							return;
						_hit = true;
						Heartbeat.instance.remove(tween);
						projectle.stop();
						onHit(target);
						if (host.HP <= 0)
							SpriteUtils.safeRemove(projectle);
					}
				}
			}, onComplete : function() : void{
				_hit = false;
				projectle.visible = false;
				projectle.stop();
				if (host.HP <= 0)
					SpriteUtils.safeRemove(projectle);
			}});
		}
	}
}
