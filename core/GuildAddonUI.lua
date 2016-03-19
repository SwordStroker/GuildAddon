
function GuildAddon.SetGuildAddonUI()
local panelData = {
	type = "panel",
	name = "Guild Addon",
	displayName = "Guild Addon Settings",
	author = "SwordStroker",
	version = GuildAddon.var.version,
	slashCommand = "/guildaddon",	--(optional) will register a keybind to open to this panel
	registerForRefresh = true,	--boolean (optional) (will refresh all options controls when a setting is changed and when the panel is shown)
	registerForDefaults = true,	--boolean (optional) (will set all options controls back to default values)
}

local optionsTable = {
	[1] = {
		type = "header",
		name = "Description",
		width = "full",	--or "half" (optional)
	},
	[2] = {
		type = "description",
		--title = "My Title",	--(optional)
		title = nil,	--(optional)
		text = "Choose your guilds for enabling/disabling logs.",
		width = "full",	--or "half" (optional)
	},
 
  [3] = {
		type = "submenu",
		name = "Guilds",
    controls = { },
	},
}

for i = 1,GetNumGuilds() do
  optionsTable[3].controls[i] = {
    type = "checkbox",
				name = GuildAddon.var.guilds[i],
				getFunc = function() return GuildAddon.savedVariables[GuildAddon.var.guilds[i]] end,
				setFunc = function(value) GuildAddon.savedVariables[GuildAddon.var.guilds[i]] = value end,
				width = "full",
        warning = "Will need to reload the UI.",
  }
end


local LAM = LibStub("LibAddonMenu-2.0")
LAM:RegisterAddonPanel("GuildAddonMenu", panelData)
LAM:RegisterOptionControls("GuildAddonMenu", optionsTable)

end