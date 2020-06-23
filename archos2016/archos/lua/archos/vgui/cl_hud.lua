// ARCHOS
// -- cl_hud
// ARCHOS

local health = 100
local armor = 100
local xps = 0
local level = 0
local ping = 0

local tx1 = Material("icon16/information.png")
local tx2 = Material("icon16/coins.png")
local tx3 = Material("icon16/award_star_gold_2.png")

hook.Add("HUDPaint","ARCHOS_HUD_PAINT",function()
	health = Lerp(10*FrameTime(),health,LocalPlayer():Health()) 
	armor = Lerp(10*FrameTime(),armor,LocalPlayer():Armor()) 
	ping = Lerp(10*FrameTime(),ping,LocalPlayer():Ping()) 
	
	xps = Lerp(10*FrameTime(),xps,LocalPlayer():GetNWInt("xps")) 
	level = Lerp(10*FrameTime(),level,LocalPlayer():GetNWInt("level")) 
	
	draw.RoundedBox(0, 5, ScrH() - 140 - 20, 420, 150, ARCHOS.Colors["background"])
	
	draw.RoundedBox(0, 10, ScrH() - 15 - 20, health*4.1, 15, Color(255,0,0,255))
	draw.RoundedBox(0, 10, ScrH() - 35 - 20, armor*4.1, 15, Color(0,255,255,255))
	draw.RoundedBox(0, 10, ScrH() - 55 - 20, ping*4.1, 15, Color(0,255,0,255))
	
	
	draw.SimpleText(math.Round(health), "ARCHOS_Text_Small", 15, ScrH() - 1 - 34, Color(255,255,255,255))
	draw.SimpleText(math.Round(armor), "ARCHOS_Text_Small", 15, ScrH() - 15 - 40, Color(255,255,255,255))
	draw.SimpleText(math.Round(ping), "ARCHOS_Text_Small", 15, ScrH() - 35 - 40, Color(255,255,255,255))
	
	if avatar == nil && LocalPlayer != nil then
		avatar = vgui.Create("AvatarImage")
		avatar:SetSize(64,64)
		avatar:SetPos(10,ScrH() - 135 - 20)
		avatar:SetPlayer(LocalPlayer(),64)
	end
	
	concommand.Add("archos_hud_avatar",function()
		avatar:Remove()
		avatar = nil
	end)
	
	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial(tx1)
	surface.DrawTexturedRect(80,ScrH() - 132 - 20,16,16)
	
	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial(tx2)
	surface.DrawTexturedRect(80,ScrH() - 112 - 20,16,16)
	
	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial(tx3)
	surface.DrawTexturedRect(80,ScrH() - 92 - 20,16,16)
	
	draw.SimpleText(LocalPlayer():Nick().." ["..ARCHOS.CurrentLanguage.Usergroups[LocalPlayer():GetUserGroup()].."]", "ARCHOS_Header", 97, ScrH() - 135 - 20, Color(255,255,255,255))
	draw.SimpleText(math.Round(xps).." XP", "ARCHOS_Text", 97, ScrH() - 115 - 20, Color(255,255,255,255))
	draw.SimpleText("Level "..math.Round(level), "ARCHOS_Text", 97, ScrH() - 95 - 20, Color(255,255,255,255))
end)

hook.Add("HUDShouldDraw","ARCHOS_HUD_REMOVE",function(name)
	local HUD = {"CHudHealth","CHudBattery"}
	for k,element in pairs(HUD)do
		if name==element then return false end
	end
	return true
end)