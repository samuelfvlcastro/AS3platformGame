/**
Autor: Samuel F. V. Leal de Castro
Número: 1050617
Esta classe gera todos eventos entre o player e as "moedas"
**/
package Elements.Static
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.text.TextField;
	import flash.geom.Point;
	import Elements.Dynamic.Player;
	
	public class Coin extends Sprite
	{
		private var _LevelGenerator:MovieClip;
		private var _jBall:Player;
		private var _txtScore:TextField;

		public function Coin()
		{
			addEventListener(Event.ADDED, beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function beginClass(event:Event):void
		{
			_LevelGenerator = MovieClip(parent.parent.parent);
			_jBall = _LevelGenerator.lvlHolder.getChildByName('playerHolder').getChildByName('Player');
			_txtScore = _LevelGenerator.lvlHolder.getChildByName('textHolder').getChildByName('scoreBoard');

			this.graphics.beginFill(0x000000,0);
			this.graphics.drawRect(0,0,25,25);
			this.graphics.beginFill(0xFFFFFF,1);
			this.graphics.drawCircle(12.5,12.5,2.5);
		}

		public function destroy()
		{
			removeEventListener(Event.ADDED, beginClass);
			removeEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function eFrame(event:Event):void
		{
			if (this != null){
			if(this.hitTestObject(_jBall))
			{
				if (this != null && this.parent != null)
				{
					this.parent.removeChild(this);
				}
				removeEventListener(Event.ENTER_FRAME, eFrame);

				_LevelGenerator.score +=  100;
				_txtScore.text = "Score: " + String(_LevelGenerator.score);
			}
		}
		}
	}
}