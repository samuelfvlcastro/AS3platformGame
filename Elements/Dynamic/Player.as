/**
Autor: Samuel F. V. Leal de Castro
Número: 1050617
Esta classe garante toda a interatividade entre o player e o nível:
 . Movimento do player
 . Cálculos de colisões com o cenário
 . Cálculos de colisões com entidades (escadas, inimigos, portas, etc.)
**/
package Elements.Dynamic
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.geom.Point;
	import flash.display.Stage;

	public class Player extends MovieClip
	{
		//Variáveis genericas 
		private var _LevelGenerator:MovieClip;
		private var _lvlHolder:Sprite;
		private var _stage:Stage;
		private var _txtScore:TextField;

		//Controlo de colisões
		var mainOnGround:Boolean = false;
		var mainHitWall:Boolean = false;

		//Controlo de movimento
		var leftKeyDown:Boolean = false;
		var upKeyDown:Boolean = false;
		var rightKeyDown:Boolean = false;
		var downKeyDown:Boolean = false;

		//Controlo de velocidade
		var hoSpeed:Number = 5;//holder
		var plSpeed:Number = 6;//player

		//Controlo de saltos
		var mainJumping:Boolean = false;
		var jumpSpeedLimit:int = 20;
		var jumpSpeed:Number = jumpSpeedLimit;

		//Controlo de colisões com entidades
		var mainOnLadder:Boolean = false;
		var mainBumping:Boolean = false;
		var bumpSpeed:int = 20;

		public function Player()
		{
			addEventListener(Event.ADDED, beginClass);
		}

		private function beginClass(event:Event):void
		{
			_LevelGenerator = MovieClip(parent.parent.parent);
			_lvlHolder = Sprite(parent.parent);
			_stage = _LevelGenerator.stage;
			_txtScore = _LevelGenerator.lvlHolder.getChildByName('textHolder').getChildByName('scoreBoard');

			_stage.addEventListener(Event.ENTER_FRAME, moveChar);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
		}
		public function destroy()
		{
			_stage.removeEventListener(Event.ENTER_FRAME, moveChar);
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
		}
		private function moveChar(event:Event):void
		{
			if(_txtScore != null)_txtScore.x +=  hoSpeed;
			_lvlHolder.x -=  hoSpeed;
			//Always running!!
			if (! mainHitWall)
			{
				this.x +=  plSpeed;
			}
			else
			{
				this.x -=  hoSpeed;
			}

			//Morre se sair do mapa
			var lvlHit = this.globalToLocal(new Point(_LevelGenerator.stage.x,_LevelGenerator.stage.y));//Transforma vetor global em relativo
			if (lvlHit.x > 0)
			{
				_LevelGenerator.resetLvl();
			}

			//Salta se nao estiver numa escada;
			if (upKeyDown || mainJumping)
			{
				if (! mainOnLadder)
				{
					mainJump();
				}
			}

			//Apenas subir se estiver numa escada
			if (upKeyDown && mainOnLadder)
			{
				this.y -=  hoSpeed;
			}
			if (downKeyDown && mainOnLadder && !mainOnGround)
			{
				this.y +=  hoSpeed;
			}

			if (_lvlHolder != null)
			{
				var blockHolder = Sprite(_lvlHolder.getChildByName('blockHolder'));
			}

			//Itera sobre o blockHolder para ver se não há colisões
			for (var i:int = 0; i < blockHolder.numChildren; i++)
			{
				var hitBlock:DisplayObject = blockHolder.getChildAt(i);
				var localHit = hitBlock.globalToLocal(new Point(this.x,this.y));
				if (this.hitTestObject(hitBlock))
				{
					//Transforma vetor global em relativo
					mainOnGround = true;
					if (localHit.y >= 0)
					{
						mainHitWall = true;
					}
					break;
				}
				mainHitWall = false;
				mainOnGround = false;//Player está fora do chão sem colisão
			}

			var ladderHolder = Sprite(_lvlHolder.getChildByName('ladderHolder'));

			//Procura colisões com escadas para fazer subir
			for (i = 0; i < ladderHolder.numChildren; i++)
			{
				//Ladder
				var hitLadder:DisplayObject = ladderHolder.getChildAt(i);
				if (this.hitTestObject(hitLadder))
				{
					mainOnLadder = true;
					jumpSpeed = jumpSpeedLimit;
					break;
				}
				mainOnLadder = false;
			}

			var speederHolder = Sprite(_lvlHolder.getChildByName('speederHolder'));
			//Procura colisões com speeders
			for (i=0; i < speederHolder.numChildren; i++)
			{
				//Bumper
				var hitBumper:DisplayObject = speederHolder.getChildAt(i);

				if (this.hitTestObject(hitBumper))
				{
					mainOnGround = true;
					mainBumping = true;
					bumpSpeed = 20;
				}
			}
			mainBump();

			var trampHolder = Sprite(_lvlHolder.getChildByName('trampHolder'));

			//Procura colisões com trampolines
			for (i=0; i < trampHolder.numChildren; i++)
			{
				//trampoline
				var hitTramp:DisplayObject = trampHolder.getChildAt(i);

				if (this.hitTestObject(hitTramp))
				{
					//Salta!!!
					mainJump();
				}
			}
			if (! mainOnGround)
			{
				mainJumping = true;
			}

			//Morte por queda fora do cenário
			if (this.y >= _stage.stageHeight)
			{
				_LevelGenerator.resetLvl();
			}
		}


		private function checkKeysDown(event:KeyboardEvent):void
		{
			//Teclas estão a ser carregadas
			if (event.keyCode == 37 || event.keyCode == 65)
			{
				leftKeyDown = true;
			}
			if (event.keyCode == 38 || event.keyCode == 87)
			{
				upKeyDown = true;
			}
			if (event.keyCode == 39 || event.keyCode == 68)
			{
				rightKeyDown = true;
			}
			if (event.keyCode == 40 || event.keyCode == 83)
			{
				downKeyDown = true;
			}
		}

		private function checkKeysUp(event:KeyboardEvent):void
		{
			//Teclas foram soltas
			if (event.keyCode == 37 || event.keyCode == 65)
			{
				leftKeyDown = false;
			}
			if (event.keyCode == 38 || event.keyCode == 87)
			{
				upKeyDown = false;
			}
			if (event.keyCode == 39 || event.keyCode == 68)
			{
				rightKeyDown = false;
			}
			if (event.keyCode == 40 || event.keyCode == 83)
			{
				downKeyDown = false;
			}
		}

		//Salta, salta!!
		private function mainJump():void
		{
			//Não está a saltar?
			if (! mainJumping)
			{
				//Então salta!
				mainJumping = true;
				jumpSpeed = jumpSpeedLimit * -1;
				this.y +=  jumpSpeed;
			}
			else
			{
				if (jumpSpeed < 0)
				{
					jumpSpeed *=  1 - jumpSpeedLimit / 125;
					if (jumpSpeed > -jumpSpeedLimit/5)
					{
						jumpSpeed *=  -1;
					}
				}
				if (jumpSpeed > 0 && jumpSpeed <= jumpSpeedLimit)
				{
					jumpSpeed *=  1 + jumpSpeedLimit / 50;
				}
				this.y +=  jumpSpeed;

				var blockHolder = Sprite(_lvlHolder.getChildByName('blockHolder'));
				for (var i:int = 0; i < blockHolder.numChildren; i++)
				{
					var hitBlock:DisplayObject = blockHolder.getChildAt(i);
					if (this.hitTestObject(hitBlock))
					{
						//Está em queda
						if (jumpSpeed > 0)
						{
							mainJumping = false;
							this.y = hitBlock.y - this.height;
							mainOnGround = true;

							break;
						}
						else
						{
							jumpSpeed = Math.abs(jumpSpeed);
							this.y = hitBlock.y + hitBlock.height + 1;
						}
					}
				}
			}
		}

		//TODO: Rever esta função
		private function mainBump():void
		{		
			if (mainBumping)
			{
				this.x +=  bumpSpeed;
				bumpSpeed *=  .5;
				if (bumpSpeed <= 1)
				{
					mainBumping = false;
				}
			}
		}
	}

}