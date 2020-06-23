// ARCHOS
// -- cl_nick
// ARCHOS

hook.Add("HUDPaint", "ARCHOS_Nicks", function()
 
	for k,v in pairs ( player.GetAll() ) do
		local Position = ( v:GetPos() + Vector( 0,0,80 ) ):ToScreen()
		local Title = v:GetNWString("archos_title")
		local TitleColor = 0
		
		local hue = math.abs(math.sin(CurTime() *0.9) *335)
		local HSV = HSVToColor(hue, 1, 1)
		
		if(v:IsSuperAdmin() or v:IsAdmin()) then
			TitleColor = HSV
		else
			TitleColor = Color(255,255,255,255)
		end
		
		if(LocalPlayer():GetPos():Distance(v:GetPos()) > 500) then
			draw.DrawText( v:Nick(), "ARCHOS_Nick_500", Position.x, Position.y, team.GetColor(v:Team()), 1 )
		end
		
		if(LocalPlayer():GetPos():Distance(v:GetPos()) < 500) then
			draw.DrawText( v:Nick(), "ARCHOS_Nick_100", Position.x, Position.y, team.GetColor(v:Team()), 1 )
			if Title == nil then
				draw.DrawText( ARCHOS.CurrentLanguage.Usergroups[v:GetUserGroup()], "ARCHOS_Nick_100", Position.x, Position.y+20, team.GetColor(v:Team()), 1 )
			else
				draw.DrawText( Title, "ARCHOS_Title", Position.x, Position.y-25, TitleColor, 1 )
				draw.DrawText( ARCHOS.CurrentLanguage.Usergroups[v:GetUserGroup()], "ARCHOS_Nick_100", Position.x, Position.y+20, team.GetColor(v:Team()), 1 )
			end
		end
	end
 
end)

net.Receive("ARCHOS_Nicks_TitleSet",function()
	chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage["titleset"])
end)
 