package net.maygem.lib.ui.layout.alignment
{
import flash.display.DisplayObject;
import flash.geom.Rectangle;

import net.maygem.lib.utils.UDisplay;

public class Alignments
{
	static public const LEFT : String = "left";
	static public const CENTER : String = "center";
	static public const RIGHT : String = "right";
	static public const TOP : String = "top";
	static public const MIDDLE : String = "middle";
	static public const BOTTOM : String = "bottom";

	static public function policy(name : String) : IAlignment
	{
		var map : Object = {};
		map[LEFT] = map[TOP] = new AlignBegin();
		map[CENTER] = map[MIDDLE] = new AlignCenter();
		map[RIGHT] = map[BOTTOM] = new AlignEnd();

		var r : IAlignment = map[name] as IAlignment;
		if (!r) r = map[CENTER];
		return r;
	}

	static public function isHorizontal(align:String):Boolean
	{
		return [LEFT, CENTER, RIGHT].indexOf(align) >= 0;
	}

	static public function alignInRect(obj:DisplayObject, rect:Rectangle, halign:String, valign:String):void
	{
		var hpolicy:IAlignment = Alignments.policy(halign);
		var vpolicy:IAlignment = Alignments.policy(valign);

		UDisplay.placeAtOrigin(obj,
			rect.left + hpolicy.align(obj.width, rect.width),
			rect.top + vpolicy.align(obj.height, rect.height));
	}
}
}

import net.maygem.lib.ui.layout.alignment.IAlignment;

class AlignBegin implements IAlignment
{
	public function align(objectSize : Number, boundingSize : Number) : Number
	{
		return 0;
	}
}

class AlignCenter implements IAlignment
{
	public function align(objectSize : Number, boundingSize : Number) : Number
	{
		return (boundingSize - objectSize) / 2;
	}
}

class AlignEnd implements IAlignment
{
	public function align(objectSize : Number, boundingSize : Number) : Number
	{
		return boundingSize - objectSize;
	}
}
