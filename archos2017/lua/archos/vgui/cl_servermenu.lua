// ARCHOS
// -- cl_servermenu
// ARCHOS

net.Receive("ARCHOS_F2MENU",function()
	
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(700,400)
	Frame:SetVisible(true)
	Frame:Center()
	Frame:MakePopup()
	Frame:ShowCloseButton(false)
	Frame:SetTitle(" ")
	Frame.Paint = function(s,w,h)
		draw.RoundedBox(2,0,0,w,h,ARCHOS.Colors["header"])
	end
	
	local FrameLabel = vgui.Create("DLabel",Frame)
	FrameLabel:SetDark(true)
	FrameLabel:SetText("Server Menu")
	FrameLabel:SetPos(5,5)
	FrameLabel:SetSize(200,20)
	FrameLabel:SetFont("ARCHOS_Text")
	FrameLabel:SetColor(ARCHOS.Colors["text"])

	local CloseButton = vgui.Create("DButton", Frame)
	CloseButton:SetText("X")
	CloseButton:SetTextColor(ARCHOS.Colors["text"])
	CloseButton:SetPos(Frame:GetWide() - 45, 2)
	CloseButton:SetSize(40, 20)
	CloseButton.Paint = function(self, w, h)
		surface.SetDrawColor(ARCHOS.Colors["closebutton"])
		surface.DrawRect(0, 0, w, h)
	end
	CloseButton.DoClick = function()
		Frame:Remove()
		Frame = nil
	end
	
	local Sheet1 = vgui.Create("DPropertySheet",Frame)
	Sheet1:Dock(FILL)
	Sheet1:SetFadeTime(0.75)
	
	local SPanel1 = vgui.Create("DPanel",Sheet1)
	local SPanel2 = vgui.Create("DPanel",Sheet1)
	
	Sheet1:AddSheet("Server Info",SPanel1,"icon16/information.png")
	
	Sheet1:AddSheet("Client Settings",SPanel2,"icon16/keyboard.png")
	
	local Processor = vgui.Create("DPanel",SPanel1)
	Processor:SetPos(5,5)
	Processor:SetSize(200,35)
	
	local cpu_ico = vgui.Create("DImage",Processor)
	cpu_ico:SetPos(5,5)
	cpu_ico:SetSize(25,25)
	cpu_ico:SetImage("archos/cpu.png")
	
	local Processor_name = vgui.Create("DLabel",Processor)
	Processor_name:SetPos(32,5)
	Processor_name:SetSize(200,10)
	Processor_name:SetTextColor(color_black)
	Processor_name:SetFont("HudSelectionText")
	Processor_name:SetText(ARCHOS.ServerInfo.Processor.name)
	
	local Processor_ghz = vgui.Create("DLabel",Processor)
	Processor_ghz:SetPos(32,17)
	Processor_ghz:SetSize(200,10)
	Processor_ghz:SetTextColor(color_black)
	Processor_ghz:SetText(ARCHOS.ServerInfo.Processor.freq)
	
	local Ram = vgui.Create("DPanel",SPanel1)
	Ram:SetPos(205,5)
	Ram:SetSize(200,35)
	
	local ram_ico = vgui.Create("DImage",Ram)
	ram_ico:SetPos(5,5)
	ram_ico:SetSize(25,25)
	ram_ico:SetImage("archos/ram.png")
	
	local Ram_name = vgui.Create("DLabel",Ram)
	Ram_name:SetPos(32,5)
	Ram_name:SetSize(200,10)
	Ram_name:SetTextColor(color_black)
	Ram_name:SetFont("HudSelectionText")
	Ram_name:SetText(ARCHOS.ServerInfo.Ram.name)
	
	local Ram_ghz = vgui.Create("DLabel",Ram)
	Ram_ghz:SetPos(32,17)
	Ram_ghz:SetSize(200,10)
	Ram_ghz:SetTextColor(color_black)
	Ram_ghz:SetText(ARCHOS.ServerInfo.Ram.freq)
	
	local HDD = vgui.Create("DPanel",SPanel1)
	HDD:SetPos(405,5)
	HDD:SetSize(265,35)
	
	local HDD_ico = vgui.Create("DImage",HDD)
	HDD_ico:SetPos(5,5)
	HDD_ico:SetSize(25,25)
	HDD_ico:SetImage("archos/hdd.png")
	
	local HDD_name = vgui.Create("DLabel",HDD)
	HDD_name:SetPos(32,-2)
	HDD_name:SetSize(200,25)
	HDD_name:SetTextColor(color_black)
	HDD_name:SetFont("HudSelectionText")
	HDD_name:SetText(ARCHOS.ServerInfo.HDD.name)
	
	local HDD_speed = vgui.Create("DLabel",HDD)
	HDD_speed:SetPos(32,17)
	HDD_speed:SetSize(200,10)
	HDD_speed:SetTextColor(color_black)
	HDD_speed:SetText(ARCHOS.ServerInfo.HDD.speed)
	
	net.Start("ARCHOS_F2MENU_ServerInfo_Rcv")
	net.SendToServer()
	
	net.Receive("ARCHOS_F2MENU_ServerInfo_Snd",function()
		local uptime = net.ReadFloat()
		local entities = net.ReadFloat()
		local props = net.ReadFloat()
		
		local ServerInfoPanel = vgui.Create("DPanel",SPanel1)
		ServerInfoPanel:SetPos(5,40)
		ServerInfoPanel:SetSize(200,35)
		
		local ServerInfo_Uptime = vgui.Create("DLabel",ServerInfoPanel)
		ServerInfo_Uptime:SetPos(5,0)
		ServerInfo_Uptime:SetSize(200,25)
		ServerInfo_Uptime:SetTextColor(color_black)
		ServerInfo_Uptime:SetFont("HudSelectionText")
		ServerInfo_Uptime:SetText("Uptime")
		
		local ServerInfo_Uptime_txt = vgui.Create("DLabel",ServerInfoPanel)
		ServerInfo_Uptime_txt:SetPos(5,11)
		ServerInfo_Uptime_txt:SetSize(200,25)
		ServerInfo_Uptime_txt:SetTextColor(color_black)
		ServerInfo_Uptime_txt:SetText(os.date("%H:%M:%S",uptime))
		
		local ServerInfoPanel2 = vgui.Create("DPanel",SPanel1)
		ServerInfoPanel2:SetPos(205,40)
		ServerInfoPanel2:SetSize(200,35)
		
		local ServerInfo_Entities = vgui.Create("DLabel",ServerInfoPanel2)
		ServerInfo_Entities:SetPos(5,0)
		ServerInfo_Entities:SetSize(200,25)
		ServerInfo_Entities:SetTextColor(color_black)
		ServerInfo_Entities:SetFont("HudSelectionText")
		ServerInfo_Entities:SetText("Entities")
		
		local ServerInfo_Entities_txt = vgui.Create("DLabel",ServerInfoPanel2)
		ServerInfo_Entities_txt:SetPos(5,11)
		ServerInfo_Entities_txt:SetSize(200,25)
		ServerInfo_Entities_txt:SetTextColor(color_black)
		ServerInfo_Entities_txt:SetText(entities)
		
		local ServerInfoPanel3 = vgui.Create("DPanel",SPanel1)
		ServerInfoPanel3:SetPos(405,40)
		ServerInfoPanel3:SetSize(265,35)
		
		local ServerInfo_Props = vgui.Create("DLabel",ServerInfoPanel3)
		ServerInfo_Props:SetPos(5,0)
		ServerInfo_Props:SetSize(200,25)
		ServerInfo_Props:SetTextColor(color_black)
		ServerInfo_Props:SetFont("HudSelectionText")
		ServerInfo_Props:SetText("Props")
		
		local ServerInfo_Props_txt = vgui.Create("DLabel",ServerInfoPanel3)
		ServerInfo_Props_txt:SetPos(5,11)
		ServerInfo_Props_txt:SetSize(200,25)
		ServerInfo_Props_txt:SetTextColor(color_black)
		ServerInfo_Props_txt:SetText(props)
		
	end)
	
	local Mixer1 = vgui.Create("DColorMixer",SPanel2)
	Mixer1:SetLabel("Background")
	Mixer1:SetSize(200,100)
	Mixer1:SetPalette(false)
	Mixer1:SetAlphaBar(true)
	Mixer1:SetWangs(false)
	Mixer1:SetColor(ARCHOS.Colors["background"])
	function Mixer1:ValueChanged(clr)
		ARCHOS.Colors.ChangeBackgroundColor(clr)
	end
	
	local Mixer2 = vgui.Create("DColorMixer",SPanel2)
	Mixer2:SetLabel("Header")
	Mixer2:SetSize(200,100)
	Mixer2:SetPos(0,100)
	Mixer2:SetPalette(false)
	Mixer2:SetAlphaBar(true)
	Mixer2:SetWangs(false)
	Mixer2:SetColor(ARCHOS.Colors["header"])
	function Mixer2:ValueChanged(clr)
		ARCHOS.Colors.ChangeHeaderColor(clr)
	end
	
	local Mixer3 = vgui.Create("DColorMixer",SPanel2)
	Mixer3:SetLabel("Text Color")
	Mixer3:SetSize(200,100)
	Mixer3:SetPos(0,200)
	Mixer3:SetPalette(false)
	Mixer3:SetAlphaBar(true)
	Mixer3:SetWangs(false)
	Mixer3:SetColor(ARCHOS.Colors["text"])
	function Mixer3:ValueChanged(clr)
		ARCHOS.Colors.ChangeTextColor(clr)
	end
	
	local Reset = vgui.Create("DButton",SPanel2)
	Reset:SetText("Reset")
	Reset:SetPos(0,300)
	Reset:SetSize(200,30)
	Reset.DoClick = function()
		ARCHOS.Colors.Default()
	end
	
	Vol = vgui.Create("DNumSlider",SPanel2)
	Vol:SetPos(210,0)
	Vol:SetSize(250,50)
	Vol:SetText("Raveball Volume")
	Vol:SetMin(1)
	Vol:SetMax(100)
	Vol:SetDecimals(0)
	Vol:SetValue(cookie.GetNumber("archos_raveball_volume",100))
	Vol.OnValueChanged = function(self,value)
		cookie.Set("archos_raveball_volume",value)
	end
	
	local Title = vgui.Create("DTextEntry",SPanel2)
	Title:SetPos(210,45)
	Title:SetSize(200,20)
	Title:SetText("Title")
	Title.OnEnter = function(self)
		RunConsoleCommand("say","!title "..self:GetValue())
	end
	
	if LocalPlayer():IsSuperAdmin() then
		local SPanel3 = vgui.Create("DPanel",Sheet1)
		Sheet1:AddSheet("Server Settings",SPanel3,"icon16/drive.png")
		SPanel3.Paint = function(self,w,h) draw.RoundedBox(4,0,0,w,h,ARCHOS.Colors["background"]) end
	end
end)