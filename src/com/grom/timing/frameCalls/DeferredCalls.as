/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 02.10.12
 */
package com.grom.timing.frameCalls
{
public class DeferredCalls extends FrameCalls
{
	public function DeferredCalls()
	{
	}

	override public function addFrameCall(periodSec:Number, callback:Function):void
	{
		_frameCallers.push(new DeferredCallback(periodSec, callback));
	}

}
}
