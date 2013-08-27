package victor.framework.core
{
	import org.robotlegs.mvcs.Command;
	
	
	/**
	 * ……
	 * @author yangsj
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