package net.maygem.lib.ui.layout
{
import flash.display.DisplayObject;
import flash.display.DisplayObject;
import flash.display.Sprite;

import net.maygem.lib.utils.UArray;

public class VerticalLayout extends Sprite implements ILayout
{
	private var _childrenList:Array = [];
	private var _verticalGap:int;

	public function VerticalLayout(verticalGap:int)
	{
		_verticalGap = verticalGap;
	}

	override public function addChild(child:DisplayObject):DisplayObject
	{
		_childrenList.push(child);
		return super.addChild(child);
	}

	override public function removeChild(child:DisplayObject):DisplayObject
	{
		UArray.removeItem(_childrenList, child);
		return super.removeChild(child);
	}

	override public function addChildAt(child:DisplayObject, index:int):DisplayObject
	{
		var obj:DisplayObject = super.addChildAt(child, index);
		if (obj)
			_childrenList.splice(index, 0, [child]);
		return obj;
	}

	public function excludeFromLayout(child:DisplayObject):void
	{
		UArray.removeItem(_childrenList, child);
	}

	//TODO: override removeChildAt

	public function updateLayout():void
	{
		LayoutUtils.layoutVerticalCentered(_childrenList, _verticalGap);
	}
}
}