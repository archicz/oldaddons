// ARCHOS
// -- cl_servermenu
// ARCHOS

net.Receive("ARCHOS_F2MENU",function()
	
	-- local Frame = vgui.Create("DFrame")
	-- Frame:SetSize(700,400)
	-- Frame:SetVisible(true)
	-- Frame:Center()
	-- Frame:MakePopup()
	-- Frame:ShowCloseButton(false)
	-- Frame:SetTitle(" ")
	-- Frame.Paint = function(s,w,h)
		-- draw.RoundedBox(2,0,0,w,h,ARCHOS.Colors["header"])
	-- end
	
	-- local FrameLabel = vgui.Create("DLabel",Frame)
	-- FrameLabel:SetDark(true)
	-- FrameLabel:SetText("Server Menu")
	-- FrameLabel:SetPos(25,5)
	-- FrameLabel:SetFont("ARCHOS_Text")
	-- FrameLabel:SetColor(ARCHOS.Colors["text"])

	-- local CloseButton = vgui.Create("DButton", Frame)
	-- CloseButton:SetText("X")
	-- CloseButton:SetTextColor(ARCHOS.Colors["text"])
	-- CloseButton:SetPos(Frame:GetWide() - 45, 2)
	-- CloseButton:SetSize(40, 20)
	-- CloseButton.Paint = function(self, w, h)
		-- surface.SetDrawColor(ARCHOS.Colors["closebutton"])
		-- surface.DrawRect(0, 0, w, h)
	-- end
	-- CloseButton.DoClick = function()
		-- Frame:Remove()
		-- Frame = nil
	-- end
	
	-- local Sheet1 = vgui.Create("DPropertySheet",Frame)
	-- Sheet1:Dock(FILL)
	-- Sheet1:SetFadeTime(0.75)
	
	-- local SPanel1 = vgui.Create("DPanel",Sheet1)
	-- local SPanel2 = vgui.Create("DPanel",Sheet1)
	
	-- Sheet1:AddSheet("Server Info",SPanel1,"icon16/information.png")
	-- SPanel1.Paint = function(self,w,h) draw.RoundedBox(4,0,0,w,h,ARCHOS.Colors["background"]) end
	
	-- Sheet1:AddSheet("Client Settings",SPanel2,"icon16/keyboard.png")
	-- SPanel2.Paint = function(self,w,h) draw.RoundedBox(4,0,0,w,h,ARCHOS.Colors["background"]) end
	
	-- if LocalPlayer():IsSuperAdmin() then
		-- local SPanel3 = vgui.Create("DPanel",Sheet1)
		-- Sheet1:AddSheet("Server Settings",SPanel3,"icon16/drive.png")
		-- SPanel3.Paint = function(self,w,h) draw.RoundedBox(4,0,0,w,h,ARCHOS.Colors["background"]) end
	-- end
end)