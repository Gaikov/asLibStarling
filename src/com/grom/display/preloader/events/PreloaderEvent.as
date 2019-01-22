/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 25.01.13
 */
package com.grom.display.preloader.events
{
import flash.events.Event;

public class PreloaderEvent extends Event
{
	static public const START_GAME_QUERY:String = "start_game_query_from_preloader";

	public function PreloaderEvent(type:String)
	{
		super(type);
	}

	override public function clone():Event
	{
		return new PreloaderEvent(type);
	}
}
}
