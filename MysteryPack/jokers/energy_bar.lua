
-- Energy Bar
SMODS.Joker{
	key = "energy_bar",
	atlas = "jokers",
	pos = {x=3,y=10},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = false,
	config = {
		extra = {
			left = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.left
		}}
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval then
			card.ability.extra.left = card.ability.extra.left - 1
			if card.ability.extra.left == 0 then
				return {
					level_up = true, message = localize("k_level_up_ex"),
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								card:start_dissolve() -- add a fancy animation or message or something later
								return true
							end
						}))
					end
				}
			end
			return {level_up = true, message = localize("k_level_up_ex")}
		end
	end
}
