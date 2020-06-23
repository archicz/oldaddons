// ARCHOS
// -- cl_colors
// ARCHOS

ARCHOS.Colors = {}
ARCHOS.Colors["closebutton"] = Color(200, 79, 79)

function ARCHOS.Colors.ChangeTextColor(clr)
	cookie.Set("ARCHOS_Color_Text_r",clr.r)
	cookie.Set("ARCHOS_Color_Text_g",clr.g)
	cookie.Set("ARCHOS_Color_Text_b",clr.b)
	cookie.Set("ARCHOS_Color_Text_a",clr.a)
	ARCHOS.Colors.Load()
end

function ARCHOS.Colors.ChangeBackgroundColor(clr)
	cookie.Set("ARCHOS_Color_Background_r",clr.r)
	cookie.Set("ARCHOS_Color_Background_g",clr.g)
	cookie.Set("ARCHOS_Color_Background_b",clr.b)
	cookie.Set("ARCHOS_Color_Background_a",clr.a)
	ARCHOS.Colors.Load()
end

function ARCHOS.Colors.ChangeHeaderColor(clr)
	cookie.Set("ARCHOS_Color_Header_r",clr.r)
	cookie.Set("ARCHOS_Color_Header_g",clr.g)
	cookie.Set("ARCHOS_Color_Header_b",clr.b)
	cookie.Set("ARCHOS_Color_Header_a",clr.a)
	ARCHOS.Colors.Load()
end

function ARCHOS.Colors.Load()
	ARCHOS.Colors["header"] = Color(cookie.GetNumber("ARCHOS_Color_Header_r",44),cookie.GetNumber("ARCHOS_Color_Header_g",62),cookie.GetNumber("ARCHOS_Color_Header_b",80),cookie.GetNumber("ARCHOS_Color_Header_a",255))
	ARCHOS.Colors["background"] = Color(cookie.GetNumber("ARCHOS_Color_Background_r",52),cookie.GetNumber("ARCHOS_Color_Background_g",73),cookie.GetNumber("ARCHOS_Color_Background_b",94),cookie.GetNumber("ARCHOS_Color_Background_a",255))
	ARCHOS.Colors["text"] = Color(cookie.GetNumber("ARCHOS_Color_Text_r",255),cookie.GetNumber("ARCHOS_Color_Text_g",255),cookie.GetNumber("ARCHOS_Color_Text_b",255),cookie.GetNumber("ARCHOS_Color_Text_a",255))
	
	net.Start("ARCHOS_Color_SendInfo")
	net.WriteColor(ARCHOS.Colors["header"])
	net.WriteColor(ARCHOS.Colors["background"])
	net.WriteColor(ARCHOS.Colors["text"])
	net.SendToServer()
end

function ARCHOS.Colors.Default()
	ARCHOS.Colors.ChangeTextColor(Color(255,255,255,255))
	ARCHOS.Colors.ChangeBackgroundColor(Color(52,73,94,255))
	ARCHOS.Colors.ChangeHeaderColor(Color(44,62,80,255))
end

concommand.Add("archos_colors_default",function()
	ARCHOS.Colors.Default()
end)

ARCHOS.Hook.Add("InitPostEntity","Colors_Load",function()
	ARCHOS.Colors.Load()
end)

concommand.Add("archos_colors_hsv",function(ply,cmd,args)
	ARCHOS.Hook.Add("Think","ColorsHSV",function()
		local hue = math.abs(math.sin(CurTime() *0.9) *335)
		local HSV = HSVToColor(hue, 1, 1)
		local HSV2 = HSVToColor(hue, 1, 0.8)

		ARCHOS.Colors["header"] = HSV
		ARCHOS.Colors["background"] = HSV2
	end)
end)

concommand.Add("archos_colors_hsv_off",function(ply,cmd,args)
	hook.Remove("Think","ARCHOS_ColorsHSV")
	ARCHOS.Colors.Load()
end)

ARCHOS.Colors.Load()