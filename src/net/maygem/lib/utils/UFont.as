package net.maygem.lib.utils
{
import flash.text.Font;

public class UFont
{
	static public function isEmbedded(fontName:String):Boolean
	{
		var list:Array = Font.enumerateFonts(false);
		for (var i:int = 0; i < list.length; ++i)
		{
			var font:Font = list[i];
			if (font.fontName == fontName)
				return true;
		}
		return false;
	}
}
}