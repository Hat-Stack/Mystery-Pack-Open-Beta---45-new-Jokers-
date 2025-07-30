
-- Collage Joker
SMODS.Joker{
	key = "collage_joker",
	atlas = "jokers",
	pos = {x=1,y=9},
	rarity = 3,
	cost = 8,
	blueprint_compat = false,
	perishable_compat= true,
	eternal_compat = true,
	config = {extra = {
		needed = 3,
		left = 3
	}},
	loc_vars = function(self, info_queue, card)
		return {vars = {
			card.ability.extra.needed,
			card.ability.extra.left
		}}
	end,
	calculate = function(self, card, context)
		if context.selling_card and not context.blueprint and context.card ~= card and context.card.config.center.set == "Joker" and not context.retrigger_joker then
			card.ability.extra.left = card.ability.extra.left - 1
			if card.ability.extra.left == 0 then
				card.ability.extra.left = card.ability.extra.needed
				return {
					message = localize("mypa_collage_deploy"),
					colour = G.C.MYPA_TEAL,
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								add_tag(Tag("tag_buffoon"))
								play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
								return true
							end
						}))
					end
				}
			else
				return {message = localize("mypa_collage_charging"), colour = G.C.MYPA_TEAL}
			end
		end
	end
}
