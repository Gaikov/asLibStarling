/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 2.3.12
 */
package net.maygem.lib.scene.display
{
import flash.display.DisplayObject;
import flash.events.Event;
import flash.sampler.DeleteObjectSample;

public class AddStagePolicy
{
	static public function init(obj:DisplayObject, addFunc:Function, removeFunc:Function):void
	{
		obj.addEventListener(Event.ADDED_TO_STAGE, function():void
		{
			addFunc();
		});
		
		obj.addEventListener(Event.REMOVED_FROM_STAGE, function():void
		{
			removeFunc();
		})
	}
}
}
