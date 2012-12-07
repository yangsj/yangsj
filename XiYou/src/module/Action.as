package module
{

	import module.status;
	use namespace status;

	import flash.events.Event;
	import flash.events.EventDispatcher;


	[Event(name = "complete", type = "flash.events.Event")]
	public class Action extends EventDispatcher
	{
		public var id : String;

		public function Action(id : String)
		{
			this.id = id;
		}

		status function start() : void
		{
			throw '重写Action::start';
		}

		status function pause() : void
		{
			throw '重写Action::pause';
		}

		status function resume() : void
		{
			throw '重写Action::resume';
		}

		status function abort() : void
		{
			throw '重写Action::abort';
		}

		status function complete(... args) : void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
