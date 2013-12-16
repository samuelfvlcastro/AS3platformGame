/**
Autor: Samuel F. V. Leal de Castro
Número: 1050617
**/
package Elements.Static
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;

	public class Block extends Sprite
	{
		private var _root:Object;

		public function Block()
		{
			addEventListener(Event.ADDED, beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function beginClass(event:Event):void
		{
			_root = MovieClip(root);
		}

		public function destroy()
		{
			removeEventListener(Event.ADDED, beginClass);
			removeEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function eFrame(event:Event):void
		{

		}
	}
}