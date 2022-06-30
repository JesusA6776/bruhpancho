function onCreate()
	-- background shit
	makeLuaSprite('street1', 'street1', -600, -300);
	setScrollFactor('street1', 0.9, 0.9);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

	end

	addLuaSprite('street1', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end