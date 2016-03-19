if ESOAddonDev then
  dofile([[GuildAddonGlobals.lua]])
  dofile([[core/GuildAddonUI.lua]])
end

function GuildAddon.GuildPlayerStatusChanged(event,guildId,playerName,prevStatus,curStatus)
	GuildAddon.guildName = GetGuildName(guildId)
  if GuildAddon.savedVariables ~= nil then
    if curStatus == 1 and GuildAddon.savedVariables[GuildAddon.guildName] then
    CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "[" .. GetTimeString().. "]|r " .. GuildAddon.var.color.colGreen .. GuildAddon.guildName .. ": ".. GuildAddon.var.color.colTeal ..  playerName .. GuildAddon.var.color.colWhite .." has" .. GuildAddon.var.color.colWhite.. " came" .. GuildAddon.var.color.colGreen .. " Online")
    end
    if curStatus == 4 and GuildAddon.savedVariables[GuildAddon.guildName] then
      CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "[" .. GetTimeString().. "]|r " .. GuildAddon.var.color.colGreen .. GuildAddon.guildName .. ": ".. GuildAddon.var.color.colTeal ..  playerName .. GuildAddon.var.color.colWhite .." has" .. GuildAddon.var.color.colWhite.. " gone" .. GuildAddon.var.color.colRed .. " Offline")	
    end
  end
end

local function GuildMemberAdded(event,guildId,displayName)
  guildName = GetGuildName(guildId)
  if GuildAddon.savedVariables ~= nil and GuildAddon.savedVariables[guildName] then
    CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "[" .. GetTimeString() .. "]|r " .. GuildAddon.var.color.colGreen .. guildName .. ": " .. GuildAddon.var.color.colTeal .. displayName .. GuildAddon.var.color.colGreen .. " Joined" .. GuildAddon.var.color.colWhite .. " the guild")
  end
end

local function GuildMemberRemoved(event,guildId,displayName,characterName)
  guildName = GetGuildName(guildId)
  if GuildAddon.savedVariables ~= nil and GuildAddon.savedVariables[guildName] then
    CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "[" .. GetTimeString() .. "]|r " .. GuildAddon.var.color.colGreen .. guildName .. ": " .. GuildAddon.var.color.colTeal .. characterName .. GuildAddon.var.color.colRed .. " Removed" .. GuildAddon.var.color.colWhite .. " from the guild")
  end
end

local function GuildSelfJoin(event,guildId,guildName)
  CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "[" .. GetTimeString() .. "]|r " .. GuildAddon.var.color.colGreen .. "Congratulations!"  .. GuildAddon.var.color.colWhite " You are joined to ".. GuildAddon.var.color.colGreen .. guildName)
  CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "Please type /reloadui for make the addon work properly :)")
end

local function GuildSelfLeave(event,guildId,guildName)
  CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "[" .. GetTimeString() .. "]|r " .. GuildAddon.var.color.colWhite " You" .. GuildAddon.var.color.colRed .." left ".. GuildAddon.var.color.colWhite .. guildName)
  CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "Please type /reloadui for make the addon work properly :)")
end

local function GuildMemberCharacterLevelChanged(event,guildId,displayName,characterName,newLevel)
  guildName = GetGuildName(guildId)
  if GuildAddon.savedVariables ~= nil and GuildAddon.savedVariables[guildName] then
    CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "[" .. GetTimeString() .. "]|r " .. GuildAddon.var.color.colGreen .. guildName .. ": " .. GuildAddon.var.color.colTeal .. characterName .. GuildAddon.var.color.colWhite .." has leveled up to " .. GuildAddon.var.color.colGreen .. tostring(newLevel))
  end
end
  
local function GuildMemberCharacterVeteranRankChanged(event,guildId,displayName,newVeteranRank)
  guildName = GetGuildName(guildId)
  if GuildAddon.savedVariables ~= nil and GuildAddon.savedVariables[guildName] then
    CHAT_SYSTEM:AddMessage(GuildAddon.var.color.colWhite .. "[" .. GetTimeString() .. "]|r " .. GuildAddon.var.color.colGreen .. guildName .. ": " .. GuildAddon.var.color.colTeal .. displayName .. GuildAddon.var.color.colWhite .." has leveled up to " .. GuildAddon.var.color.colGreen .. "v" .. tostring(newVeteranRank))
  end
end
  

function Initialize()
	EVENT_MANAGER:RegisterForEvent(GuildAddon.var.appName,EVENT_GUILD_MEMBER_PLAYER_STATUS_CHANGED,GuildAddon.GuildPlayerStatusChanged)
  EVENT_MANAGER:RegisterForEvent(GuildAddon.var.appName,EVENT_GUILD_MEMBER_REMOVED,GuildMemberRemoved)
  EVENT_MANAGER:RegisterForEvent(GuildAddon.var.appName,EVENT_GUILD_MEMBER_ADDED,GuildMemberAdded)
  EVENT_MANAGER:RegisterForEvent(GuildAddon.var.appName,EVENT_GUILD_SELF_LEFT_GUILD,GuildSelfLeave)
  EVENT_MANAGER:RegisterForEvent(GuildAddon.var.appName,EVENT_GUILD_SELF_JOINED_GUILD,GuildSelfJoin)
  EVENT_MANAGER:RegisterForEvent(GuildAddon.var.appName,EVENT_GUILD_MEMBER_CHARACTER_VETERAN_RANK_CHANGED,GuildMemberCharacterVeteranRankChanged)
  EVENT_MANAGER:RegisterForEvent(GuildAddon.var.appName,EVENT_GUILD_MEMBER_CHARACTER_LEVEL_CHANGED,GuildMemberCharacterLevelChanged)
  for i = 1,GetNumGuilds() do
    guildName = GetGuildName(i)
    GuildAddon.var.guilds[i] = guildName
    GuildAddon.var.defaults[guildName] = true
  end
  
end

function ShowMOTD()
	for GuildId = 1 ,GetNumGuilds() do
		d(GuildAddon.var.color.colWhite .. "[" .. GetTimeString().. "]|r " ..  GuildAddon.var.color.colGreen ..GetGuildName(GuildId)..": ".. GuildAddon.var.color.colTeal ..GetGuildMotD(GuildId))
	end
end


function GuildAddon.OnAddOnLoaded(event,addonName)
	if addonName == GuildAddon.var.appName then 
	EVENT_MANAGER:UnregisterForEvent(GuildAddon.var.appName, EVENT_ADD_ON_LOADED)
		Initialize()
    GuildAddon.var.isAddonLoaded = true
		zo_callLater(function()
    GuildAddon.savedVariables = ZO_SavedVars:NewAccountWide("GuildAddonSavedVars",GuildAddon.var.version,nil,GuildAddon.var.defaults)
		ShowMOTD()
		d(GuildAddon.welcomeMsg .. " v".. GuildAddon.var.version)
    GuildAddon.SetGuildAddonUI()
  end,GuildAddon.var.loadWelcomeFuncInterval)
	end
end
  
EVENT_MANAGER:RegisterForEvent(GuildAddon.var.appName,EVENT_ADD_ON_LOADED,GuildAddon.OnAddOnLoaded)

