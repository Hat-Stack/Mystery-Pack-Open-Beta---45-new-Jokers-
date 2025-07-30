
-- All utility functions will be stored here
MysteryPack.Utils = {}

MysteryPack.Utils.get_cards_of_rank_tally = function(rank)
	if G.playing_cards then
		local tally = 0
		for _,v in ipairs(G.playing_cards) do
			if v:get_id() == rank then
				tally = tally + 1
			end
		end
		return tally
	else
		return 0
	end
end

MysteryPack.Utils.get_clean_cards_tally = function()
	if G.playing_cards then
		local tally = 0
		for _,v in ipairs(G.playing_cards) do
			if not next(SMODS.get_enhancements(v))
			and not v.seal and not v.edition then
				tally = tally + 1
			end
		end
		return tally
	else
		return 0
	end
end

MysteryPack.Utils.sell_value_total = function(except)
	if G.jokers then
		local total = 0
		for _,v in ipairs(G.jokers.cards) do
			if v ~= except then
				total = total + v.sell_cost
			end
		end
		return total
	else
		return 0
	end
end

MysteryPack.Utils.get_suit_tally = function(suit)
	if G.playing_cards then
		local tally = 0
		for _,v in ipairs(G.playing_cards) do
			if v:is_suit(suit) then
				tally = tally + 1
			end
		end
		return tally
	else
		return 0
	end
end

MysteryPack.Utils.get_unique_suits = function(cards)
	local seen_suits = {}
	for _,v in ipairs(cards) do
		-- wait, there isn't a get_suit function?
		if SMODS.has_enhancement(v, "m_wild") and not seen_suits["wild"] then seen_suits[#seen_suits+1] = "wild" end
		if v:is_suit("Spades") and not seen_suits["spade"] then seen_suits[#seen_suits+1] = "spade" end
		if v:is_suit("Hearts") and not seen_suits["heart"] then seen_suits[#seen_suits+1] = "heart" end
		if v:is_suit("Diamonds") and not seen_suits["diamond"] then seen_suits[#seen_suits+1] = "diamond" end
		if v:is_suit("Clubs") and not seen_suits["club"] then seen_suits[#seen_suits+1] = "club" end
		local suit = v.config.card.suit
		if suit ~= "Spades" and suit ~= "Diamonds" and suit ~= "Hearts" and suit ~= "Clubs" then seen_suits[#seen_suits+1] = suit end -- some rudimentary modded suit support (because modded suits are cool)
		
	end
	return math.min(#seen_suits, #cards)
end

MysteryPack.Utils.words_list = {
	"Innovation",
	"Synergy",
	"Connected",
	"Sustainability",
	"Competency",
	"Visibility",
	"Disrupt",
	"Bandwidth",
	"Revolution",
	"Demographic",
	"Optimize",
	"Evolution",
	"Complimentary",
	"Self-Sufficient",
	"Product",
	"Rebrand",
	"Development",
	"Strategy",
	"Bold",
	"Recognition", -- move these to the localization file at some point (but not now, I'm lazy)

}

MysteryPack.Utils.compile_jargon = function()
	local word_amount = 1
	local final_string = ""
	for i=1,word_amount do
		final_string = final_string .. " " .. MysteryPack.Utils.words_list[math.floor(pseudorandom("corporate_speak_2") * #MysteryPack.Utils.words_list) + 1]
	end
	final_string = final_string .. " !"
	return final_string
end