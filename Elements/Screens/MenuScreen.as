/**
Autor: Samuel F. V. Leal de Castro
Número: 1050617
Esta classe gera o menu principal
**/
package Elements.Screens
{
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;

	public class MenuScreen extends MovieClip
	{
		var selection:Number = 0;

		public function MenuScreen()
		{
			addEventListener(Event.ADDED, beginClass);
		}

		private function beginClass(event:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
		}
		public function addButton(lable:String, divH:int, isPressed:Boolean = false)
		{

			var textForm:TextFormat = new TextFormat('Verdana',22,0xDEDEDE);
			textForm.align = TextFormatAlign.CENTER;

			var menuButton:TextField = new TextField();
			menuButton.defaultTextFormat = textForm;
			menuButton.text = lable;
			menuButton.name = this.numChildren.toString();

			menuButton.border = true;
			menuButton.borderColor = 0xFFFFF;
			menuButton.x = 175;
			menuButton.y = stage.height / 2 + divH;

			menuButton.width = 200;
			menuButton.height = 35;

			menuButton.selectable = false;
			menuButton.background = isPressed;

			addChild(menuButton);
		}

		function keyPressedDown(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
			switch (key)
			{
				case 87 ://W KEY
				case 38 ://UP KEY
					if (selection > 0 )
					{
						selection--;
					}
					break;
				case 83 ://S KEY
				case 40 ://DOWN KEY
					if (selection < 1)
					{
						selection++;
					}
					break;
				case 13 :
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
					switch (selection)
					{
						case 0 :
							MovieClip(parent).gotoAndPlay(2);
							MovieClip(parent).removeChild(this);
							break;
						case 1 :
							MovieClip(parent).gotoAndPlay(3);
							MovieClip(parent).removeChild(this);
							break;
					}
					break;
			}

			for (var i:int = 0; i < this.numChildren; i++)
			{
				TextField(this.getChildByName(i.toString())).background = false;
			}
			TextField(getChildByName(selection.toString())).background = true;
		}
	}
}