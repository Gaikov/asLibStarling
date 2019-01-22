/**
 * Created by IntelliJ IDEA.
 * User: Roman Gaikov
 * Date: 16.04.12
 */
package com.grom.ui.radioButtons
{
import flash.events.Event;

public class RadioGroupEvent extends Event
{
	static public const CHANGED:String = "radioButtonChanged";

	public function RadioGroupEvent(type:String)
	{
		super(type);
	}

	override public function clone():Event
	{
		return new RadioGroupEvent(type);
	}
}
}
