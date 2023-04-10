local mod_path = tostring("mods/MapAddE3/")

local environment_replacers = {
 	ukrainian_job_res = {
 		{ --Default
			["environments/pd2_env_mid_day/pd2_env_mid_day"] = "scriptdata/uk_job_new.custom_xml" 			
 		},
		{ --HH Default
			["environments/pd2_env_mid_day/pd2_env_mid_day"] = "scriptdata/pd2_env_day_hh.custom_xml"
		},
 		{ --Overcast
 			["environments/pd2_env_mid_day/pd2_env_mid_day"] = "scriptdata/cloudy_day.custom_xml"
 		}
 	}
	}

--Checks the environment replacers table and replaces the environment if replacers are found.
--If multiple replacers exist, then it selects one at random.
--An empty replacer == load default environment.
function replaceEnvironment(level_id)
	local valid_envs = environment_replacers[level_id]
	if valid_envs then --Level has replacers defined.
		local selected_env = valid_envs[math.random(#valid_envs)]

		for default, replacement in pairs(selected_env) do
			BeardLib:ReplaceScriptData(mod_path .. replacement, "custom_xml", default, "environment")
		end
	end
end

Hooks:Add("BeardLibCreateScriptDataMods", "TODCallBeardLibSequenceFuncs", function()
	if Global.load_level == true then 
		replaceEnvironment(Global.game_settings.level_id)
	end
end)

--Environment skies loader
-- Much better than the original one, but I think dyn_resource manager should discard any not currently in use?
local skies = {
	"sky_1930_twillight",
	"sky_1930_sunset_heavy_clouds",
	"sky_1846_low_sun_nice_clouds",
	"sky_0902_overcast",
	"sky_1345_clear_sky",
	"sky_0200_night_moon_stars",
	"sky_2000_twilight_mad",
	"sky_2100_moon",
	"sky_1008_cloudy",
	"sky_0927_whispy_clouds",
	"sky_2335_night_moon",
	"sky_2100_moon",
	"sky_1313_cloudy_dark",
	"sky_2003_dusk_blue",
	"sky_2003_dusk_blue_high_color_scale"
}

Hooks:Add("BeardLibPreProcessScriptData", "RestorationCreateEnvironment", function(PackManager, path, raw_data)
    if managers.dyn_resource then
        for _, sky in ipairs(skies) do
            if not managers.dyn_resource:has_resource(Idstring("scene"), Idstring("core/environments/skies/" .. sky .. "/" .. sky), managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
                managers.dyn_resource:load(Idstring("scene"), Idstring("core/environments/skies/" .. sky .. "/" .. sky), managers.dyn_resource.DYN_RESOURCES_PACKAGE, nil)
            end
        end
    end
end)

--Blue Sapphire FIX
--OVK never finished the opening animation, and it was wrongly calling for to activate the diamond (probably leftover from PD:TH), thus this fix.  fix unfinished but works well enough
--probably update instances in heists where I want them to open with the PD:TH one raw.  someone port it correctly tyvm

-- Carried over from HEAT/ResMod/etc., don't touch.  Useful later!
Hooks:Add("BeardLibCreateScriptDataMods", "DiamondFixCallBeardLibSequenceFuncs", function()
	if SystemFS:exists(mod_path .. "scriptdata/diamondFIX.custom_xml") then
		BeardLib:ReplaceScriptData(mod_path .. "scriptdata/diamondFIX.custom_xml", "custom_xml", "units/pd2_dlc_dah/props/dah_props_diamond_stands/dah_prop_diamond_stand_01", "sequence_manager", true)
	end
end)
