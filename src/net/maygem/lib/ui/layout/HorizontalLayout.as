package net.maygem.lib.ui.layout
{
import flash.display.DisplayObject;

import net.maygem.lib.utils.UDisplay;

public class HorizontalLayout extends BaseLayout
{
	private var _horizontalGap:int;

	public function HorizontalLayout(horizontalGap:int)
	{
		super();
		_horizontalGap = horizontalGap;
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

		var x:Number = 0;
		for (i = 0; i < numChildren; i++)
		{
			obj = getChildAt(i);
			UDisplay.placeAtOrigin(obj, x, (maxHeight - obj.height) / 2);
			x += obj.width + _horizontalGap;
		}
	}
}
}