package app.modules.chat.command
{
	import app.modules.ViewName;
	import app.modules.chat.model.ChatModel;
	import app.modules.chat.service.ChatService;
	import app.modules.chat.view.ChatMediator;
	import app.modules.chat.view.ChatView;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class ChatInitCommand extends BaseCommand
	{
		public function ChatInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.Chat, ChatView, ChatMediator );
			
			injectActor( ChatModel );
			injectActor( ChatService );
		}
		
	}
}