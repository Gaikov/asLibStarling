package net.maygem.lib.utils
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.geom.Rectangle;

import net.maygem.lib.ui.layout.alignment.Alignments;

import net.maygem.lib.ui.layout.alignment.IAlignment;

public class UContainer
{
	static public function removeAllChildren(c:DisplayObjectContainer):void
	{
		for (var i:int = c.numChildren - 1; i >= 0; i--)
			c.removeChildAt(i);
	}

	static public function removeChildren(c:DisplayObjectContainer, list:Array):void
	{
		for (var i:int = 0; i < list.length; i++)
			c.removeChild(list[i]);
	}

	static public function safeAdd(c:DisplayObjectContainer, child:DisplayObject):void
	{
		if (c != child.parent)
			c.addChild(child);
	}

	static public function safeAddAt(c:DisplayObjectContainer, child:DisplayObject, level : int):void
	{
		if (c != child.parent)
			c.addChildAt(child, level);
	}

	static public function safeRemove(c:DisplayObjectContainer, child:DisplayObject):void
	{
		if (c && c == child.parent)
			c.removeChild(child);
	}

	static public function updatePresence(c:DisplayObjectContainer, child:DisplayObject, add:Boolean):void
	{
		if (add)
			safeAdd(c, child);
		else
			safeRemove(c, child);
	}
	
	static public function getChildrenList(c:DisplayObjectContainer):Array
	{
		var res:Array = [];
		for (var i:int = 0; i < c.numChildren; i++)
			res.push(c.getChildAt(i));
		return res;
	}
	
	static public function replaceChild(currentChild:DisplayObject, newChild:DisplayObject, halign:String, valign:String):void
	{
		var parent:DisplayObjectContainer = currentChild.parent;
		var index:int = parent.getChildIndex(currentChild);

		var bounds:Rectangle = currentChild.getBounds(parent);
		parent.removeChild(currentChild);
		parent.addChildAt(newChild, index);

		var hpolicy:IAlignment = Alignments.policy(halign);
		var vpolicy:IAlignment = Alignments.policy(valign);

		UDisplay.placeAtOrigin(newChild,
			bounds.left + hpolicy.align(newChild.width, currentChild.width),
			bounds.top + vpolicy.align(newChild.height, currentChild.height));
	}

	static public function removeWithPos(child:DisplayObject, newChild:DisplayObject):void
	{
		var parent:DisplayObjectContainer = child.parent;
		parent.removeChild(child);
		UDisplay.copyPos(child, newChild);
	}

	static public function removeChildrenWithPrefix(c:DisplayObjectContainer, prefix:String):void
	{
		var list:Array = [];

		for (var i:int = 0; i < c.numChildren; i++)
		{
			var child:DisplayObject = c.getChildAt(i);
			if (child.name.indexOf(prefix) == 0)
			{
				list.push(child);
			}
		}

		for each (child in list)
		{
			c.removeChild(child);
		}
	}
}
}