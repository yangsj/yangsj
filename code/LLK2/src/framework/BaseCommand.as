package framework
{
	import org.robotlegs.mvcs.Command;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BaseCommand extends Command
	{
		public function BaseCommand()
		{
			super();
		}

		protected function addView( view:Class, mediator:Class ):void
		{
			mediatorMap.mapView( view, mediator );
			injector.mapSingleton( view );
		}

		protected function injectActor( clazz:Class ):void
		{
			var obj:Object = injector.instantiate( clazz );
			injector.mapValue( clazz, obj );
		}

	}
}
