/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 10.06.13
 */
package com.grom.starlingUtils.display
{
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

public class ContainerUtils
{
	static public function safeAdd(c:DisplayObjectContainer, child:DisplayObject):void
	{
		if (c != child.parent)
			c.addChild(child);
	}

	static public function safeRemove(c:DisplayObjectContainer, child:DisplayObject):void
	{
		if (c && c == child.parent)
			c.removeChild(child);
	}

}
}
