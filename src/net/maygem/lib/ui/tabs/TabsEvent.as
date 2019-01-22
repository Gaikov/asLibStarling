package net.maygem.lib.ui.tabs
{
import flash.events.Event;

public class TabsEvent extends Event
{
	static public const SELECTION_CHANGED:String = "selectionChanged";
	static public const CONTENT_CLICK:String = "contentClick";
	static public const ACTIVE_TAB_CLICK:String = "activeTabClick";
	static public const TAB_OVER:String = "tabOver";
	static public const TAB_OUT:String = "tabOut";

	public function TabsEvent(type:String)
	{
		super(type);
	}

	override public function clone():Event
	{
		return new TabsEvent(type);
	}
}
}