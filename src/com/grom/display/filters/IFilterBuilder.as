/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.filters
{
import flash.filters.BitmapFilter;

public interface IFilterBuilder
{
	function create(xml:XML):BitmapFilter;
}
}
