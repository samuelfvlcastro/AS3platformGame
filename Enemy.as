﻿package 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.display.Stage;
	import flash.text.TextField;

	public class Enemy extends Sprite
	{
		private var _LevelGenerator:MovieClip;
		private var _holder:Sprite;
		private var _jBall:bBall;
		private var _txtScore:TextField;

		private var speed:Number;
		private var direction:int;

		public function Enemy():void
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

			speed = 5;
			direction = 1;
			this.graphics.beginFill(0xFF0000,1);
			this.graphics.drawCircle(12.5,12.5,12.5);
		}

		public function destroy()
		{
			addEventListener(Event.ADDED, beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
		}

		private function eFrame(event:Event):void
		{

			this.x +=  speed * direction;

			var pathfinderHolder = Sprite(_holder.getChildByName('pathfinderHolder'));
			for (var i:int=0; i< pathfinderHolder.numChildren; i++)
			{
				var targetMarker:DisplayObject = pathfinderHolder.getChildAt(i);
				if (hitTestObject(targetMarker))
				{
					direction *=  -1;
					this.x +=  speed * direction;
				}
			}
			if (this.hitTestObject(_jBall))
			{
				if (_jBall.mainJumping && _jBall.jumpSpeed > 0)
				{//Mata inimigo

					this.parent.removeChild(this);
					this.removeEventListener(Event.ENTER_FRAME, eFrame);

					_LevelGenerator.score +=  500;
					_txtScore.text = "Score: " + String(_LevelGenerator.score);

				}
				else
				{//jBall morre
					this.removeEventListener(Event.ENTER_FRAME, eFrame);
					_LevelGenerator.resetLvl();

				}
			}
		}
	}
}