/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.07.12
 */
package com.ns.menu.events
{
import starling.events.Event;

public class PopupEvent extends Event
{
	public static const DISPLAYED:String = "popup_displayed";
	public static const DISAPPEARED:String = "popup_disappeared";

	public function PopupEvent(type:String)
	{
		super(type);
	}
}
}
