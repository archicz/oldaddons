// ARCHOS
// -- sv_colors
// ARCHOS

ARCHOS.Colors = {}
util.AddNetworkString("ARCHOS_Color_SendInfo")

net.Receive("ARCHOS_Color_SendInfo",function(len,ply)
	local header = net.ReadColor()
	local background = net.ReadColor()
	local text = net.ReadColor()
	
	ply:SetNWInt("ARCHOS_Color_Header_r",header.r)
	ply:SetNWInt("ARCHOS_Color_Header_g",header.g)
	ply:SetNWInt("ARCHOS_Color_Header_b",header.b)
	ply:SetNWInt("ARCHOS_Color_Header_a",header.a)
	
	ply:SetNWInt("ARCHOS_Color_Background_r",background.r)
	ply:SetNWInt("ARCHOS_Color_Background_g",background.g)
	ply:SetNWInt("ARCHOS_Color_Background_b",background.b)
	ply:SetNWInt("ARCHOS_Color_Background_a",background.a)
	
	ply:SetNWInt("ARCHOS_Color_Text_r",text.r)
	ply:SetNWInt("ARCHOS_Color_Text_g",text.g)
	ply:SetNWInt("ARCHOS_Color_Text_b",text.b)
	ply:SetNWInt("ARCHOS_Color_Text_a",text.a)
end)