/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 25.1.12
 */
package net.maygem.lib.input.keyboard
{
import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;

public class GlobalKeyboardPolicy
{
	private var _obj:DisplayObject;

	private var _listener:IKeyListener;
	private var _stage:Stage;

	public function GlobalKeyboardPolicy(listener:IKeyListener, view:DisplayObject)
	{
		_listener = listener;
		_obj = view;
		_obj.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_obj.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}

	private function onAddedToStage(event:Event):void
	{
		_stage = _obj.stage;
		_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	private function onRemovedFromStage(event:Event):void
	{
		_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		_stage = null;
	}

	private function onKeyUp(event:KeyboardEvent):void
	{
		_listener.onKeyUp(event.keyCode);
	}

	private function onKeyDown(event:KeyboardEvent):void
	{
		_listener.onKeyDown(event.keyCode);
	}	



}
}
