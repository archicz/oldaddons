// ARCHOS
// -- cl_nick
// ARCHOS

local health = 100
local armor = 100
local xps = 0
local level = 0

ARCHOS.Hook.Add("PostDrawOpaqueRenderables","Nicks_3D2D",function()
	if not ARCHOS.CurrentLanguage then return end
	for k,ply in pairs(player.GetAll()) do
		-- Taken from cinema gamemode (Thanks and sorry for using ur code, it's veri najs)
		
		if !ply:Alive() then return end
		
		local hue = math.abs(math.sin(CurTime() *0.9) *335)
		local HSV = HSVToColor(hue, 1, 1)
			
		if(ply:IsSuperAdmin() or ply:IsAdmin()) then
			TitleColor = HSV
		else
			TitleColor = Color(ply:GetNWInt("ARCHOS_Color_Text_r"),ply:GetNWInt("ARCHOS_Color_Text_g"),ply:GetNWInt("ARCHOS_Color_Text_b"),255)
		end
			
		health = Lerp(10*FrameTime(),health,ply:Health()) 
		armor = Lerp(10*FrameTime(),armor,ply:Armor())  
			
		xps = Lerp(10*FrameTime(),xps,ply:GetNWInt("xps")) 
		level = Lerp(10*FrameTime(),level,ply:GetNWInt("level")) 
			
		local title = ply:GetNWString("archos_title")
		local name = ply:GetName()
		local usergroup = ARCHOS.CurrentLanguage.Usergroups[ply:GetUserGroup()]
		
		local pos = ply:GetPos()
		local ang = LocalPlayer():EyeAngles()
		
		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )
		
		if ply:InVehicle() then
			pos = pos + Vector( 0, 0, 30 )
		else
			pos = pos + Vector( 0, 0, 70 )
		end
		
		local dist = LocalPlayer():GetPos():Distance( ply:GetPos() )
		
		local opacity = math.Clamp( 310.526 - ( 0.394737 * dist ), 0, 150 )
		
		opacityScale = opacityScale and opacityScale or 1
		opacity = opacity * opacityScale

		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.05 )		
			draw.DrawText( title, "ARCHOS_Nick_500", 175, -100, Color( TitleColor.r, TitleColor.g, TitleColor.b, opacity ) )
			draw.DrawText( name or "none", "ARCHOS_Nick_500", 200, 0, Color( ARCHOS.Colors["text"].r, ARCHOS.Colors["text"].g, ARCHOS.Colors["text"].b, opacity ) )
			draw.DrawText( usergroup or "none", "ARCHOS_Nick_500", 200, 75, Color( ARCHOS.Colors["text"].r, ARCHOS.Colors["text"].g, ARCHOS.Colors["text"].b, opacity ) )
		cam.End3D2D()
	end
end)

net.Receive("ARCHOS_Nicks_TitleSet",function()
	chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["titleset"])
end)
