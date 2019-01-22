package net.maygem.lib.ui.layout.controls
{
import flash.display.DisplayObject;

import net.maygem.lib.ui.layout.BaseLayout;
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;
import net.maygem.lib.utils.UDisplay;

public class CanvasLayout extends BaseLayout
{
	private var _origin : DisplayObject = UDisplay.createAlphaShape(1, 1);

	public function CanvasLayout(source : XML)
	{
		super();
		addChild(_origin);
		updateFromXML(source);
	}

	static public function builder() : ILayoutBuilder
	{
		return new CanvasBuilder();
	}
}
}

import net.maygem.lib.ui.layout.BaseLayout;
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;
import net.maygem.lib.ui.layout.controls.CanvasLayout;

class CanvasBuilder implements ILayoutBuilder
{
	public function createLayout(node : XML) : BaseLayout
	{
		return new CanvasLayout(node);
	}
}