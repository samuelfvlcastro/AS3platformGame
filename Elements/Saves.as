/**
Autor: Samuel F. V. Leal de Castro
Número: 1050617
Esta classe gera informação gravada
**/
package Elements
{
	import flash.net.SharedObject;
	public class Saves
	{
		
		public static function saveTmpScore(score:Number){
			var shared:SharedObject = SharedObject.getLocal("myStuff");
			shared.data.tmpScore = score;
			shared.flush();
		}
		
		public static function getTmpScore():Number{
			var shared:SharedObject = SharedObject.getLocal("myStuff");
			return shared.data.tmpScore;
		}
		
		public static function getHighScore1():String
		{
			var shared:SharedObject = SharedObject.getLocal("myStuff");
			if(shared.data.highScore1Name == undefined){
				return 'NO SCORE';
			}
			return shared.data.highScore1Name + '  ' + String(shared.data.highScore1);
		}

		public static function getHighScore2():String
		{
			var shared:SharedObject = SharedObject.getLocal("myStuff");
			if(shared.data.highScore2Name == undefined){
				return 'NO SCORE';
			}
			return shared.data.highScore2Name + '  ' + shared.data.highScore2;
		}

		public static function getHighScore3():String
		{
			var shared:SharedObject = SharedObject.getLocal("myStuff");
			if(shared.data.highScore3Name == undefined){
				return 'NO SCORE';
			}
			return shared.data.highScore3Name + '  ' + shared.data.highScore3;
		}

		public static function saveHighScore(scoreValue:Number, pName:String):void
		{
			try
			{
				var shared:SharedObject = SharedObject.getLocal("myStuff");
				if (shared.data.highScore1 == null)
				{
					shared.data.highScore1 = 0;
				}
				if (shared.data.highScore2 == null)
				{
					shared.data.highScore2 = 0;
				}
				if (shared.data.highScore3 == null)
				{
					shared.data.highScore3 = 0;
				}

				if ( scoreValue >= shared.data.highScore1 )
				{
					shared.data.highScore2 = shared.data.highScore1;
					shared.data.highScore2Name = shared.data.highScore1Name;
					shared.data.highScore1 = scoreValue;
					shared.data.highScore1Name = pName;
				}
				else if ( scoreValue >= shared.data.highScore2 )
				{
					shared.data.highScore3 = shared.data.highScore2;
					shared.data.highScore3Name = shared.data.highScore2Name;
					shared.data.highScore2 = scoreValue;
					shared.data.highScore2Name = pName;
				}
				else if ( scoreValue >= shared.data.highScore3 )
				{
					shared.data.highScore3 = scoreValue;
					shared.data.highScore3Name = pName;
				}
				shared.flush();
			}
			catch (sharedObjectError:Error)
			{
				trace( "Caught this error:", sharedObjectError.name, sharedObjectError.message );
			}
		}

		public static function resetHighScore():void
		{
			var shared:SharedObject = SharedObject.getLocal("myStuff");
			shared.clear();
			shared.flush();
		}

	}

}