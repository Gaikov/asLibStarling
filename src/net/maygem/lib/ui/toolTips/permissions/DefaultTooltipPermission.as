package net.maygem.lib.ui.toolTips.permissions
{
public class DefaultTooltipPermission implements ITooltipPermission
{
	public function DefaultTooltipPermission()
	{
	}

	public function canDisplay():Boolean
	{
		return true;
	}
}
}