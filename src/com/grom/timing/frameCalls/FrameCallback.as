/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 02.10.12
 */
package com.grom.timing.frameCalls
{
public class FrameCallback implements IFrameCallback
{
	private var _periodSec:Number;
	private var _timeLeft:Number;
	private var _callback:Function;

	public function FrameCallback(periodTime:Number, callback:Function)
	{
		_periodSec = periodTime;
		_timeLeft = periodTime;
		_callback = callback;
	}

	public function get isActive():Boolean
	{
		return true;
	}

	final public function loop(time:Number):void
	{
		_timeLeft -= time;
		if (_timeLeft <= 0)
		{
			_timeLeft += _periodSec;
			callFunc();
		}
	}

	protected function callFunc():void
	{
		_callback();
	}
}
}
