/**
 * Created by IntelliJ IDEA.
 * User: Roman Gaikov
 * Date: 16.04.12
 */
package com.grom.ui.radioButtons
{
import flash.display.DisplayObject;

public interface IRadioButton
{
	function set active(value:Boolean):void
	function get active():Boolean;
	function asView():DisplayObject;
}
}
