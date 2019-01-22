package net.maygem.lib.ui.layout.scroll
{
public class VerticalScrollLayout extends HorizontalScrollLayout
{
	public function VerticalScrollLayout(scrollStep : Number, scrollPolicy : IScrollPolicy = null)
	{
		super(scrollStep, scrollPolicy);
	}

	override public function set scrollingPercents(scrollingPercents : Number) : void
	{
		if (!content) return;

		_desiredScroll = -(content.height - height) * scrollingPercents;
		checkScroll();
	}

	override protected function checkScroll():void
	{
		if (!content) return;
		var scrollEnabled:Boolean = height < content.height;
		if (!scrollEnabled)
		{
			_desiredScroll = 0;
			dispatchEvent(new ScrollStateEvent(false, false));
			return;
		}

		var forwardEnabled:Boolean = scrollEnabled;
		var backwardEnabled:Boolean = scrollEnabled;

		if (_desiredScroll <= -(content.height - height))
		{
			_desiredScroll = -(content.height - height);
			forwardEnabled = false;
		}

		if (_desiredScroll >= 0)
		{
			_desiredScroll = 0;
			backwardEnabled = false;
		}

		dispatchEvent(new ScrollStateEvent(forwardEnabled, backwardEnabled));		
	}

	override protected function updateContentPosition(value : Number) : void
	{
		content.y = value;
	}

	override public function get maxScrollRange() : Number
	{
		if (!content) return 0;
		var range:Number = content.height - height;
		return range > 0 ? range : 0;
	}
}
}