/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 16.11.12
 * Time: 12:58
 * To change this template use File | Settings | File Templates.
 */
package net.maygem.lib.scene.transition
{
import starling.display.DisplayObject;

public interface IScenePlacer
{
	function removeOldScene():void
	function addNewScene():void

	function get newScene():DisplayObject;

	function onTransitionCompleted():void;
}
}
