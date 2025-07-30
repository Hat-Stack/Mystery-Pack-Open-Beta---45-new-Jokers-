
-- Infinite Chocolate
SMODS.Joker{
	key = "infinite_chocolate",
	atlas = "jokers",
	pos = {x=0,y=8},
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = {extra = {amount = 3}},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.amount}}
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.main_eval then
			for _,v in ipairs(context.removed) do
				for i=1,card.ability.extra.amount do
					-- create copy
					G.playing_card = (G.playing_card and G.playing_card + 1) or 1
					local _card = copy_card(v, nil, nil, G.playing_card)
					_card:add_to_deck()
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					table.insert(G.playing_cards, _card)
					G.hand:emplace(_card)
					_card.states.visible = nil
					G.E_MANAGER:add_event(Event({
						func = function()
							_card:start_materialize()
							return true
						end
					}))
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.calculate_context({playing_cards_added = true, cards = _card})
							return true
						end
					}))
				end
			end
			return {
				message = localize('k_copied_ex'),
				message_card = card,
				colour = G.C.FILTER,
			}
		end
	end
}
