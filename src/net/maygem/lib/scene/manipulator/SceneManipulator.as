package net.maygem.lib.scene.manipulator
{
import net.maygem.lib.debug.CmdManager;
import net.maygem.lib.debug.Log;

public class SceneManipulator extends DisplayObjectManipulator
{
	static private var _inst:SceneManipulator;

	public function SceneManipulator()
	{
		super("root", null);
		CmdManager.instance().register("show_tree", cmdShowTree);
	}

	static public function instance():SceneManipulator
	{
		if (!_inst)
			_inst = new SceneManipulator();
		return _inst;
	}

	public function setObjectProperty(fullPath:String, propName:String, value:Object, cascade:Boolean):void
	{
		var m:DisplayObjectManipulator = getChildByPath(fullPath);
		if (m)
			m.setProperty(propName, value, cascade);
	}

	private function cmdShowTree(args:Array):void
	{
		showNames(this);
	}

	private function showNames(m:DisplayObjectManipulator):void
	{
		Log.info(m.fullName);

		for each (var child:DisplayObjectManipulator in m.children)
			showNames(child);
	}
}
}