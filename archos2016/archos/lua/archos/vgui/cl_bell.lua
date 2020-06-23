// ARCHOS
// -- cl_bell
// ARCHOS

function ARCHOS.ShowHourNotification()
	surface.PlaySound("archos/bell.mp3")
	local NPanel = vgui.Create("DNotify")
	NPanel:SetPos(15,15)
	NPanel:SetSize(100,50)

	local bg = vgui.Create("DPanel",NPanel)
	bg:Dock(FILL)
	bg:SetBackgroundColor(ARCHOS.Colors["background"])

	local lbl = vgui.Create("DLabel",bg)
	lbl:SetPos(17,-7)
	lbl:SetSize(128,72)
	lbl:SetText(os.date("%H:%M:%S",os.time()))
	hook.Add("Think","ARCHOS_BELL_Time",function()
		if IsValid(lbl) then
			lbl:SetText(os.date("%H:%M:%S",os.time()))
		else
			hook.Remove("Think","ARCHOS_BELL_Time")
		end
	end)
	lbl:SetTextColor(ARCHOS.Colors["text"])
	lbl:SetFont("ARCHOS_Text")
	lbl:SetWrap(true)

	NPanel:AddItem(bg)
end

hook.Add("Think","ARCHOS_BELL_CheckTime",function()
	local h = os.date("%H",os.time())
	local m = os.date("%M",os.time())
	local s = os.date("%S",os.time())
	if(h == 59 && m == 59 && s == 59) then
		ARCHOS.ShowHourNotification()
	end
end)

concommand.Add("archos_bell_notification",function(ply,cmd,args)
	ARCHOS.ShowHourNotification()
end)