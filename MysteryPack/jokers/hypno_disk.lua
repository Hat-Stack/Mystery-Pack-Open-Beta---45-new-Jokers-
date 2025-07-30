
-- Hypno Disk
SMODS.Joker{
	key = "hypno_disk",
	atlas = "jokers",
	pos = {x=0,y=7},
	pixel_size = {h = 71}, -- the same as square joker (it goes in the square hole)
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	perishable_compat= true,
	eternal_compat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = {key = 'blue_seal', set = 'Other'}
		return { }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and
		context.other_card.seal and context.other_card.seal == "Blue" and not context.other_card.debuff and
		#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet, message_card = card, juice_card = context.other_card,
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							if context.scoring_name then
								local selected_planet = nil
								for k,v in ipairs(G.P_CENTER_POOLS.Planet) do
									if v.config.hand_type == context.scoring_name then
										selected_planet = v.key
									end
								end
								if selected_planet then
									local planet = SMODS.add_card({key = selected_planet})
								end
								G.GAME.consumeable_buffer = 0
							end
							return true
						end
					}))
				end
			}
		end
	end,
	in_pool = function(self, args)
		local blueseal = nil
		for _,v in ipairs(G.playing_cards) do
			if v.seal and v.seal == "Blue" then
				blueseal = true
			end
		end
		if blueseal then return true end
		return false
	end
}
