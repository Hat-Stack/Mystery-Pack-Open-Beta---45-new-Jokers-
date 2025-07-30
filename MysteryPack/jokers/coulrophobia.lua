
-- Register a Sound

SMODS.Sound{
	key = "spooky_vanish",
	path = "spooky_vanish.ogg"
}


-- Coulrophobia
SMODS.Joker{
	key = "coulrophobia",
	atlas = "jokers",
	pos = {x=8,y=7},
	rarity = 3,
	cost = 7,
	blueprint_compat = true,
	perishable_compat= false,
	eternal_compat = false,
	config = {extra = {
		per = 0.25,
		current = 1,
		first = true
	}},
	loc_vars = function(self, info_queue, card)
		return {vars = {
			card.ability.extra.per,
			card.ability.extra.current
		}}
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
			card.ability.extra.current = card.ability.extra.current + card.ability.extra.per
			return {message = localize("k_upgrade_ex"), colour = G.C.MULT}
		end
		if context.joker_main then
			return {x_mult = card.ability.extra.current}
		end
		if context.mystery_pack and context.mystery_pack.joker_obtained then
			if card.ability.extra.first then -- so that it doesn't destroy itself when obtained
				card.ability.extra.first = false
			else
				-- destroy!
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("mypa_spooky_vanish") -- flavour acquired!
						MysteryPack.Sound.apply_temp_mute(5)
						card:start_dissolve() -- destroys with animation
						return true
					end
				}))
			end
		end
	end
}
