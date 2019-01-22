/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 25.1.12
 */
package net.maygem.lib.input.touch
{
import starling.display.DisplayObject;
import starling.display.Stage;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;

public class GlobalTouchPolicy
{
	private var _obj:DisplayObject;

	private var _listener:ITouchListener;
	private var _stage:Stage;

	public function GlobalTouchPolicy(listener:ITouchListener, obj:DisplayObject)
	{
		_listener = listener;
		_obj = obj;
		_obj.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_obj.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		if (_obj.stage)
		{
			addListener();
		}
	}

	private function onAddedToStage(event:Event):void
	{
		addListener();
	}

	private function onRemovedFromStage(event:Event):void
	{
		removeListener();
	}

	private function addListener():void
	{
		_stage = _obj.stage;
		_stage.addEventListener(TouchEvent.TOUCH, onTouchEvent);
	}

	private function removeListener():void
	{
		_stage.removeEventListener(TouchEvent.TOUCH, onTouchEvent);
		_stage = null;
	}

	private function onTouchEvent(event:TouchEvent):void
	{
		var touch:Touch = event.getTouch(_stage);
		if (touch)
		{
			_listener.onTouch(touch);
		}
	}

	public function destroy():void
	{
		if (_stage)
		{
			_stage = _obj.stage;
			_stage.addEventListener(TouchEvent.TOUCH, onTouchEvent);
		}

		_obj.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_obj.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		_obj = null;
	}
}
}
