/**
Autor: Samuel F. V. Leal de Castro
Número: 1050617
Esta classe gera o Scoreboard
**/
package Elements.Screens
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;

	public class Scoreboard extends MovieClip
	{
		var selection:Number = 0;

		public function Scoreboard()
		{
			addEventListener(Event.ADDED, beginClass);
		}

		private function beginClass(event:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown2);
		}
		public function addScore(lable:String, divH:int)
		{

			var textForm:TextFormat = new TextFormat('Verdana',22,0xDEDEDE);
			textForm.align = TextFormatAlign.CENTER;

			var scoreText:TextField = new TextField();
			scoreText.defaultTextFormat = textForm;
			scoreText.text = lable;
			scoreText.name = this.numChildren.toString();

			scoreText.x = 175;
			scoreText.y = stage.height / 2 + divH;

			scoreText.width = 200;
			scoreText.height = 35;

			scoreText.selectable = false;

			addChild(scoreText);
		}

		function keyPressedDown2(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
			trace(key);
			if (key == 13)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown2);
				MovieClip(parent).gotoAndPlay(1);
				MovieClip(parent).removeChild(this);
			}
		}
	}
}