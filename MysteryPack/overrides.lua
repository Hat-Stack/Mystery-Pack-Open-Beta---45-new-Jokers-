
-- override ease_dollars (for gift certificate) (I don't want to use lovely)

local _old_ease_dollars = ease_dollars

ease_dollars = function(amount)
	SMODS.calculate_context({
		mystery_pack = {
			money_change = amount
		}
	})
	return _old_ease_dollars(amount)
end

-- this object exists, right?
MysteryPack = MysteryPack or {}
MysteryPack.Sound = MysteryPack.Sound or {}
MysteryPack.Sound.temp_muted = false
MysteryPack.Sound.remaining_mute_time = 0
MysteryPack.Sound.previous_volume = nil

MysteryPack.Sound.get_sound_settings = function()
	if MysteryPack.Sound.temp_muted then
		local _muted = G.SETTINGS.SOUND
		_muted.music_volume = 0
		return _muted
	end
	return G.SETTINGS.SOUND
end

MysteryPack.Sound.apply_temp_mute = function(length)
	MysteryPack.Sound.previous_volume = G.SETTINGS.SOUND.music_volume
	MysteryPack.Sound.temp_muted = true
	MysteryPack.Sound.remaining_mute_time = length
end
