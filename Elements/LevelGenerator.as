﻿/**
Autor: Samuel F. V. Leal de Castro
Número: 1050617
Esta classe garante a geração de níveis
**/
package Elements
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.*;

	import Elements.Static.*;
	import Elements.Dynamic.*;

	public class LevelGenerator extends MovieClip
	{
		public var score:int = 0;

		private var dtextFormat:TextFormat = new TextFormat('Impact',20,0x2F7840);
		
		public var lvlHolder:Sprite;
		private var row:int = 0;
		private var newPlacement;

		private var lvlArray:Array;
		private var lvlColumns:int;

		//Holder para o fundo de ecra
		var bgHolder:Sprite = new Sprite();
		//Holder para o player
		var playerHolder:Sprite = new Sprite();
		//Holder para texts
		var textHolder:Sprite = new Sprite();
		//Holder para os trampolins;
		var trampHolder:Sprite = new Sprite();
		//Holder para os blocos;
		var blockHolder:Sprite = new Sprite();
		//Holder para as escadas;
		var ladderHolder:Sprite = new Sprite();
		//Holder para os bumpers;
		var bumperHolder:Sprite = new Sprite();
		//Holder para as coins;
		var coinHolder:Sprite = new Sprite();
		//Holder para os Inimigos;
		var enemyHolder:Sprite = new Sprite();
		//Holder para os pathfinders ;
		var pathfinderHolder:Sprite = new Sprite();

		public function LevelGenerator(lvlHolder:Sprite, lvlArray:Array, lvlColumns:int)
		{
			this.lvlHolder = lvlHolder;
			addChild(this.lvlHolder);

			this.lvlArray = lvlArray;
			this.lvlColumns = lvlColumns;

			addEventListener(Event.ADDED, beginClass);
		}

		private function beginClass(event:Event):void
		{
			bgHolder.name = 'bgHolder';
			this.lvlHolder.addChild(bgHolder);

			playerHolder.name = 'playerHolder';
			this.lvlHolder.addChild(playerHolder);

			textHolder.name = 'textHolder';
			this.lvlHolder.addChild(textHolder);

			trampHolder.name = 'trampHolder';
			this.lvlHolder.addChild(trampHolder);

			blockHolder.name = 'blockHolder';
			this.lvlHolder.addChild(blockHolder);

			ladderHolder.name = 'ladderHolder';
			this.lvlHolder.addChild(ladderHolder);

			bumperHolder.name = 'bumperHolder';
			this.lvlHolder.addChild(bumperHolder);

			coinHolder.name = 'coinHolder';
			this.lvlHolder.addChild(coinHolder);

			enemyHolder.name = 'enemyHolder';
			this.lvlHolder.addChild(enemyHolder);

			pathfinderHolder.name = 'pathfinderHolder';
			this.lvlHolder.addChild(pathfinderHolder);

		}

		public function addBlock(holder:Sprite):void
		{
			newPlacement = new Block();
			newPlacement.graphics.beginFill(0xFFFFFF,1);
			newPlacement.graphics.drawRect(0,0,25,25);
			holder.addChild(newPlacement);
		}

		public function addPlayer(holder:Sprite):void
		{
			newPlacement = new Player();
			newPlacement.name = 'Player';
			holder.addChild(newPlacement);
		}

		public function addLadder(holder:Sprite):void
		{
			newPlacement = new Sprite();
			newPlacement.graphics.beginFill(0xFFFF00,1);
			newPlacement.graphics.drawRect(0,0,25,25);
			holder.addChild(newPlacement);
		}

		public function addBumper(holder:Sprite):void
		{
			newPlacement = new Sprite();
			newPlacement.graphics.beginFill(0x00FF00,1);
			newPlacement.graphics.drawRect(0,0,25,25);
			holder.addChild(newPlacement);
		}

		public function addTrampolin(holder:Sprite):void
		{
			newPlacement = new Shape();
			newPlacement.graphics.beginFill(0x00FF00);
			newPlacement.graphics.drawCircle(12.5,25,12.5);
			holder.addChild(newPlacement);
		}

		public function addEnemy(holder:Sprite):void
		{
			newPlacement = new Enemy();
			//addChild(newPlacement);
			holder.addChild(newPlacement);
		}

		public function addEnemyPathFinder(holder:Sprite):void
		{
			newPlacement = new Shape();
			newPlacement.graphics.beginFill(0x000000,0);
			newPlacement.graphics.drawRect(0,0,25,25);
			holder.addChild(newPlacement);
		}

		public function addCoin(holder:Sprite):void
		{
			//adding coins
			newPlacement = new Coin();
			holder.addChild(newPlacement);
		}

		public function addGoal(holder:Sprite):void
		{
			newPlacement = new Goal();
			holder.addChild(newPlacement);
		}

		public function addScoreBoard(holder:Sprite):void
		{
			newPlacement = new TextField();
			newPlacement.name = 'scoreBoard';

			newPlacement.defaultTextFormat = dtextFormat;
			newPlacement.text = 'Score: 0';

			holder.addChild(newPlacement);
		}

		public function backgroundGenerator(holder:Sprite):void
		{
			var newPart:Shape = new Shape();
			newPart.graphics.beginFill(0x222222);
			newPart.graphics.drawRect(0,0,int(Math.random()*10)+1,int(Math.random()*10)+1);
			newPart.x = int(Math.random() * lvlColumns * 50) - 550;
			newPart.y = (row - 1) * 25;
			holder.addChild(newPart);
		}

		public function generate():void
		{
			for (var i:int = 0; i<lvlArray.length; i++)
			{
				if (i/lvlColumns == int(i/lvlColumns))
				{
					row++;
				}
				if (lvlArray[i] == 1)
				{
					addBlock(blockHolder);
				}
				else if (lvlArray[i] == 'CHAR')
				{
					addPlayer(playerHolder);
				}
				else if (lvlArray[i] == 2)
				{
					addLadder(ladderHolder);
				}
				else if (lvlArray[i] == 3)
				{
					addBumper(bumperHolder);
				}
				else if (lvlArray[i] == 4)
				{
					addTrampolin(trampHolder);
				}
				else if (lvlArray[i] == 5)
				{
					addEnemy(enemyHolder);
				}
				else if (lvlArray[i] == 6)
				{
					addEnemyPathFinder(pathfinderHolder);
				}
				else if (lvlArray[i] == 7)
				{
					addCoin(coinHolder);
				}
				else if (lvlArray[i] == 8)
				{
					addGoal(enemyHolder);
				}
				else if (lvlArray[i] == 9)
				{
					addScoreBoard(textHolder);
				}

				if (lvlArray[i] != 0 && newPlacement != undefined)
				{
					placeBlock(i,newPlacement);
				}
				//backgroundGenerator(bgHolder);


			}
			row = 0;
			bgHolder.x = 0;
		}

		public function placeBlock(i:int, ob:Object)
		{
			ob.x = (i - (row - 1) * lvlColumns) * ob.width;
			ob.y = (row - 1) * ob.height;
		}

		public function resetLvl():void
		{

			//Destroi todos os elementos associados ao nível
			for (var i:int=0; i<lvlHolder.numChildren; i++)
			{
				var currentContainer = lvlHolder.getChildAt(i);
				if (currentContainer.hasOwnProperty('numChildren'))
				{
					for (var i2:int = 0; i2<currentContainer.numChildren; i2++)
					{
						var basicClass = currentContainer.getChildAt(i2);
						try
						{
							basicClass.destroy();
						}
						catch (e:Error){/*Forma feia de ver se o método destroy existe!!*/}
						currentContainer.removeChildAt(i2);
					}
				}
			}

			score = 0;
			lvlHolder.x = 0;
			generate();
		}
	}
}