package business
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.charts.CategoryAxis;
	import mx.rpc.IResponder;
	
	public class SearchDelegate
	{
		public function SearchDelegate(responder:IResponder)
		{
			_responder = responder;
		}
		
		private var _responder:IResponder;
		
		public function search(word:String):void
		{
			var service:URLLoader = ServiceLocator.instance.getService();
			service.load(new URLRequest (Configs.SERVICE_URL + encodeURI(word)) );
			service.addEventListener(Event.COMPLETE, onComplete);
			service.addEventListener(IOErrorEvent.IO_ERROR, onError);
			service.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
		
		protected function onError(event:Event):void
		{
			_responder.fault( event.toString() );
			clean( event.currentTarget as IEventDispatcher);
		}
		
		protected function onComplete(event:Event):void
		{
			try
			{
				if((event.currentTarget as URLLoader).data)
				{
					var respond:Object = JSON.parse((event.currentTarget as URLLoader).data);
					_responder.result(respond);
				}
			}catch(e:Error)
			{
				_responder.fault( e.toString() );
			}
			clean( event.currentTarget as IEventDispatcher);
		}
		
		private function clean(target:IEventDispatcher):void
		{	
			target.removeEventListener(Event.COMPLETE, onComplete);
			target.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
	}
}