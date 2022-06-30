-- Lua stuff
tankX = 400;
tankSpeed = 0;
tankAngle = 0;
finishedGameover = false;
startedPlaying = false;

function onCreate()
	-- background shit
	math.randomseed(os.time());
	tankSpeed = math.random(5, 7);
	tankAngle = math.random(-90, 45);
	makeLuaSprite('tankSky', 'tankSky', -400, -400);
	setLuaSpriteScrollFactor('tankSky', 0, 0);

	makeLuaSprite('tankBuildings', 'tankBuildings', -200, 0);
	setLuaSpriteScrollFactor('tankBuildings', 0.3, 0.3);
	scaleObject('tankBuildings', 1.1, 1.1);

	makeLuaSprite('tankRuins', 'tankRuins', -200, 0);
	setLuaSpriteScrollFactor('tankRuins', 0.35, 0.35);
	scaleObject('tankRuins', 1.1, 1.1);

	makeLuaSprite('tankGround', 'tankGround', -420, -150);
	scaleObject('tankGround', 1.15, 1.15);
	
	-- those are only loaded if you have Low quality turned off, to decrease loading times and memory
	if not lowQuality then
		makeLuaSprite('tankClouds', 'tankClouds', math.random(-700, -100), math.random(-20, 20));
		setLuaSpriteScrollFactor('tankClouds', 0.1, 0.1);
		setProperty('tankClouds.velocity.x', math.random(5, 15));

		makeLuaSprite('tankMountains', 'tankMountains', -300, -20);
		setLuaSpriteScrollFactor('tankMountains', 0.2, 0.2);
		scaleObject('tankMountains', 1.2, 1.2);

		makeAnimatedLuaSprite('smokeLeft', 'smokeLeft', -200, -100);
		luaSpriteAddAnimationByPrefix('smokeLeft', 'idle', 'SmokeBlurLeft');
		setLuaSpriteScrollFactor('smokeLeft', 0.4, 0.4);

		makeAnimatedLuaSprite('smokeRight', 'smokeRight', 1100, -100);
		luaSpriteAddAnimationByPrefix('smokeRight', 'idle', 'SmokeRight');
		setLuaSpriteScrollFactor('smokeRight', 0.4, 0.4);
	end

	addLuaSprite('tankSky', false);
	addLuaSprite('tankClouds', false);
	addLuaSprite('tankMountains', false);
	addLuaSprite('tankBuildings', false);
	addLuaSprite('tankRuins', false);
	addLuaSprite('smokeLeft', false);
	addLuaSprite('smokeRight', false);
	addLuaSprite('tankGround', false);

	-- foreground shit
	
	if not lowQuality then

	end

	moveTank(0);
	print('finished loading stage successfully')
end

function onUpdate(elapsed)
	moveTank(elapsed);
	
	if inGameOver and not startedPlaying and not finishedGameover then
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0.2);
	end
end

function moveTank(elapsed)
	if not inCutscene then
	
	end
end

-- Gameplay/Song interactions
function onBeatHit()
	-- triggered 4 times per section

end

function onCountdownTick(counter)
	onBeatHit();
end


-- Game over voiceline
function onGameOver()
	runTimer('playJeffVoiceline', 2.7);
	return Function_Continue;
end

function onGameOverConfirm(reset)
	finishedGameover = true;
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A tween you called has been completed, value "tag" is it's tag
	if not finishedGameover and tag == 'playJeffVoiceline' then
		math.randomseed(os.time());
		soundName = string.format('jeffGameover/jeffGameover-%i', math.random(1, 25));
		playSound(soundName, 1, 'voiceJeff');
		startedPlaying = true;
	end
end

function onSoundFinished(tag)
	if tag == 'voiceJeff' and not finishedGameover then
		soundFadeIn(nil, 4, 0.2, 1);
	end
end