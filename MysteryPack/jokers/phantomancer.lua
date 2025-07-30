
-- Phantomancer
SMODS.Joker{
	key = "phantomancer",
	atlas = "jokers",
	pos = {x=6,y=0},
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss and
		#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card{
						set = "Spectral",
						key_append = "mypa_phanto" -- why did I add this? I can't remember...
					}
					G.GAME.consumeable_buffer = 0
					return true
				end
			}))
			return {
				message = localize("k_plus_spectral"),
				colour = G.C.SECONDARY_SET.Spectral
			}
		end
	end
}