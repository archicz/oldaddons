// ARCHOS
// -- sh_nadavky
// ARCHOS

ARCHOS.Nadavky = {}

if SERVER then
	util.AddNetworkString("ARCHOS_Nadavky_OpenMenu")
	util.AddNetworkString("ARCHOS_Nadavky_Play")
	local nadavkytable = file.Find("sound/archos/nadavky/*","GAME")
	
	for k,v in pairs(nadavkytable) do
		local str = string.Replace(v,".mp3","")
		local str2 = string.Replace(str,"_"," ")
		
		ARCHOS.Hook.Add("PlayerSay","Nadavky_Chat_"..v,function(ply,text)
			if(string.lower(text) == str2) then
				local str = string.Replace(text," ","_")
				ply:EmitSound("archos/nadavky/"..str..".mp3")
				return ""
			end
		end)
	end
	
	ARCHOS.Hook.Add("ShowSpare1","Nadavky_F3Menu",function(ply)
		net.Start("ARCHOS_Nadavky_OpenMenu")
		net.Send(ply)
	end)
	
	net.Receive("ARCHOS_Nadavky_Play",function(len,ply)
		local str = net.ReadString()
		ply:EmitSound("archos/nadavky/"..str)
	end)
end

if CLIENT then
	net.Receive("ARCHOS_Nadavky_OpenMenu",function()
		local Frame = vgui.Create("DFrame")
		Frame:SetSize(300,280)
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
		FrameLabel:SetText("Nadavky")
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
		
		local nadavkytable = file.Find("sound/archos/nadavky/*","GAME")
		for k,v in pairs(nadavkytable) do
			local str = string.Replace(v,".mp3","")
			local str2 = string.Replace(str,"_"," ")
			
			print("'"..str2.."',")
		end
		
		local List = vgui.Create("DListView",Frame)
		List:SetPos(5,25)
		List:SetSize(290,250)
		List:AddColumn("Path")
		for k,v in pairs(nadavkytable) do
			List:AddLine(v)
		end
		List.OnRowSelected = function()
			net.Start("ARCHOS_Nadavky_Play")
			net.WriteString(nadavkytable[List:GetSelectedLine()])
			net.SendToServer()
		end
	end)
end