package net.maygem.lib.scene.culling
{
import net.maygem.lib.utils.UArray;

public class CullManager
{
	static private var _inst:CullManager;

	private var _nodes:Array = [];

	public function CullManager()
	{
	}

	public function get nodesTotal():int
	{
		return _nodes.length;
	}

	public function updateVisibility():int
	{
		var visibleCount:int = 0;
		for each (var node:CullNode in _nodes)
		{
			node.updateVisibility();
			if (node.isVisible)
				visibleCount ++;
		}
		return visibleCount;
	}

	internal function addNode(node:CullNode):void
	{
		_nodes.push(node);
	}

	internal function removeNode(node:CullNode):void
	{
		UArray.removeItem(_nodes, node);
	}

	static public function instance():CullManager
	{
		if (!_inst)
			_inst = new CullManager();
		return _inst;
	}
}
}