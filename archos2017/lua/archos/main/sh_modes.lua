// ARCHOS
// -- sh_modes
// ARCHOS

if SERVER then
	util.AddNetworkString("ARCHOS_Modes_OpenMenu")
	
	ARCHOS.Hook.Add("ShowSpare2","Modes_F4Menu",function(ply)
		net.Start("ARCHOS_Modes_OpenMenu")
		net.Send(ply)
	end)
end

if CLIENT then
	net.Receive("ARCHOS_Modes_OpenMenu",function()
		local Frame = vgui.Create("DFrame")
		Frame:SetSize(400,95)
		Frame:SetVisible(true)
		Frame:Center()
		Frame:MakePopup()
		Frame:ShowCloseButton(false)
		Frame:SetTitle(" ")
		Frame.Paint = function(s,w,h)
			draw.RoundedBox(2,0,0,w,h,ARCHOS.Colors["header"])
		end
		
		local PVPModePanel = vgui.Create("DPanel",Frame)
		PVPModePanel:SetPos(5,5)
		PVPModePanel:SetSize(390,40)
		PVPModePanel.Paint = function(s,w,h)
			draw.RoundedBox(2,0,0,w,h,ARCHOS.Colors["background"])
		end
		
		local PVPModeTitle = vgui.Create("DLabel",PVPModePanel)
		PVPModeTitle:SetText(ARCHOS.CurrentLanguage["pvpmode_title"])
		PVPModeTitle:SetPos(5,5)
		PVPModeTitle:SetSize(200,20)
		PVPModeTitle:SetFont("ARCHOS_Header")
		
		local PVPModeDesc = vgui.Create("DLabel",PVPModePanel)
		PVPModeDesc:SetText(ARCHOS.CurrentLanguage["pvpmode_desc"])
		PVPModeDesc:SetPos(5,20)
		PVPModeDesc:SetSize(500,20)
		PVPModeDesc:SetFont("ARCHOS_Text_Small")
		
		local PVPModeBtn = vgui.Create("DButton",PVPModePanel)
		PVPModeBtn:SetText("")
		PVPModeBtn:SetPos(0,0)
		PVPModeBtn:SetSize(390,40)
		PVPModeBtn.DoClick = function()
			RunConsoleCommand("archos_pvp_on")
			Frame:Close()
		end
		PVPModeBtn.Paint = function(s,w,h)
			surface.SetDrawColor(Color(0,0,0,0))
			surface.DrawRect(0, 0, w, h)
		end
		
		local BuildModePanel = vgui.Create("DPanel",Frame)
		BuildModePanel:SetPos(5,50)
		BuildModePanel:SetSize(390,40)
		BuildModePanel.Paint = function(s,w,h)
			draw.RoundedBox(2,0,0,w,h,ARCHOS.Colors["background"])
		end
		
		local BuildModeTitle = vgui.Create("DLabel",BuildModePanel)
		BuildModeTitle:SetText(ARCHOS.CurrentLanguage["buildmode_title"])
		BuildModeTitle:SetPos(5,5)
		BuildModeTitle:SetSize(200,20)
		BuildModeTitle:SetFont("ARCHOS_Header")
		
		local BuildModeDesc = vgui.Create("DLabel",BuildModePanel)
		BuildModeDesc:SetText(ARCHOS.CurrentLanguage["buildmode_desc"])
		BuildModeDesc:SetPos(5,20)
		BuildModeDesc:SetSize(500,20)
		BuildModeDesc:SetFont("ARCHOS_Text_Small")
		
		local BuildModeBtn = vgui.Create("DButton",BuildModePanel)
		BuildModeBtn:SetText("")
		BuildModeBtn:SetPos(0,0)
		BuildModeBtn:SetSize(390,40)
		BuildModeBtn.DoClick = function()
			RunConsoleCommand("archos_pvp_off")
			Frame:Close()
		end
		BuildModeBtn.Paint = function(s,w,h)
			surface.SetDrawColor(Color(0,0,0,0))
			surface.DrawRect(0, 0, w, h)
		end
	end)
end