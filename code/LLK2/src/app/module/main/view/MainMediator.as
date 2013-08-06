package app.module.main.view
{
	import app.events.ViewEvent;
	import app.module.ViewName;
	
	import framework.BaseMediator;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class MainMediator extends BaseMediator
	{
		public function MainMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			super.onRegister();


		}

		override public function onRemove():void
		{
			super.onRemove();

			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.MENU ));
		}

	}
}
