/**
Autor: Samuel F. V. Leal de Castro
Número: 1050617
Esta classe gera o input de score name
**/
package Elements.Screens
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.Sprite;
	import flash.events.*;

	import Elements.Saves;


	public class ScoreInput extends MovieClip
	{

		var inputField:TextField;

		public function ScoreInput()
		{
			addEventListener(Event.ADDED, beginClass);
		}

		private function beginClass(event:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown3);
		}

		public function addInput()
		{
			var textForm:TextFormat = new TextFormat('Verdana',22,0xDEDEDE);
			textForm.align = TextFormatAlign.CENTER;

			inputField = new TextField();
			inputField.defaultTextFormat = textForm;
			addChild(inputField);

			inputField.border = true;
			inputField.border = true;
			inputField.borderColor = 0x97040C;
			inputField.maxChars = 3;
			inputField.width = 200;
			inputField.height = 35;
			inputField.x = 175;
			inputField.y = stage.height / 2;
			inputField.type = "input";
			inputField.multiline = false;

			stage.focus = inputField;
		}
		function keyPressedDown3(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
			if (key == 13 || key == 32)
			{
				Saves.saveHighScore(Saves.getTmpScore(), inputField.text);
				stage.focus = stage;
				MovieClip(parent).gotoAndPlay(3);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown3);
				MovieClip(parent).removeChild(this);

			}
		}
	}
}