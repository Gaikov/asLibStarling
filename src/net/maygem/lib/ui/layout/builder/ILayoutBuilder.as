package net.maygem.lib.ui.layout.builder
{
import net.maygem.lib.ui.layout.BaseLayout;

public interface ILayoutBuilder
{
	function createLayout(node:XML):BaseLayout;
}
}