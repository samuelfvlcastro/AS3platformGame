package 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.text.TextField;

	public class Goal extends Sprite
	{
		private var _LevelGenerator:MovieClip;
		private var _holder:Sprite;
		private var _jBall:bBall;
		private var _txtScore:TextField;

		public function Goal()
		{

			addEventListener(Event.ADDED, beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function beginClass(event:Event):void
		{
			_LevelGenerator = MovieClip(parent.parent.parent);
			_holder = Sprite(_LevelGenerator.lvlHolder);
			_jBall = _LevelGenerator.lvlHolder.getChildByName('playerHolder').getChildByName('bBall');
			_txtScore = _LevelGenerator.lvlHolder.getChildByName('textHolder').getChildByName('scoreBoard');

			this.graphics.beginFill(0x00FFFF);
			this.graphics.drawRect(0,0,25,25);
		}

		public function destroy()
		{
			addEventListener(Event.ADDED, beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function eFrame(event:Event):void
		{
			if (hitTestObject(_jBall))
			{
				_LevelGenerator.lvlCurrent++;
				var lastScore:int = _LevelGenerator.mainScore;
				_LevelGenerator.resetLvl();
				_LevelGenerator.mainScore = lastScore;
			}
		}
	}
}