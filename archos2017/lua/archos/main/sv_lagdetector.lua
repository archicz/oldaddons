// ARCHOS
// -- sv_lagdetector
// ARCHOS

local lastSysCurrDiff = 9999
local deltaSysCurrDiff = 0

local currcount = 0
local clearTime = 0
local framecount = 0

hook.Add( "Think", "ARCHOS_LagDetector_Think", function()  framecount = framecount + 1  end)

local function GetCurrentDelta()
	local SysCurrDiff = SysTime() - CurTime()
	deltaSysCurrDiff = math.Round(SysCurrDiff - lastSysCurrDiff, 6)
	lastSysCurrDiff = SysCurrDiff
	return deltaSysCurrDiff
end

local lagrange = 0.4
local lagcount = 100
local lagquiet = 3
local lagverbose = 0
local lagcount_meltdown = 320

local function LagMonThreshold()

	if currcount > 0 then
		if RealTime() > clearTime then
			currcount = 0
			umsg.Start("ARCHOS_CHAT_ALL")
			umsg.String("lerp_normalized")
			umsg.End()
			local returnedValue = hook.Run( "ARCHOS_LagDetector_Quiet" )
		end
	end

	local delt = GetCurrentDelta()
	
	if lagverbose == 1 or delt >= lagrange then
		umsg.Start("ARCHOS_CHAT_ALL")
		umsg.String("lerp_big")
		umsg.End()
		
		for k, v in pairs( ents.GetAll() ) do
			local phys = v:GetPhysicsObject()
			if (IsValid(phys)) then
				phys:EnableMotion(false)
			end
		end

		if currcount == lagcount_meltdown then
			local returnedValue = hook.Run( "ARCHOS_LagDetector_High" )
		end
	end
	
	
	if delt < lagrange then
		return false
	end
	
	currcount = currcount + 1
	clearTime = RealTime() + lagquiet
	
	if (currcount == lagcount) then
		return true
	end
	
	
	return false
end

timer.Create("LagDetCheckPerf",1, 0, function()
	if LagMonThreshold() then
		umsg.Start("ARCHOS_CHAT_ALL")
		umsg.String("lerp")
		umsg.End()
		local returnedValue = hook.Run( "ARCHOS_LagDetector_Low" )
	end
	
	framecount = 0
end)