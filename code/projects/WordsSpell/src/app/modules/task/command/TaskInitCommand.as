package app.modules.task.command
{
	import app.modules.ViewName;
	import app.modules.task.model.TaskModel;
	import app.modules.task.service.TaskService;
	import app.modules.task.view.TaskMediator;
	import app.modules.task.view.TaskView;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class TaskInitCommand extends BaseCommand
	{
		public function TaskInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.Task, TaskView, TaskMediator );
			
			injectActor( TaskModel );
			injectActor( TaskService );
		}
		
	}
}