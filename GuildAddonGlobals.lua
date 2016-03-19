GuildAddon = {}

GuildAddon.wm= {
  wm = WINDOW_MANAGER,
  Main_Control = {},
}

GuildAddon.var = {
  appName = "GuildAddon",
  controls = {},
  loadMessageInterval = 2,
  loadWelcomeFuncInterval = 2000,
  isAddonLoaded = false,
  version = "1.0.0",
  guilds = {},
  defaults = {},
  color = {
    colMagic     = "|c2dc50e", -- Magic Green (Uncommon)
    colTrash     = "|c777777", -- Trash Gray (Garbage)
    colYellow    = "|cFFFF00" ,-- Yellow
    colArcane    = "|c3689ef", -- Arcane Blue (Rare)
    colArtifact  = "|c912be1", -- Epic (Epic)
    colTeal      = "|c00FFFF", -- Teal
    colWhite     = "|cFFFFFF", -- White
    colRed       = "|cFF0000", -- Red
    colLegendary = "|cd5b526", -- Legendary Gold (TheShit)
    colGreen     = "|c00FF00", -- Green
  },
}

GuildAddon.welcomeMsg = GuildAddon.var.color.colWhite .. "[" .. GetTimeString() .. "]|r" .. GuildAddon.var.color.colGreen .." SwordStroker".. GuildAddon.var.color.colYellow .." Guild Addon Initialized."
