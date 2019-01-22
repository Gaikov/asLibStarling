/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.filters
{
import flash.filters.BitmapFilter;

public class FiltersFactory
{
	private static var _instance:FiltersFactory;

	private var _map:Object = {};

	public function FiltersFactory()
	{
		_map["glow"] = new GlowFilterBuilder();
	}

	public static function get instance():FiltersFactory
	{
		if (!_instance)
		{
			_instance = new FiltersFactory();
		}
		return _instance;
	}

	public function create(xml:XML):BitmapFilter
	{
		var b:IFilterBuilder = _map[xml.name().localName];
		return b.create(xml);
	}
}
}
