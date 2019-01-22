/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 06.06.13
 */
package com.grom.starlingUtils.layout.items
{
import flash.geom.Point;
import flash.geom.Rectangle;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.textures.Texture;

public class ImageFixed extends Image
{
	public function ImageFixed(texture:Texture)
	{
		super(texture);
	}

	override public function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject
	{
		if (forTouch && (!visible || !touchable)) return null;

		var hitFrame:Rectangle = getLocalRect();
		if (hitFrame.containsPoint(localPoint))
		{
			return this;
		}

		return null;
	}

	private function getLocalRect():Rectangle
	{
		var frame:Rectangle = texture.frame;
		return new Rectangle(-frame.left, -frame.top, frame.width, frame.height);
	}

	private function getLocalTo(target:DisplayObject, pos:Point):Point
	{
		return target.globalToLocal(localToGlobal(pos));
	}

	private var _points:Array = [];

	override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle
	{
		if (resultRect == null) resultRect = new Rectangle();

		var localFrame:Rectangle = getLocalRect();

		_points.length = 0;
		_points.push(getLocalTo(targetSpace, localFrame.topLeft));
		_points.push(getLocalTo(targetSpace, localFrame.bottomRight));
		_points.push(getLocalTo(targetSpace, new Point(localFrame.right, localFrame.top)));
		_points.push(getLocalTo(targetSpace, new Point(localFrame.left, localFrame.bottom)));

		var pos:Point = _points[0];

		var minX:Number = pos.x;
		var maxX:Number = pos.x;
		var minY:Number = pos.y;
		var maxY:Number = pos.y;

		for (var i:int = 1; i < 4; i++)
		{
			pos = _points[i];
			minX = Math.min(minX, pos.x);
			maxX = Math.max(maxX, pos.x);

			minY = Math.min(minY, pos.y);
			maxY = Math.max(maxY, pos.y);
		}

		resultRect.x = minX;
		resultRect.width = maxX - minX;

		resultRect.y = minY;
		resultRect.height = maxY - minY;

		return resultRect;
	}
}
}
