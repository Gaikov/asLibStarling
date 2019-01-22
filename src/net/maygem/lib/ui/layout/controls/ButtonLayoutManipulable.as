package net.maygem.lib.ui.layout.controls
{
import net.maygem.lib.scene.manipulator.DisplayObjectManipulator;
import net.maygem.lib.scene.manipulator.IManipulableObject;
import net.maygem.lib.scene.manipulator.IPropertySetter;
import net.maygem.lib.scene.manipulator.ManipulableObjectPolicy;
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;

public class ButtonLayoutManipulable extends ButtonLayout implements IManipulableObject, IPropertySetter
{
	private var _policy:ManipulableObjectPolicy;
	private var _enabled:Boolean = true;
	private var _enabledByManipulator:Boolean = true;

	public function ButtonLayoutManipulable(source:XML)
	{
		super(source);
	}

	override public function set enabled(value:Boolean):void
	{
		_enabled = value;
		updateEnabling();
	}

	override public function set name(value:String):void
	{
		super.name = value;
		if (_policy)
			_policy.destroy();
		//_policy = new ManipulableObjectPolicy(value, this);
		_policy.manipulator.setPropertySetter("enabled", this);
	}

	public function setProperty(name:String, value:Object):void
	{
		if (name == "enabled")
		{
			_enabledByManipulator = value == "true";
			updateEnabling();
		}
	}

	private function updateEnabling():void
	{
		super.enabled = _enabled && _enabledByManipulator;
	}

	public function get manipulator() : DisplayObjectManipulator
	{
		return _policy ? _policy.manipulator : null;
	}

	static public function builder():ILayoutBuilder
	{
		return new LayoutBuilder(); 		
	}
}
}

import net.maygem.lib.ui.layout.BaseLayout;
import net.maygem.lib.ui.layout.builder.ILayoutBuilder;
import net.maygem.lib.ui.layout.controls.ButtonLayoutManipulable;

class LayoutBuilder implements ILayoutBuilder
{
	public function createLayout(node : XML) : BaseLayout
	{
		return new ButtonLayoutManipulable(node);
	}
}