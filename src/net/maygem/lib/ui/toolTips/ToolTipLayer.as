package net.maygem.lib.ui.toolTips
{
import flash.display.Sprite;

public class ToolTipLayer extends Sprite
{
	private static var instance:ToolTipLayer;

	function ToolTipLayer()
	{
		mouseEnabled = false;
		mouseChildren = false;
	}

	public static function getInstance():ToolTipLayer
	{
		if (instance == null)
			instance = new ToolTipLayer();
		return instance;
	}
}
}