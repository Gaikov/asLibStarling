package net.maygem.lib.ui.layout.box
{
import net.maygem.lib.ui.layout.*;

import flash.display.DisplayObject;

import net.maygem.lib.ui.layout.builder.ILayoutBuilder;
import net.maygem.lib.utils.UDisplay;

public class HorizontalLayout extends BaseLayout
{
	static public const ALIGN_TOP:String = "top";
	static public const ALIGN_CENTER:String = "center";
	static public const ALIGN_BOTTOM:String = "bottom";

	private var _horizontalGap:int;
	private var _align:String;
	private var _border:Boolean;
	private var _alignFunc:Object = {};

	public function HorizontalLayout(horizontalGap:int)
	{
		super();
		_horizontalGap = horizontalGap;
		_alignFunc[ALIGN_TOP] = alignTop;
		_alignFunc[ALIGN_CENTER] = alignCenter;
		_alignFunc[ALIGN_BOTTOM] = alignBottom;
	}

	override public function updateFromXML(meta : XML) : void
	{
		super.updateFromXML(meta);
		_align = meta.@align;
		_border = meta.@border == "true";
	}

	override public function updateLayout():void
	{
		super.updateLayout();
		if (!numChildren) return;

		var obj:DisplayObject = getChildAt(0);
		var maxHeight:int = obj.height;

		for (var i:int = 1; i < numChildren; i++)
		{
			obj = getChildAt(i);
			if (maxHeight < obj.height)
				maxHeight = obj.height;
		}

		var alignFunc : Function = _alignFunc[_align];
		if (alignFunc == null) alignFunc = alignCenter;

		var x:Number = 0;
		for (i = 0; i < numChildren; i++)
		{
			obj = getChildAt(i);
			alignFunc(obj, x, maxHeight);
			x += obj.width + _horizontalGap;
		}

		if (_border)
		{
			graphics.clear();
			graphics.lineStyle(1, 0);
			graphics.drawRect(0, 0, width, height);
		}
	}

	private function alignTop(obj : DisplayObject, x : Number, maxHeight : int) : void
	{
		UDisplay.placeAtOrigin(obj, x, 0);
	}

	private function alignCenter(obj : DisplayObject, x : Number, maxHeight : int) : void
	{
		UDisplay.placeAtOrigin(obj, x, (maxHeight - obj.height) / 2);
	}

	private function alignBottom(obj : DisplayObject, x : Number, maxHeight : int) : void
	{
		UDisplay.placeAtOrigin(obj, x, maxHeight - obj.height);
	}

	static public function builder():ILayoutBuilder
	{
		return new HorizontalBuilder();
	}
}
}

import net.maygem.lib.ui.layout.BaseLayout;
import net.maygem.lib.ui.layout.box.HorizontalLayout;
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;

class HorizontalBuilder implements ILayoutBuilder
{
	public function createLayout(node : XML) : BaseLayout
	{
		var res:BaseLayout = new HorizontalLayout(node.@gap);
		res.updateFromXML(node);
		return res;
	}
}