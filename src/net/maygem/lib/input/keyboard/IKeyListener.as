package net.maygem.lib.input.keyboard
{
import flash.display.DisplayObject;

public interface IKeyListener
{
	function onKeyDown(keyCode:uint):void
	function onKeyUp(keyCode:uint):void
}
}