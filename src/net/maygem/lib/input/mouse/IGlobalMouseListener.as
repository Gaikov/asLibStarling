/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 25.1.12
 */
package net.maygem.lib.input.mouse
{
import flash.display.DisplayObject;

public interface IGlobalMouseListener
{
	function asDisplayObject():DisplayObject

	function onMouseDown(stageX:int, stageY:int):void

	function onMouseWheel(delta:int):void;

	function onMouseMove(stageX:Number, stageY:Number):void;
}
}
