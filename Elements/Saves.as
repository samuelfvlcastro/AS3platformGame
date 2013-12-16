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
		public static function getHighScore():Number
		{
			var shared:SharedObject = SharedObject.getLocal("sharedStorage");

			//Se ainda não houver highScore
			if (shared.data.highScore == null)
			{
				saveHighScore(0);
			}
			return shared.data.highScore;
		}

		public static function saveHighScore(scoreValue:Number):void
		{
			try
			{
				var shared:SharedObject = SharedObject.getLocal("sharedStorage");
				if (shared.data.highScore == null)
				{
					shared.data.highScore = scoreValue;
				}
				else if ( scoreValue > shared.data.highScore )
				{
					shared.data.highScore = scoreValue;
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
			var shared:SharedObject = SharedObject.getLocal("sharedStorage");
			shared.clear();
			shared.flush();
		}

	}

}