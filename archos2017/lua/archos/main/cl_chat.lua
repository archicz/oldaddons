// ARCHOS
// -- sh_chat
// ARCHOS

usermessage.Hook("ARCHOS_CHAT_ALL",function(data)
	if not ARCHOS.CurrentLanguage then return end
	local str = data:ReadString()
	chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage[str])
end)

usermessage.Hook("ARCHOS_CHAT",function(data)
	if not ARCHOS.CurrentLanguage then return end
	local pl = data:ReadEntity()
	local str = data:ReadString()
	if LocalPlayer == pl then
		chat.AddText(Color(0,255,255),"[ArchOS] ",Color(255,255,255),ARCHOS.CurrentLanguage[str])
	end
end)