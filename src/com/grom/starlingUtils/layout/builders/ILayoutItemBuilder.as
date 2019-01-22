/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.layout.builders
{
import starling.display.DisplayObject;

public interface ILayoutItemBuilder
{
	function create(source:XML):DisplayObject;
}
}
