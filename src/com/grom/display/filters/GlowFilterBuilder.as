/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 04.09.12
 */
package com.grom.display.filters
{
import flash.filters.BitmapFilter;
import flash.filters.GlowFilter;

public class GlowFilterBuilder implements IFilterBuilder
{
	public function create(xml:XML):BitmapFilter
	{
		var color:uint = xml.@color;
		var alpha:Number = xml.@alpha;
		var blurX:Number = xml.@blur_x;
		var blurY:Number = xml.@blur_y;
		var strength:int = xml.@strength;
		var quality:int = xml.@quality;

		return new GlowFilter(color, alpha, blurX, blurY, strength, quality);
	}
}
}
