package net.maygem.lib.fx
{
import flash.events.IEventDispatcher;

public interface ITransformEffect extends IEventDispatcher
{
	function get value():Number;

	function isActive():Boolean;
	function setPosition(value:Number):void;
	function forward():void;
	function backward():void;
}
}