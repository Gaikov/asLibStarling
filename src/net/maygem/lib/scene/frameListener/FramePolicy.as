/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 1.2.12
 */
package net.maygem.lib.scene.frameListener
{
import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.events.Event;

public class FramePolicy
{
	private var _object:DisplayObject;
	private var _listener:IAnimatable;
	private var _enabled:Boolean = true;

	public function FramePolicy(listener:IAnimatable, object:DisplayObject)
	{
		_object = object;
		_listener = listener;

		_object.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_object.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		updateListener(_object.stage != null);
	}

	public function destroy():void
	{
		_object.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		_object.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		Starling.juggler.remove(_listener);
	}

	public function get enabled():Boolean
	{
		return _enabled;
	}

	public function set enabled(value:Boolean):void
	{
		_enabled = value;
		updateListener(_object.stage != null);
	}

	private function onAddedToStage(event:Event):void
	{
		updateListener(true);
	}

	private function onRemovedFromStage(event:Event):void
	{
		updateListener(false);
	}

	private function updateListener(onStage:Boolean):void
	{
		if (onStage && _enabled)
			Starling.juggler.add(_listener);
		else
			Starling.juggler.remove(_listener);
	}
}
}
