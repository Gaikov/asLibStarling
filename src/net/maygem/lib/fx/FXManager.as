package net.maygem.lib.fx
{
import net.maygem.lib.utils.UArray;

public class FXManager
{
	static private var _inst:FXManager;

	private var _fxList:Array = [];
	private var _removed:Array = [];

	public function FXManager()
	{
	}

	static public function instance():FXManager
	{
		if (!_inst)
			_inst = new FXManager();
		return _inst;
	}

	internal function addEffect(fx:TransformEffect):void
	{
		_fxList.push(fx);
	}

	internal function removeEffect(fx:TransformEffect):void
	{
		_removed.push(fx);
	}

	public function loopEffects():void
	{
		for each(var item:Object in _removed)
			UArray.removeItem(_fxList, item);

		var i:int = 0;
		var arrLength:int = _fxList.length;

		for (i; i < arrLength; ++i)
		{
			var fx:TransformEffect = _fxList[i];
			fx.step();
		}
	}
}
}