/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 22.02.13
 */
package com.grom.timing.frameCalls
{
public interface IFrameCallback
{
	function get isActive():Boolean;
	function loop(time:Number):void
}
}
