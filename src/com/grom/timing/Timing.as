/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.09.12
 */
package com.grom.timing
{
import flash.display.DisplayObject;

public class Timing
{
	static public function delay(obj:DisplayObject, frames:int, callback:Function):void
	{
		new Delay(obj, frames, callback);
	}

}
}

import flash.display.DisplayObject;

import net.maygem.lib.scene.frameListener.FramePolicy;

import net.maygem.lib.scene.frameListener.IFrameListener;

class Delay implements IFrameListener
{
	private var _framesLeft:int;
	private var _callback:Function;
	private var _policy:FramePolicy;

	public function Delay(obj:DisplayObject, frames:int, callback:Function)
	{
		_framesLeft = frames;
		_callback = callback;
		//_policy = new FramePolicy(this, obj);
	}

	public function onEnterFrame():void
	{
		_framesLeft--;
		if (_framesLeft <= 0)
		{
			_policy.destroy();
			_callback();
		}
	}
}
