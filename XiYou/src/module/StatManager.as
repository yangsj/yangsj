package module
{
	import charactersOld.Character;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	use namespace status;




	public class StatManager
	{
		public var law : Object = {};
		private var _currentAction : Action;
		public var waiting : Object = {};
		private var host : Character;

		public function StatManager(host : Character)
		{
			this.host = host;
		}

		public function makeRules(a : String, b : String, rule : String) : void
		{
			if (law[a])
				law[a][b] = rule;
			else
			{
				law[a] = {};
				law[a][b] = rule;
			}
		}

		public function ruleOf(a : Action, b : Action) : String
		{
			if (law[a.id] == null)
				return null;
			return law[a.id][b.id];
		}

		public function requestAction(action : Action) : void
		{
//			log(getTimer(), host.name, 'ACTI:', action, currentAction);
			if (currentAction == null)
			{
				currentAction = action;
				action.addEventListener(Event.COMPLETE, actionComplete);
				action.start();
			}
			else
			{
//				log(host.name, 'RULE:', ruleOf(currentAction, action));
//				log('--------------------------------------------------');
				switch (ruleOf(currentAction, action))
				{
					case Rule.KILL:
						currentAction.abort();
						currentAction = action;
						action.addEventListener(Event.COMPLETE, actionComplete);
						action.start();
						break;
					case Rule.KILL_RESTART:
						currentAction.abort();
						waiting[action.id] = currentAction;
						currentAction = action;
						action.addEventListener(Event.COMPLETE, actionComplete);
						action.start();
						break;
//					case Rule.INTERRUPT:
//						currentAction.pause();
//						waiting[action] = currentAction;
//						currentAction = action;
//						action.addEventListener(Event.COMPLETE, actionComplete);
//						action.start();
//						break;
					case Rule.WAIT:
						waiting[currentAction.id] = action;
						currentAction.addEventListener(Event.COMPLETE, actionComplete);
						break;
					default:
						break;
				}
			}
		}

		protected function actionComplete(event : Event) : void
		{
			var action : Action = event.currentTarget as Action;
			action.removeEventListener(Event.COMPLETE, actionComplete);
			var waitee : Action = waiting[action.id];
			waiting[action.id] = null;
			delete waiting[action.id];
//			log(getTimer(), host.name, 'action complete:', action, 'waitee:', waitee);
			currentAction = null;
			if (waitee != null)
			{
				var rule : String = ruleOf(action, waitee);
				log(host.name, 'rule:', rule, action, waitee);
				switch (rule)
				{
					case Rule.KILL_RESTART:
					case Rule.WAIT:
//						currentAction = waitee;
						requestAction(waitee);
						break;
//					case Rule.INTERRUPT:
//						currentAction = waitee;
//						waiting[action.id] = null;
//						delete waiting[action.id];
//						waitee.resume();
//						break;
				}
			}
		}

		public function get currentAction() : Action
		{
			return _currentAction;
		}

		public function set currentAction(value : Action) : void
		{
			if (value == null)
				trace('-------');
			_currentAction = value;
		}

	}
}
