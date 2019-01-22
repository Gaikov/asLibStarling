package net.maygem.lib.ui.layout.scroll
{
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

import net.maygem.lib.ui.layout.ILayout;

public interface IScrollLayout extends IEventDispatcher, ILayout
{
	function set scrollPolicy(policy : IScrollPolicy) : void

	function set content(content : DisplayObject) : void

	function get maxScrollRange() : Number

	function set width(value : Number) : void

	function set height(value : Number) : void

	function set scrollingPercents(value : Number) : void

	function scrollForward() : void

	function scrollBackward() : void

	function set scrollStep(scrollStep : Number) : void;

    function updateScrollState():void;
}
}
