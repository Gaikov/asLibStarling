/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 29.03.12
 */
package com.grom.display.preloader
{
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

public interface IPreloaderView extends IEventDispatcher
{
	function asView():DisplayObject;
	function set percent(value:Number):void
	function onCompleted():void
}
}
