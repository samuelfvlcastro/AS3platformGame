package 
{
	import flash.net.SharedObject;
	public class Saves
	{
		var shared:SharedObject = SharedObject.getLocal("sharedStorage");
		var tempArray:Array = new Array();
		
		public function Saves()
		{
			if (shared.data.score != null)
			{
				//Se já exitir um score meter num array
				tempArray = shared.data.score;
			}
		}

		public function getHighScore():Array
		{
				return tempArray;
		}

		public function saveHighScore(pName, highScore):void
		{
			var objArray:Array = new Array();
			objArray.push({"date":"23/06/2012","time":"08:23","score":788,"stage":7});
			
			//Push do highScore para o array
			tempArray.push({"date":"23/06/2012","time":"08:23","score":788,"stage":7});
			shared.data.score = tempArray;

			//save e close
			shared.flush();
			shared.close();
		}
		
		
		public function resetHighScore():void
		{
			//Push do highScore para o array
			tempArray = null;
			shared.data.score = tempArray;

			trace(tempArray);

			//save e close
			shared.flush();
			shared.close();
		}

	}

}