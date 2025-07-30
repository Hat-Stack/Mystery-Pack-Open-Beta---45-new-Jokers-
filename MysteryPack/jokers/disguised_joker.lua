
-- Disguised Joker
SMODS.Joker{
	key = "disguised_joker",
	atlas = "jokers",
	pos = {x=0,y=0},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	config = {
		extra = {
			odds = 4
		}
	},
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "mypa_disguise")
		return { vars = {n, d}}
	end,
	calculate = function(self, card, context)
		-- DNA's code...
		-- also its a mess
		if context.individual and context.cardarea == G.play and context.other_card:is_face() then
			if SMODS.pseudorandom_probability(card, "disguised_joker_dupes", 1, card.ability.extra.odds, "mypa_disguise") then
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				local _card = copy_card(context.other_card, nil, nil, G.playing_card)
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
				return {
					message = localize('k_copied_ex'),
					message_card = card,
					colour = G.C.GREEN,
					func = function()
						G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.calculate_context({playing_cards_added = true, cards = _card})
							return true
						end
						}))	
					end
				}
			end
		end
	end
}