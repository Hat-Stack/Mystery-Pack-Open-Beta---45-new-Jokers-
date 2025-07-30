
-- Corporate Joker
SMODS.Joker{
	key = "corporate_joker",
	atlas = "jokers",
	pos = {x=4,y=4},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	perishable_compat= true,
	eternal_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'tag_coupon', set = 'Tag' }
		return {}
	end,
	calculate = function(self, card, context)
		if context.before and context.full_hand then
			for i=1,#context.full_hand do
				card:juice_up(0.5, 0.5)
				SMODS.calculate_effect({dollars = -1, juice_card = context.full_hand[i]}, context.full_hand[i])
			end
		end
		if context.end_of_round and context.main_eval then
			local babblings = MysteryPack.Utils.compile_jargon()
			return {
				message = babblings,
				colour = G.C.EDITION,
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							add_tag(Tag("tag_coupon"))
							play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
							return true
						end
					}))
				end
			}
		end
	end
}
