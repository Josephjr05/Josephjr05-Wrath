package states;

import objects.AttachedSprite;

import openfl.Lib;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:FlxColor;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	override function create()
	{
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Looking at Credits", null);
		#end

		#if desktop
		Lib.application.window.title = 'The SkyDecay Project | Look at all those lovely people who worked on this mod! Arent they amazing?';
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		for (mod in Mods.parseList().enabled) pushModCreditsToList(mod);
		#end

		var defaultList:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['The SkyDecay Project Team',	'sdpj',	'All 50+ members who worked on SDPJ!',	'https://gamebanana.com/wips/68022',	'1480E7'],
			['Josephjr05',	'joseph',	'Commander of SkyDecay/SDPJ. Voice Actor, Mania Charter, and Writer.',	'https://www.youtube.com/@josephjr05',	'C5967A'],
			['Nixvyy',	'nixvyy',	'Co-Writer, Charter, Voice Actor, Tester, Dialogue Editor, etc..',	'https://www.twitch.tv/thelegendbro736',	'FF6A6A'],
			['Lycranok',	'razalzy',	'Lead Coder for SkyDecay Engine (Psych Fork) and Mod',	'https://www.youtube.com/@razalzy',	'FEA096'],
			['RexDX',	'rexdx',	'Lua Coder and Spanish Translator for SDPJ',	'',	'D8BDBB'],
			['Syan',	'syan',	'Lua Coder for SDPJ',	'',	'D8BDBB'], // no profile
			['Casual_fr1days',	'casual-fr1days', 'Background Artist for SDPJ',	'https://www.instagram.com/casual_fr1days/',	'6C79A5'],
			['Caydenedd',	'caydenedd',	'General Artist and a Charter for SDPJ',	'',	''], // no profile
			['Ray_8946',	'ray',	'Corruption ShowDown (x SDPJ) Creator, also General Artist and Voice Actor for SDPJ.', 'https://www.youtube.com/@Rayflowers-06',	'8994A8'],
			['Rhovanon',	'rhovanon',	'Promotional Artist and "Voidicious" character creator!',	'',	'630D7D'], // no profile
			['Juliouxz',	'juliouxz',	'Animator for SDPJ',	'',	''], // no profile
			['RealMelonMan',	'realmelonman',	'2D and 3D Animator/Sprite Artist, Musician and Chromatic Scaler for SDPJ.',	'',	'ADBFE3'],
			['Star546',	'star',	'Animator and Musician for SDPJ',	'https://www.youtube.com/@ST4_R',	'FFDD16'],
			['Tazzah', 'zaz',	'Sprite and Background Artist/Animator for SDPJ',	'',	'00CBFF'],
			['theoriginaldevel',	'theoriginaldevel',	'Chromatic Scaler for SDPJ',	'',	''], // no profile
			['3w3mk',	'3w3mk',	'Musician for SDPJ',	'',	'FF5100'], // no profile
			['CBMusic',	'cb',	'Musician of 2 songs and Swedish Translator for SDPJ', 'https://linktr.ee/capslockovershift',	'FF5100'],
			['Gavin360',	'gavin360',	'Musician for SDPJ',	'',	'A00303'], // no profile
			['Exosceletic',	'exo',	'Musician for SDPJ',	'https://gamebanana.com/mods/499509',	'00279E'], // no profile
			['To Much Masks',	'tomuchmasks',	'Among us Trapped (x SDPJ) creator and Musician for SDPJ', 'https://gamebanana.com/wips/74197',	'A205C1'],
			['Kytchu',	'kytchu',	'Musician for SDPJ',	'https://www.youtube.com/@Kytchuthedeermusic',	'129E1D'],
			['Genowrld',	'genowrld',	'MUSIC PRODUCER *insert fire emoji*',	'https://youtu.be/rY7X97eRFKM?si=Whpcs48vPQPVskMY',	'EBEBEB'],
			['UltraCakra',	'ultracakra',	'Musician for SDPJ',	'https://twitter.com/Funkin_at_UandI',	'E1E2DD'],
			['Zestery Trox',	'zestery-trox',	'Musician for SDPJ',	'',	'FFFFFF'], // gone?
			['HPD',	'hpd',	'Aggressive Charter	for SDPJ',	'',	'80DBF4'],
			['KotaCyote',	'kotecyote',	'Mania Charter for SDPJ',	'',	'D80101'],
			['alumence',	'alu',	'Mania Charter for SDPJ',	'',	'0C3C9A'],
			['HealsGood',	'healsgood',	'Mania Charter for SDPJ',	'',	''],
			['MIGATTE',	'migatte',	'Mania Charter for SDPJ',	'',	''],
			['mMYTHh',	'usermania',	'Mania Charter for SDPJ',	'',	''],
			['Czeck',	'czeck',	'Charter for SDPJ',	'',	''],
			['E-M',	'em2502',	'Charter for SDPJ',	'',	''],
			['juney2008',	'juney2008',	'Charter for SDPJ',	'',	''],
			['IronXavier',	'lemon',	'Charter for SDPJ',	'',	''],
			['tehememan',	'tehememan',	'Charter for SDPJ',	'',	''],
			['Notmrpolo',	'mrpolo',	'Charter for SDPJ',	'',	''],
			['SakuraCharter',	'sakuracharter',	'Charter for SDPJ',	'',	''],
			['BallisticFullPower',	'ballisticfullpower',	'Charter for SDPJ',	'',	''],
			['STILL WIP'],
			[''],
			['Psych Engine Team'],
			['Shadow Mario',		'shadowmario',		'Main Programmer and Head of Psych Engine',					 'https://ko-fi.com/shadowmario',		'444444'],
			['Riveren',				'riveren',			'Main Artist/Animator of Psych Engine',						 'https://twitter.com/riverennn',		'14967B'],
			[''],
			['Former Engine Members'],
			['bb-panzu',			'bb',				'Ex-Programmer of Psych Engine',							 'https://twitter.com/bbsub3',			'3E813A'],
			['shubs',				'',					'Ex-Programmer of Psych Engine\nI don\'t support them.',	 '',									'A1A1A1'],
			[''],
			['Engine Contributors'],
			['CrowPlexus',			'crowplexus',		'Input System v3, Major Help and Other PRs',				 'https://twitter.com/crowplexus',		'A1A1A1'],
			['Keoiki',				'keoiki',			'Note Splash Animations and Latin Alphabet',				 'https://twitter.com/Keoiki_',			'D2D2D2'],
			['SqirraRNG',			'sqirra',			'Crash Handler and Base code for\nChart Editor\'s Waveform', 'https://twitter.com/gedehari',		'E1843A'],
			['EliteMasterEric',		'mastereric',		'Runtime Shaders support',									 'https://twitter.com/EliteMasterEric',	'FFBD40'],
			['PolybiusProxy',		'proxy',			'.MP4 Video Loader Library (hxCodec)',						 'https://twitter.com/polybiusproxy',	'DCD294'],
			['Tahir',				'tahir',			'Implementing & Maintaining SScript and Other PRs',			 'https://twitter.com/tahirk618',		'A04397'],
			['iFlicky',				'flicky',			'Composer of Psync and Tea Time\nMade the Dialogue Sounds',	 'https://twitter.com/flicky_i',		'9E29CF'],
			['KadeDev',				'kade',				'Fixed some issues on Chart Editor and Other PRs',			 'https://twitter.com/kade0912',		'64A250'],
			['superpowers04',		'superpowers04',	'LUA JIT Fork',												 'https://twitter.com/superpowers04',	'B957ED'],
			['CheemsAndFriends',	'face',	'Creator of FlxAnimate\n(Icon will be added later, merry christmas!)',	 'https://twitter.com/CheemsnFriendos',	'A1A1A1'],
			[''],
			["Funkin' Crew"],
			['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",						 'https://twitter.com/ninja_muffin99',	'CF2D2D'],
			['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",							 'https://twitter.com/PhantomArcade3K',	'FADC45'],
			['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",							 'https://twitter.com/evilsk8r',		'5ABD4B'],
			['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",							 'https://twitter.com/kawaisprite',		'378FC7']
		];
		
		for(i in defaultList) {
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(FlxG.width / 2, 300, creditsStuff[i][0], !isSelectable);
			optionText.isMenuItem = true;
			optionText.targetY = i;
			optionText.changeX = false;
			optionText.snapToPosition();
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Mods.currentModDirectory = creditsStuff[i][5];
				}

				var str:String = 'credits/missing_icon';
				if(creditsStuff[i][1] != null && creditsStuff[i][1].length > 0)
				{
					var fileName = 'credits/' + creditsStuff[i][1];
					if (Paths.fileExists('images/$fileName.png', IMAGE)) str = fileName;
					else if (Paths.fileExists('images/$fileName-pixel.png', IMAGE)) str = fileName + '-pixel';
				}

				var icon:AttachedSprite = new AttachedSprite(str);
				if(str.endsWith('-pixel')) icon.antialiasing = false;
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Mods.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
			else optionText.alignment = CENTERED;
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = CoolUtil.colorFromString(creditsStuff[curSelected][4]);
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if(controls.ACCEPT && (creditsStuff[curSelected][3] == null || creditsStuff[curSelected][3].length > 4)) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}
		
		for (item in grpOptions.members)
		{
			if(!item.bold)
			{
				var lerpVal:Float = Math.exp(-elapsed * 12);
				if(item.targetY == 0)
				{
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(item.x - 70, lastX, lerpVal);
				}
				else
				{
					item.x = FlxMath.lerp(200 + -40 * Math.abs(item.targetY), item.x, lerpVal);
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:FlxColor = CoolUtil.colorFromString(creditsStuff[curSelected][4]);
		//trace('The BG color is: $newColor');
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	#if MODS_ALLOWED
	function pushModCreditsToList(folder:String)
	{
		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
	}
	#end

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
