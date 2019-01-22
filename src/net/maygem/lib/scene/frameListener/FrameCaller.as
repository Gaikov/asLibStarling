/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 13.09.12
 */
package net.maygem.lib.scene.frameListener
{
import flash.display.DisplayObject;

public class FrameCaller implements IFrameListener
{
	private var _frameStep:int;
	private var _framesLeft:int = 0;
	private var _callback:Function;
	private var _policy:FramePolicy;

	public function FrameCaller(object:DisplayObject, frameStep:int, callback:Function)
	{
		_frameStep = frameStep;
		_callback = callback;
		//_policy = new FramePolicy(this, object)
	}

	public function set enabled(value:Boolean):void
	{
		_policy.enabled = value;
	}

	public function onEnterFrame():void
	{
		_framesLeft --;
		if (_framesLeft <= 0)
		{
			_framesLeft = _frameStep;
			_callback();
		}
	}
}
}
