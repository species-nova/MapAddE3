Hooks:PostHook(TimerGui, "setup", "ResDrillFix", function(self)
	--Lowers drill screen brightness
	self._gui_script.panel:set_alpha(0.6)
end)
