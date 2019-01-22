/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 02.10.12
 */
package com.grom.timing.frameCalls
{
public class FrameCalls
{
	protected var _frameCallers:Array = [];

	public function FrameCalls()
	{
	}

	public function clear():void
	{
		_frameCallers.length = 0;
	}

	public function addFrameCall(time:Number, callback:Function):void
	{
		addCallback(new FrameCallback(time, callback));
	}

	public function addCallback(callback:IFrameCallback):void
	{
		_frameCallers.push(callback);
	}

	public function frameStep(time:Number):void
	{
		for (var i:int = _frameCallers.length - 1; i >= 0; i--)
		{
			var dc:IFrameCallback = _frameCallers[i];
			dc.loop(time);
			if (!dc.isActive)
			{
				_frameCallers.splice(i, 1);
			}
		}
	}
}
}
