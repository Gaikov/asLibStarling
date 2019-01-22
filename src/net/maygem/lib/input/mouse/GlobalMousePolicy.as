/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 25.1.12
 */
package net.maygem.lib.input.mouse
{
import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

public class GlobalMousePolicy
{
	private var _obj:DisplayObject;

	private var _listener:IGlobalMouseListener;
	private var _stage:Stage;

	public function GlobalMousePolicy(listener:IGlobalMouseListener)
	{
		_listener = listener;
		_obj = _listener.asDisplayObject();
		_obj.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_obj.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}

	private function onAddedToStage(event:Event):void
	{
		_stage = _obj.stage;
		_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}


	private function onRemovedFromStage(event:Event):void
	{
		_stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_stage = null;
	}

	private function onMouseDown(event:MouseEvent):void
	{
		_listener.onMouseDown(event.stageX, event.stageY);
	}

	private function onMouseWheel(event:MouseEvent):void
	{
	 	_listener.onMouseWheel(event.delta);
	}

	private function onMouseMove(event:MouseEvent):void
	{
		_listener.onMouseMove(event.stageX, event.stageY);
	}
	
}
}
