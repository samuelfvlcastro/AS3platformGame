/**
Autor: Samuel F. V. Leal de Castro
Número: 1050617
Esta classe gera todos eventos entre o player e o fim do nível
**/
package Elements.Static
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.text.TextField;
	import Elements.Dynamic.Player;

	public class Goal extends Sprite
	{
		private var _LevelGenerator:MovieClip;
		private var _jBall:Player;

		public function Goal()
		{

			addEventListener(Event.ADDED, beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function beginClass(event:Event):void
		{
			_LevelGenerator = MovieClip(parent.parent.parent);
			_jBall = _LevelGenerator.lvlHolder.getChildByName('playerHolder').getChildByName('Player');

			this.graphics.beginFill(0x00FFFF);
			this.graphics.drawRect(0,0,25,25);
		}

		public function destroy()
		{
			removeEventListener(Event.ADDED, beginClass);
			removeEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function eFrame(event:Event):void
		{
			if (this.hitTestObject(_jBall))
			{
				_LevelGenerator.lvlCurrent++;
				//var lastScore:int = _LevelGenerator.mainScore;
				_LevelGenerator.resetLvl(true);
				//_LevelGenerator.mainScore = lastScore;
			}
		}
	}
}