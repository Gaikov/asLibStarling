package net.maygem.lib.ui.layout
{
import flash.display.DisplayObject;

import flash.geom.Rectangle;

import net.maygem.lib.utils.UDisplay;

public class LayoutUtils
{
	static public function layoutForm(pairsList:Array, horizontalGap:int, verticalGap:int):void
	{
		var pair:FormLayoutPair = pairsList[i];
		var maxLabelWidth:int = pair.label.width;

		for (var i:int = 1; i < pairsList.length; i++)
		{
			pair = pairsList[i];
			if (maxLabelWidth < pair.label.width)
				maxLabelWidth = pair.label.width;
		}

		var y:int = 0;
		for (i = 0; i < pairsList.length; i++)
		{
			pair = pairsList[i];
			pair.label.y = y;
			pair.control.y = y;

			pair.label.x = maxLabelWidth - pair.label.width;
			pair.control.x = maxLabelWidth + horizontalGap;

			y += pair.label.height + verticalGap;
		}
	}

	static public function layoutVerticalCentered(objList:Array, verticalCap:int):void
	{
		var obj:DisplayObject = objList[0];
		var maxWidth:int = obj.width;

		for (var i:int = 1; i < objList.length; i++)
		{
			obj = objList[i];
			if (maxWidth < obj.width)
				maxWidth = obj.width;
		}

		var y:Number = 0;
		for (i = 0; i < objList.length; i++)
		{
			obj = objList[i];
			UDisplay.placeAtOrigin(obj, (maxWidth - obj.width) / 2, y);
			y += obj.height + verticalCap;
		}
	}

	static public function centerIn(width:int, height:int, obj:DisplayObject):void
	{
		UDisplay.placeAtOrigin(obj,
				(width - obj.width) / 2,
				(height - obj.height) / 2);
	}

	static public function centerInParentRectangle(r:Rectangle, obj:DisplayObject):void
	{
		obj.x = 0;
		obj.y = 0;
		var objRect:Rectangle = obj.getBounds(obj.parent);

		obj.x = (r.width - objRect.width) / 2 + r.left;
		obj.y = (r.height - objRect.height) / 2 + r.top;
		obj.x -= objRect.left;
		obj.y -= objRect.top;
	}

	static public function centerVertically(obj:DisplayObject, inHeight:int):void
	{
		var bounds:Rectangle = UDisplay.getScaledBounds(obj);
		obj.y = (inHeight - obj.height) / 2 - bounds.y;
	}

	static public function centerHorizontally(obj:DisplayObject, inWidth:int):void
	{
		var bounds:Rectangle = UDisplay.getScaledBounds(obj);
		obj.x = (inWidth - obj.width) / 2 - bounds.x;
	}
}
}