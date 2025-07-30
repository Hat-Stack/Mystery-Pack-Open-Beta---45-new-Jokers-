
-- Virtual Joker
SMODS.Joker{
	key = "virtual_joker",
	atlas = "jokers",
	pos = {x=3,y=2},
	soul_pos = {
		x = 2, y = 2,
	},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = {extra = {
		odds = 5
	}},
	loc_vars = function(self, info_queue, card)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "mypa_virtual")
		return {vars = {
			new_numerator,
			new_denominator,
		}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
			if SMODS.pseudorandom_probability(card, "mypa_virtual_tag", 1, card.ability.extra.odds, "mypa_virtual") then
				local selected_key = get_next_tag_key("mypa_virtual_tag")
				if selected_key ~= "tag_boss" then
					return {
						message = localize("mypa_virtual_tag_saying"), colour = G.C.MYPA_VIRTUAL,
						message_card = card,
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									local tag = Tag(selected_key)
									
									-- assign hand if it is orbital tag (why can't it do it itself?)
									if tag.name == "Orbital Tag" then
										local available_hands = {}
										for k,v in pairs(G.GAME.hands) do
											if SMODS.is_poker_hand_visible(v) then table.insert(available_hands, k) end
										end
										tag.ability.orbital_hand = pseudorandom_element(available_hands, "mypa_virtual_orbital_hand")
									end
									
									add_tag(tag)
									return true
								end
							}))
						end
					}
				end
			end
		end
	end
}
