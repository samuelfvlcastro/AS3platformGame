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
		public static function getHighScore1():Number
		{
			var shared:SharedObject = SharedObject.getLocal("myStuff");
			return shared.data.highScore1;
		}

		public static function getHighScore2():Number
		{
			var shared:SharedObject = SharedObject.getLocal("myStuff");
			return shared.data.highScore2;
		}

		public static function getHighScore3():Number
		{
			var shared:SharedObject = SharedObject.getLocal("myStuff");
			return shared.data.highScore3;
		}

		public static function saveHighScore(scoreValue:Number):void
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
					shared.data.highScore1 = scoreValue;
				}
				else if ( scoreValue >= shared.data.highScore2 )
				{
					shared.data.highScore3 = shared.data.highScore2;
					shared.data.highScore2 = scoreValue;
				}
				else if ( scoreValue >= shared.data.highScore3 )
				{
					shared.data.highScore3 = scoreValue;
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