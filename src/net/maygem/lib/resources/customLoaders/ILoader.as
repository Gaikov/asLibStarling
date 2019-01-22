package net.maygem.lib.resources.customLoaders
{
import flash.events.IEventDispatcher;

public interface ILoader extends IEventDispatcher
{
	function get progress():Number;
	function get loadedContent():*;

	function load():void;
}
}