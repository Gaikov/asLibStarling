/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.06.12
 */
package net.maygem.lib.scene.frameListener
{
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.Dictionary;

public class EnterFrameManager
{
	private static var _instance:EnterFrameManager;

	private var _sprite:Sprite;
	private var _listeners:Dictionary = new Dictionary();

	public function EnterFrameManager()
	{
		_sprite = new Sprite();
		_sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	public static function get instance():EnterFrameManager
	{
		if (!_instance)
		{
			_instance = new EnterFrameManager();
		}
		return _instance;
	}

	public function addListener(l:IFrameListener):void
	{
		_listeners[l] = l;
	}

	public function removeListener(l:IFrameListener):void
	{
		delete _listeners[l];
	}

	private function onEnterFrame(event:Event):void
	{
		for each (var l:IFrameListener in _listeners)
		{
			l.onEnterFrame();
		}
	}
}
}
