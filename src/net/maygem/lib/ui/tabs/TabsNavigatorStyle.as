package net.maygem.lib.ui.tabs
{
import flash.display.Sprite;

public class TabsNavigatorStyle
{
	public function TabsNavigatorStyle() {}

	public var bgClass:Class = Sprite;
	public var tabsSpace:int = 0;
	public var tabsPaddingLeft:int = 5;
	public var tabsPaddingRight:int = 5;
	public var tabTextVerticalOffset:int = 5;
	public var tabTextPaddings:int = 10;

	public var fontFamily:String = "Arial";
	public var fontSize:uint = 12;
	public var fontBold:Boolean = false;

	public var tabActive:Class = Sprite;
	public var tabPassive:Class = Sprite;

	public var textPassiveColor:uint = 0x00000;
	public var textActiveColor:uint = 0xffffff;

	public var contentOffset:int = 20;
}
}