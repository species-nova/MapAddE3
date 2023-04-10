MapAddE3SubmoduleFramework = MapAddE3SubmoduleFramework or class(MapFramework)

MapAddE3SubmoduleFramework._directory = ModPath .. "sub_mods"
MapAddE3SubmoduleFramework.type_name = "mapadde3"

MapAddE3SubmoduleFramework:init()
MapAddE3SubmoduleFramework:InitMods()