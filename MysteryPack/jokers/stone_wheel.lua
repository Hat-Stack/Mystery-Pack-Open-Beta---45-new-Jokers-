

-- Stone Wheel
SMODS.Joker{
	key = "stone_wheel",
	atlas = "jokers",
	pos = {x=9,y=0},
	pixel_size = {h = 71}, -- the same as square joker (it goes in the square hole)
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	perishable_compat= true,
	eternal_compat = true,
	config = {
		extra = {
			roll_odds = 3,
			wheel_odds = 4
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS["m_stone"]
		local roll_numerator, roll_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.roll_odds, "mypa_wheel_roll")
		local wheel_numerator, wheel_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.wheel_odds, "mypa_wheel_wheel")
		return {
			vars = {
				roll_numerator,
				roll_denominator,
				wheel_numerator,
				wheel_denominator
			}
		}
	end,
	calculate = function(self, card, context)
		-- retrigger
		if context.repetition and context.cardarea == G.play and
		SMODS.has_enhancement(context.other_card, 'm_stone') and
		SMODS.pseudorandom_probability(card, "mypa_wheel_roll_seed", 1, card.ability.extra.roll_odds, "mypa_wheel_roll") then
			return {
				message = localize("k_again_ex"),
				repetitions = 1,
				card = card
			}
		end
	
		-- wheel
		if context.individual and context.cardarea == G.play and
		SMODS.has_enhancement(context.other_card, 'm_stone') and
		SMODS.pseudorandom_probability(card, "mypa_wheel_wheel_seed", 1, card.ability.extra.wheel_odds, "mypa_wheel_wheel") and
		#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			return {
			extra = {
				message = localize("k_plus_tarot"),
				colour = G.C.SECONDARY_SET.Tarot,
				message_card = card,
				-- now to actually create the WoF
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_wheel_of_fortune")
							card:add_to_deck()
							G.consumeables:emplace(card)
							G.GAME.consumeable_buffer = 0
							return true
						end
					}))
				end
			}}
		end
	end
}
