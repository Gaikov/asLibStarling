package net.maygem.lib.ui.layout.scroll
{
import flash.events.Event;

public class ScrollStateEvent extends Event
{
	static public const SCROLL_STATE_CHANGED:String = "scrollStateChanged";

	public var forwardScrollEnabled:Boolean;
	public var backwardScrollEnabled:Boolean;

	public function ScrollStateEvent(forwardScroll:Boolean, backwardScroll:Boolean)
	{
		super(SCROLL_STATE_CHANGED);
		forwardScrollEnabled = forwardScroll;
		backwardScrollEnabled = backwardScroll;
	}

	override public function clone() : Event
	{
		return new ScrollStateEvent(forwardScrollEnabled, backwardScrollEnabled);
	}
}
}