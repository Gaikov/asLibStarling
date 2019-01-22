/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 26.06.13
 */
package com.grom.system
{
import flash.system.Capabilities;

public class UDevice
{
	public static function screenSize():Number
	{
		var w:Number = Capabilities.screenResolutionX;
		var h:Number = Capabilities.screenResolutionY;
		return Math.sqrt(w * w + h * h) / Capabilities.screenDPI;
	}
}
}
