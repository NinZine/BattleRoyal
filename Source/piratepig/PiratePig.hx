package piratepig;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.system.Capabilities;
import flash.Lib;
import openfl.Assets;
import openfl.display.FPS;


class PiratePig extends Sprite {
	
	
	private var Background:Bitmap;
	private var Footer:Bitmap;
	private var Game:PiratePigGame; 
	
	
	public function new () {
		
		super ();

		Assets.loadLibrary("characters", function (_) {
			initialize ();
			construct ();
		
			resize (stage.stageWidth, stage.stageHeight);
			stage.addEventListener (Event.RESIZE, stage_onResize);
		});
	}
	
	
	private function construct ():Void {
		
		//Footer.smoothing = true;
		
		addChild(new FPS());
		addChild (Background);
		//addChild (Footer);
		addChild (Game);
		
	}
	
	
	private function initialize ():Void {
		
		Background = new Bitmap (Assets.getBitmapData ("characters:BackgroundBitmap"));
		//Background = Assets.getMovieClip("characters:BackgroundVector");
		//Footer = new Bitmap (Assets.getBitmapData ("images/center_bottom.png"));
		Game = new PiratePigGame (stage);
		
	}
	
	
	private function resize (newWidth:Int, newHeight:Int):Void {
		
		Background.width = newWidth;
		Background.height = newHeight;
		
		Game.resize (newWidth, newHeight);
		
		/* TODO: Use footer for buttons
		Footer.scaleX = Game.currentScale;
		Footer.scaleY = Game.currentScale;
		Footer.x = newWidth / 2 - Footer.width / 2;
		Footer.y = newHeight - Footer.height;
		*/
		
	}
	
	
	private function stage_onResize (event:Event):Void {
		
		resize (stage.stageWidth, stage.stageHeight);
		
	}
	
	
}
