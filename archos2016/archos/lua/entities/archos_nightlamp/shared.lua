AddCSLuaFile("shared.lua")
ENT.Base 	= "base_anim"

ENT.PrintName 		= "Noční světlo"
ENT.Author 			= "ArchiCZ"
ENT.Information 	= ""
ENT.Category 		= "ArchOS [Other]"

ENT.Spawnable 		= true
ENT.AdminOnly 		= true

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "IsOn" );
end