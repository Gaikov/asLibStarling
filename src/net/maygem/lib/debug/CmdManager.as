package net.maygem.lib.debug
{

public class CmdManager
{
	static private var _inst:CmdManager;

	private var _cmdHash:Object = {};
	private var _keyCommandsMap:Object = {};    //map[keyCode] -> Array of Strings

	public function CmdManager()
	{
		register("cmd_test", cmdTest);
		register("help", cmdHelp);
	}

	static public function instance():CmdManager
	{
		if (!_inst)
			_inst = new CmdManager();
		return _inst;
	}

	public function register(cmdName:String, func:Function):void
	{
		_cmdHash[cmdName] = func;
	}

	public function bindCommand(keyCode:int, command:String):void
	{
		var list:Array = _keyCommandsMap[keyCode] as Array;
		if (!list) list = [];

		if (list.indexOf(command) < 0)
		{
			list.push(command);
			_keyCommandsMap[keyCode] = list;
		}
	}

	public function execCommandsForKey(keyCode:int):void
	{
		var list:Array = _keyCommandsMap[keyCode] as Array;
		if (!list) return;

		for each (var cmd:String in list)
			exec(cmd);
	}

	public function exec(line:String):void
	{
		if (!line) return;

		Log.print(">> " + line, 0x00ff00);

		var params:Array = line.match(/\S+/g);
		if (params.length)
		{
			var name:String = String(params.shift());
			if (_cmdHash[name])
			{
				var func:Function = _cmdHash[name];
				func(params);
			}
			else
				Log.warning(name + " - command not found!");
		}
	}

	public function autoComplete(line:String):String
	{
		var res:Array = [];
		var resName:String;
		for (var name:String in _cmdHash)
		{
			if (name.indexOf(line) == 0)
				res.push(name);

			if (name == line)
				resName = name;
		}

		if (res.length == 1)
			resName = res[0];
		else
		{
			for each(var i:String in res)
				Log.info(i);
		}

		return resName;
	}

	private function cmdTest(params:Array):void
	{
		Log.info("cmd_test");
		Log.info("params:");
		for (var i:int = 0; i < params.length; ++i)
			Log.info(params[i]);
	}

	private function cmdHelp(params:Array):void
	{
		Log.info("=== console commands ===");
		for (var name:String in _cmdHash)
			Log.info(name);
	}

}
}