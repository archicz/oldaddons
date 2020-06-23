// ARCHOS
// -- cl_scoreboard
// ARCHOS

timer.Create("ARCHOS_Fix",5,2,function()
	function GAMEMODE:ScoreboardShow()
		return true
	end
end)


hook.Add("ScoreboardShow","ARCHOS_SCOREBOARD_SHOW",function()

	Frame = vgui.Create("DFrame")
	Frame:SetSize(750,500)
	Frame:Center()
	Frame:SetTitle("")
	Frame:SetDraggable(false)
	Frame:ShowCloseButton(false)
	Frame.Paint = function(s,w,h)
		draw.RoundedBox(4,0,0,w,h,ARCHOS.Colors["header"])
	end
	Frame:MakePopup()
	
	Hostname = vgui.Create("DLabel",Frame)
	Hostname:SetText(GetHostName())
	Hostname:SetPos(10,-230)
	Hostname:SetSize(750,500)
	Hostname:SetFont("ARCHOS_Header_Large")
	
	local ScrollPanel = vgui.Create( "DScrollPanel", Frame )
	ScrollPanel:SetPos(8,40)
	ScrollPanel:SetSize(750,417)
	
	ScrollPanel:GetVBar().Paint = function() return true end
	ScrollPanel:GetVBar().btnUp.Paint = function() return true end
	ScrollPanel:GetVBar().btnDown.Paint = function() return true end
	ScrollPanel:GetVBar().btnGrip.Paint = function() return true end
	function ScrollPanel:OnScrollbarAppear() return true end
	
	for k,v in pairs(player.GetAll()) do
		local Panel = vgui.Create("DPanel",ScrollPanel)
		Panel:SetPos(0,k*51-45)
		Panel:SetSize(750,50)
		Panel.Paint = function(s,w,h)
			draw.RoundedBox(2,0,0,w,h,ARCHOS.Colors["background"])
		end
		
		local Avatar = vgui.Create("AvatarImage",Panel)
		Avatar:SetSize(50,50)
		Avatar:SetPos(0,0)
		Avatar:SetPlayer(v,64)
		
		local AvatarProfile = vgui.Create("DButton",Panel)
		AvatarProfile:SetSize(50,50)
		AvatarProfile:SetPos(0,0)
		AvatarProfile:SetText("")
		AvatarProfile.DoClick = function()
			v:ShowProfile()
		end
		AvatarProfile.Paint = function(s,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255,255,255,0))
		end
		
		local Nick = vgui.Create("DLabel",Panel)
		local title = v:GetNWString("archos_title")
		if string.len(title) > 0 then
			Nick:SetText(v:Nick().." ("..title.." )")
		else
			Nick:SetText(v:Nick())
		end
		Nick:SetPos(55,-90)
		Nick:SetSize(1000,200)
		Nick:SetFont("ARCHOS_Header")
		
		
		local Rank = vgui.Create("DLabel",Panel)
		Rank:SetText(ARCHOS.CurrentLanguage.Usergroups[v:GetUserGroup()])
		if v:IsAdmin() or v:IsSuperAdmin() then
			Rank:SetPos(65,-75)
			local RightsIcon = vgui.Create("DButton",Panel)
			RightsIcon:SetSize(10,10)
			RightsIcon:SetPos(54,18)
			RightsIcon:SetText("")
			RightsIcon:SetTooltip(ARCHOS.CurrentLanguage["isadmin"])
			RightsIcon.Icon = Material("icon16/user_orange.png")
			RightsIcon.Paint = function(s,w,h)
				surface.SetMaterial(s.Icon)
				surface.SetDrawColor(255,255,255,255)
				surface.DrawTexturedRect(0,0,w,h)
			end
		else
			Rank:SetPos(55,-75)
		end
		Rank:SetSize(200,200)
		Rank:SetFont("ARCHOS_Text_Small")
		
		local XPLevel = vgui.Create("DLabel",Panel)
		XPLevel:SetText(v:GetNWInt("xps").."XP / Level "..v:GetNWInt("level"))
		XPLevel:SetPos(55,-60)
		XPLevel:SetSize(400,200)
		XPLevel:SetFont("ARCHOS_Text_Small")
		
		local MuteButton = vgui.Create("DButton",Panel)
		MuteButton:SetSize(16,16)
		MuteButton:SetPos(716,35)
		MuteButton:SetText("")
		MuteButton:SetTooltip("Mute/Unmute")
		MuteButton.MuteIcon = Material("icon16/sound_mute.png")
		MuteButton.UnmuteIcon = Material("icon16/sound.png")
		MuteButton.DoClick = function()
			if v:IsMuted() then
				v:SetMuted(false)
			else
				v:SetMuted(true)
			end
		end
		MuteButton.Paint = function(s,w,h)
			if v:IsMuted() then
				surface.SetMaterial(s.MuteIcon)
			else
				surface.SetMaterial(s.UnmuteIcon)
			end
			surface.SetDrawColor(255,255,255,255)
			surface.DrawTexturedRect(0,0,w,h)
		end
		
		local Teleport = vgui.Create("DButton",Panel)
		Teleport:SetSize(16,16)
		Teleport:SetPos(700,35)
		Teleport:SetText("")
		Teleport:SetTooltip("Teleport")
		Teleport.Icon = Material("icon16/bullet_go.png")
		Teleport.Paint = function(s,w,h)
			surface.SetMaterial(s.Icon)
			surface.SetDrawColor(255,255,255,255)
			surface.DrawTexturedRect(0,0,w,h)
		end
		Teleport.DoClick = function()
			RunConsoleCommand("ulx","goto",v:Nick())
		end
		
		if LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin() then
			local AdminMenu = vgui.Create("DButton",Panel)
			AdminMenu:SetSize(16,16)
			AdminMenu:SetPos(685,35)
			AdminMenu:SetText("")
			AdminMenu:SetTooltip("Admin Menu")
			AdminMenu.Icon = Material("icon16/application_view_list.png")
			AdminMenu.Paint = function(s,w,h)
				surface.SetMaterial(s.Icon)
				surface.SetDrawColor(255,255,255,255)
				surface.DrawTexturedRect(0,0,w,h)
			end
			AdminMenu.DoClick = function()
				local Menu = DermaMenu() 
				
				local sMenuArchOS = Menu:AddSubMenu("ArchOS")
				local sMenuULX = Menu:AddSubMenu("ULX")
				
				local sMenuArchOS_AddXP = sMenuArchOS:AddOption("Přidat XP",function()
					Derma_StringRequest(
						"ArchOS",
						ARCHOS.CurrentLanguage["scoreboard_typeinxp"],
						"",
						function(text)
							net.Start("ARCHOS_Scoreboard_AddXP")
							net.WriteEntity(v)
							net.WriteFloat(tonumber(text))
							net.SendToServer()
						end,
						function(text) end
					)
				end)
				sMenuArchOS_AddXP:SetIcon("icon16/coins_add.png")
				
				local sMenuArchOS_TakeXP = sMenuArchOS:AddOption("Odebrat XP",function()
					Derma_StringRequest(
						"ArchOS",
						ARCHOS.CurrentLanguage["scoreboard_typeinxp"],
						"",
						function(text)
							net.Start("ARCHOS_Scoreboard_TakeXP")
							net.WriteEntity(v)
							net.WriteFloat(tonumber(text))
							net.SendToServer()
						end,
						function(text) end
					)
				end)
				sMenuArchOS_TakeXP:SetIcon("icon16/coins_delete.png")
				
				local sMenuArchOS_SetLevel = sMenuArchOS:AddOption("Nastavit Level",function()
					Derma_StringRequest(
						"ArchOS",
						ARCHOS.CurrentLanguage["scoreboard_typeinlevel"],
						"",
						function(text)
							net.Start("ARCHOS_Scoreboard_SetLevel")
							net.WriteEntity(v)
							net.WriteFloat(tonumber(text))
							net.SendToServer()
						end,
						function(text) end
					)
				end)
				sMenuArchOS_SetLevel:SetIcon("icon16/award_star_gold_2.png")
				
				local sMenuArchOS_SetXP = sMenuArchOS:AddOption("Nastavit XP",function()
					Derma_StringRequest(
						"ArchOS",
						ARCHOS.CurrentLanguage["scoreboard_typeinxp"],
						"",
						function(text)
							net.Start("ARCHOS_Scoreboard_SetXP")
							net.WriteEntity(v)
							net.WriteFloat(tonumber(text))
							net.SendToServer()
						end,
						function(text) end
					)
				end)
				sMenuArchOS_SetXP:SetIcon("icon16/coins.png")
				
				local sMenuArchOS_RepairDB = sMenuArchOS:AddOption("Opravit Databázi",function()
					net.Start("ARCHOS_Scoreboard_FixDB")
					net.WriteEntity(v)
					net.SendToServer()
				end)
				sMenuArchOS_RepairDB:SetIcon("icon16/wrench_orange.png")
				
				local sMenuULX_Kick = sMenuULX:AddOption("Vyhodit",function()
					Derma_StringRequest(
						"ArchOS",
						ARCHOS.CurrentLanguage["scoreboard_reason"],
						"",
						function(text)
							RunConsoleCommand("ulx","kick",v:Nick(),text)
						end,
						function(text) end
					)
				end)
				sMenuULX_Kick:SetIcon("icon16/door_out.png")
				
				local sMenuULX_Jail = sMenuULX:AddOption("Jail",function()
					Derma_StringRequest(
						"ArchOS",
						ARCHOS.CurrentLanguage["scoreboard_reason_jail"],
						"",
						function(text)
							RunConsoleCommand("ulx","jail",v:Nick(),tonumber(text))
						end,
						function(text) end
					)
				end)
				sMenuULX_Jail:SetIcon("icon16/door.png")
				
				local sMenuULX_Ragdoll = sMenuULX:AddOption("Ragdoll",function()
					RunConsoleCommand("ulx","ragdoll",v:Nick())
				end)
				sMenuULX_Ragdoll:SetIcon("icon16/monkey.png")
				
				local sMenuULX_UnRagdoll = sMenuULX:AddOption("Unragdoll",function()
					RunConsoleCommand("ulx","unragdoll",v:Nick())
				end)
				sMenuULX_UnRagdoll:SetIcon("icon16/stop.png")
				
				Menu:Open()
			end
			
			hook.Add("Think","ARCHOS_Scoreboard_Think"..v:EntIndex(),function()
				if !IsValid(v) then
					Panel:Remove()
				end
			end)
		end
		
	end
	
	hook.Add("ScoreboardHide","ARCHOS_SCOREBOARD_HIDE",function()
		Frame:Close()
		for k,v in pairs(player.GetAll()) do
			hook.Remove("Think","ARCHOS_Scoreboard_Think"..v:EntIndex())
		end
	end)
end)
