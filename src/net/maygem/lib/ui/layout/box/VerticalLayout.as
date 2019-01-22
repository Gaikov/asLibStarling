package net.maygem.lib.ui.layout.box
{
import net.maygem.lib.ui.layout.*;

import flash.display.DisplayObject;

import net.maygem.lib.ui.layout.builder.ILayoutBuilder;
import net.maygem.lib.utils.UDisplay;

public class VerticalLayout extends BaseLayout
{
	static public const ALIGN_LEFT : String = "left";
	static public const ALIGN_CENTER : String = "center";
	static public const ALIGN_RIGHT : String = "right";

	private var _verticalGap : int;
	private var _align : String;
	private var _alignFunc : Object = {};
	private var _border : Boolean;

	public function VerticalLayout(verticalGap : int)
	{
		_verticalGap = verticalGap;
		_alignFunc[ALIGN_LEFT] = alignLeft;
		_alignFunc[ALIGN_CENTER] = alignCenter;
		_alignFunc[ALIGN_RIGHT] = alignRight;
	}

	override public function updateFromXML(meta : XML) : void
	{
		super.updateFromXML(meta);
		_align = meta.@align;
		_border = meta.@border == "true";
	}

	public function set align(value : String) : void
	{
		_align = value;
	}

	override public function updateLayout() : void
	{
		super.updateLayout();
		if (!numChildren) return;

		var obj : DisplayObject = getChildAt(0);
		var maxWidth : int = obj.width;

		for (var i : int = 1; i < numChildren; i++)
		{
			obj = getChildAt(i);
			if (maxWidth < obj.width)
				maxWidth = obj.width;
		}

		var alignFunc : Function = _alignFunc[_align];
		if (alignFunc == null) alignFunc = alignCenter;

		var posY : Number = 0;
		for (i = 0; i < numChildren; i++)
		{
			obj = getChildAt(i);
			if (!isExcludedFromLayout(obj))
			{
				alignFunc(obj, maxWidth, posY);
				posY += obj.height + _verticalGap;
			}
		}

		if (_border)
		{
			graphics.clear();
			graphics.lineStyle(1, 0);
			graphics.drawRect(0, 0, width, height);
		}
	}

	private function alignLeft(obj : DisplayObject, maxWidth : int, posY : Number) : void
	{
		UDisplay.placeAtOrigin(obj, 0, posY);
	}

	private function alignCenter(obj : DisplayObject, maxWidth : int, posY : Number) : void
	{
		UDisplay.placeAtOrigin(obj, (maxWidth - obj.width) / 2, posY);
	}

	private function alignRight(obj : DisplayObject, maxWidth : int, posY : Number) : void
	{
		UDisplay.placeAtOrigin(obj, maxWidth - obj.width, posY);
	}

	static public function builder() : ILayoutBuilder
	{
		return new VerticalBuilder();
	}
}
}

import net.maygem.lib.ui.layout.BaseLayout;
import net.maygem.lib.ui.layout.box.VerticalLayout;
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;

class VerticalBuilder implements ILayoutBuilder
{
	public function createLayout(node : XML) : BaseLayout
	{
		var res : BaseLayout = new VerticalLayout(node.@gap);
		res.updateFromXML(node);
		return res;
	}
}