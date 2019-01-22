package net.maygem.lib.ui.tabs
{
import flash.display.DisplayObject;
import flash.display.Sprite;

import flash.events.MouseEvent;

import net.maygem.lib.utils.UDisplay;
import net.maygem.lib.utils.UMath;

public class TabsNavigatorView extends Sprite
{
	private var _style:TabsNavigatorStyle;
	private var _contentSkin:DisplayObject;

	private var _tabs:Array = [];
	private var _selectedIndex:int = -1;

	private var _width:int = 100;
	private var _height:int = 300;
	private var _enabled:Boolean = true;

	public function TabsNavigatorView(style:TabsNavigatorStyle)
	{
		super();
		_style = style;

		_contentSkin = new _style.bgClass();
		_contentSkin.addEventListener(MouseEvent.CLICK, onContentClick);
		addChild(_contentSkin);
		updateLayout();
		cacheAsBitmap = true;

		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
	}

	public function get enabled():Boolean
	{
		return _enabled;
	}

	public function set enabled(value:Boolean):void
	{
		_enabled = value;
	}

	public function get selectedIndex():int
	{
		return _selectedIndex;
	}

	public function get numTabs():int
	{
		return _tabs.length;
	}

	public function set selectedIndex(value:int):void
	{
		if (_selectedIndex != value && UMath.inRange(value, 0, _tabs.length - 1))
		{
			var tab:TabView = _tabs[value];
			onTabClick(tab);
		}
	}

	override public function set width(value:Number):void
	{
		if (_width != value)
		{
			_width = value;
			updateLayout();
		}
	}

	override public function get width():Number
	{
		return _width;
	}

	override public function set height(value:Number):void
	{
		if (_height != value)
		{
			_height = value;
			updateLayout();
		}
	}

	public function addTab(label:String):DisplayObject
	{
		var tab:TabView = new TabView(_style, onTabClick);
		tab.selected = _tabs.length == _selectedIndex;
		tab.label = label;
		_tabs.push(tab);
		addChild(tab);
		updateLayout();
		return tab;
	}

	public function getTab(index:int):DisplayObject
	{
		return _tabs[index];
	}

	public function removeTab(tab:Object):void
	{
		var tabView:TabView = tab as TabView;
		if (tabView && contains(tabView))
		{
			for (var i:int = 0; i < _tabs.length; i++)
			{
				if (_tabs[i] == tabView)
				{
					_tabs.splice(i, 1);
					removeChild(tabView);
					updateLayout();
					return;
				}
			}
		}
	}

	public function setTabLabel(tab:Object, label:String):void
	{
		var tabView:TabView = tab as TabView;
		if (tabView && contains(tabView))
		{
			tabView.label = label;
			updateLayout();
		}
	}

	public function enableTab(tab:DisplayObject, enabled:Boolean):void
	{
		var tabView:TabView = TabView(tab);
		if (tabView.parent == this)
			tabView.enabled = enabled;
	}

	public function isEnabledTab(tab:DisplayObject):Boolean
	{
		var tabView:TabView = TabView(tab);
		if (tabView.parent == this)
			return tabView.enabled;
		return false;
	}

	public function isActiveTab(tab:DisplayObject):Boolean
	{
		var tabView:TabView = TabView(tab);
		if (tabView.parent == this)
			return tabView.selected;
		return false;
	}

	private function onContentClick(e:MouseEvent):void
	{
		var res:TabsEvent = new TabsEvent(TabsEvent.CONTENT_CLICK);
		dispatchEvent(res);
	}

	private function updateLayout():void
	{
		var i:int;
		var x:int = _style.tabsPaddingLeft;

		if (_tabs.length)
		{
			var tabWidth:Number = _tabs[i].width;
			var tabsWidth:int = tabWidth * _tabs.length + _style.tabsSpace * (_tabs.length - 1) + _style.tabsPaddingLeft + _style.tabsPaddingRight;
			if (tabsWidth > _width)
				tabWidth = 0;

			for (i = 0; i < _tabs.length; ++i)
			{
				var tab:TabView = _tabs[i];
				tab.x = x;
				tab.actualWidth = tabWidth;
				x += tab.actualWidth + _style.tabsSpace;

				if (i < _selectedIndex || _selectedIndex == -1)
					setChildIndex(tab, i);
				else if (i == _selectedIndex)
					setChildIndex(tab, _tabs.length - 1);
				else
					setChildIndex(tab, 0);
			}
		}

		_contentSkin.width = _width;
		_contentSkin.height = _height - _style.contentOffset;

		var index:int = _selectedIndex >= 0 ? _tabs.length - 1 : _tabs.length;
		setChildIndex(_contentSkin, index);
		UDisplay.placeAtOrigin(_contentSkin, 0, int(_style.contentOffset));
	}

	private function onTabClick(tab:TabView):void
	{
		if (!_enabled) return;

		var curr:TabView;
		if (_selectedIndex >= 0)
			curr = _tabs[_selectedIndex];

		if (curr != tab)
		{
			if (curr)
				curr.selected = false;
			curr = tab;
			curr.selected = true;
			_selectedIndex = getTabIndex(curr);
			updateLayout();

			var e:TabsEvent = new TabsEvent(TabsEvent.SELECTION_CHANGED);
			dispatchEvent(e);
		}
		else
			dispatchEvent(new TabsEvent(TabsEvent.ACTIVE_TAB_CLICK));
	}

	private function getTabIndex(tab:TabView):int
	{
		for (var i:int = 0; i < _tabs.length; ++i)
		{
			if (_tabs[i] == tab)
				return i;
		}
		return -1;
	}

	private function onMouseOver(event:MouseEvent):void
	{
		if (event.target is TabView)
			dispatchEvent(new TabsEvent(TabsEvent.TAB_OVER));
	}

	private function onMouseOut(event:MouseEvent):void
	{
		if (event.target is TabView)
			dispatchEvent(new TabsEvent(TabsEvent.TAB_OUT));
	}
}
}