/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 05.06.13
 * Time: 23:52
 * To change this template use File | Settings | File Templates.
 */
package com.grom.starlingUtils.display
{
import flash.display.DisplayObject;

import net.maygem.lib.utils.UMath;

import starling.display.DisplayObject;

public class DisplayMixed
{
	static public function copyPosFtoS(from:flash.display.DisplayObject, to:starling.display.DisplayObject):void
	{
		to.x = from.x;
		to.y = from.y;
	}

	static public function copyAttrFtoS(from:flash.display.DisplayObject, to:starling.display.DisplayObject):void
	{
		copyPosFtoS(from, to);
		to.rotation = UMath.deg2rad(from.rotation);
		to.scaleX = from.scaleX;
		to.scaleY = from.scaleY;
	}

	static public function copyAttrStoF(from:starling.display.DisplayObject, to:flash.display.DisplayObject):void
	{
		to.x = from.x;
		to.y = from.y;
		to.rotation = UMath.rad2deg(from.rotation);
		to.scaleX = from.scaleX;
		to.scaleY = from.scaleY;
	}
}
}
