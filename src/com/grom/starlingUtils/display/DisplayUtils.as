/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.display
{
import net.maygem.lib.utils.UMath;

import starling.display.DisplayObject;
import flash.geom.Point;
import flash.geom.Rectangle;

import starling.display.DisplayObjectContainer;

public class DisplayUtils
{

	static public function placeAtOrigin(obj:DisplayObject, x:Number, y:Number):void
	{
		var pos:Point = convertToOriginPos(obj, x, y);
		obj.x = pos.x;
		obj.y = pos.y;
	}

	static public function convertToOriginPos(obj:DisplayObject, x:Number, y:Number):Point
	{
		var bounds:Rectangle = getScaledBounds(obj);
		return new Point(x - bounds.x, y - bounds.y);
	}

	static public function getScaledBounds(obj:DisplayObject):Rectangle
	{
		var rect:Rectangle = obj.getBounds(obj);
		return new Rectangle(rect.left * obj.scaleX, rect.top * obj.scaleY,
			rect.right * obj.scaleX, rect.bottom * obj.scaleY);
	}

	static public function findChildInDepth(childName:String, contianer:DisplayObject):DisplayObject
	{
		var c:DisplayObjectContainer = contianer as DisplayObjectContainer;
		if (c)
		{
			for (var i:int = 0; i < c.numChildren; i++)
			{
				var child:DisplayObject = c.getChildAt(i);
				if (child.name == childName)
				{
					return child;
				}
			}

			for (i = 0; i < c.numChildren; i++)
			{
				child = findChildInDepth(childName, c.getChildAt(i));
				if (child)
				{
					return child;
				}
			}
		}

		return null;
	}

	public static function forEach(c:DisplayObjectContainer, childFunc:Function):void
	{
		if (!c) return;

		for (var i:int = 0; i < c.numChildren; i++)
		{
			var child:DisplayObject = c.getChildAt(i);
			childFunc(child);
			forEach(child as DisplayObjectContainer, childFunc);
		}
	}

	public static function setAllTouchable(c:DisplayObject):void
	{
		c.touchable = true;

		var container:DisplayObjectContainer = c as DisplayObjectContainer;
		if (container)
		{
			forEach(container, function(child:DisplayObject):void
			{
				child.touchable = true;
			});
		}
	}

	public static function getPos(obj:DisplayObject):Point
	{
		return new Point(obj.x, obj.y);
	}

	public static function setPos(obj:DisplayObject, point:Point):void
	{
		obj.x = point.x;
		obj.y = point.y;
	}

	public static function setScale(obj:DisplayObject, s:Number):void
	{
		obj.scaleX = obj.scaleY = s;
	}

	public static function copyPos(from:DisplayObject, to:DisplayObject):void
	{
		to.x = from.x;
		to.y = from.y;
	}


	public static function globalPos(obj:DisplayObject):Point
	{
		return obj.localToGlobal(new Point(0, 0));
	}

	static public function getRotation(dir:Point):Number
	{
		return UMath.rad2deg(Math.atan2(dir.y, dir.x));
	}

	static public function setDirection(obj:DisplayObject, dir:Point, addAngle:Number = 0):void
	{
		obj.rotation = UMath.deg2rad(getRotation(dir) + addAngle + 90);
	}

}
}
