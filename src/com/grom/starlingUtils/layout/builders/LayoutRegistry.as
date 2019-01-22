/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.starlingUtils.layout.builders
{
public class LayoutRegistry
{
	private static var _instance:LayoutRegistry;
	private var _tagBuilders:Object = {};

	public function LayoutRegistry()
	{
		registerTagBuilder("image", new ImageBuilder());
		registerTagBuilder("movie", new MovieBuilder());
		registerTagBuilder("button", new ButtonBuilder());
		registerTagBuilder("text", new TextBuilder());
		registerTagBuilder("scale9image", new Image9Builder());
		registerTagBuilder("input", new InputBuilder());
	}

	public function registerTagBuilder(tagName:String, builder:ILayoutItemBuilder):void
	{
		_tagBuilders[tagName] = builder;
	}

	public static function get instance():LayoutRegistry
	{
		if (!_instance)
		{
			_instance = new LayoutRegistry();
		}
		return _instance;
	}

	public function getByTag(tagName:String):ILayoutItemBuilder
	{
		return _tagBuilders[tagName] as ILayoutItemBuilder;
	}
}
}
