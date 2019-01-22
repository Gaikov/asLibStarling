package net.maygem.lib.ui.layout
{
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;
import net.maygem.lib.ui.layout.builder.LayoutManager;

public class ReferenceLayoutBuilder implements ILayoutBuilder
{
	public function createLayout(node : XML) : BaseLayout
	{
		var layout:BaseLayout = LayoutManager.instance().createLayout(node.@layout_id);
		if (layout) layout.updateFromXML(node);
		return layout;
	}
}
}