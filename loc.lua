
Hooks:Add("LocalizationManagerPostInit", "E3_Localization", function(loc)
	LocalizationManager:add_localized_strings({
		["heist_e3_garage_name"] = "E3: Garage",
		["heist_e3_garage_brief"] = "Recreation of the Starbreeze.com parked webpage image.\n\nStarbreeze.com is parked at the moment...",
		["heist_e3_garage_remix_name"] = "Developer: Garage",
		["heist_e3_garage_remix_brief"] = "Garage testing environment.",
		["heist_e3_dozer_name"] = "E3: Bulldozer",
		["heist_e3_dozer_brief"] = "For viewing & recording a sequence in which a Bulldozer kicks open a door."
	})
end)


