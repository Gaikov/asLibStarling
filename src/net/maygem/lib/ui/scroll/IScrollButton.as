package net.maygem.lib.ui.scroll
{
import flash.events.IEventDispatcher;

public interface IScrollButton extends IEventDispatcher
{
	function set enabled(value:Boolean):void;
	function get enabled() : Boolean;
}
}