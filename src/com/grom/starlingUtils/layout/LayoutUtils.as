/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.layout
{
import net.maygem.lib.utils.UMath;

import starling.display.DisplayObject;

public class LayoutUtils
{
	public static function copyParams(source:XML, obj:DisplayObject):void
	{
		copyParamsNoScale(source, obj);
		obj.scaleX = source.@sx;
		obj.scaleY = source.@sy;
	}

	public static function copyParamsNoScale(source:XML, obj:DisplayObject):void
	{
		obj.name = source.@name;
		obj.x = source.@x;
		obj.y = source.@y;
		obj.rotation = UMath.deg2rad(source.@rotation);
	}

}
}
