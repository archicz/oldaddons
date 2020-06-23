// ARCHOS
// -- sv_reputation
// ARCHOS



-- local preparedQuery = ARCHOS.db:prepare("INSERT INTO users (`steamid`, `rep_good`, `rep_bad`, `rep_friendly`, `rep_funny`, `rep_builder`) VALUES(?, ?, ?, ?, ?, ?)")
-- function preparedQuery:onSuccess(data)
	-- print("Rows inserted successfully!")
-- end

-- function preparedQuery:onError(err)
	-- print("An error occured while executing the query: " .. err)
-- end

-- preparedQuery:setString(1, "STEAM_0:0:123456")
-- preparedQuery:setNumber(2, math.random(1,10))
-- preparedQuery:setNumber(3, math.random(1,10))
-- preparedQuery:setNumber(4, math.random(1,10))
-- preparedQuery:setNumber(5, math.random(1,10))
-- preparedQuery:setNumber(6, math.random(1,10))
-- preparedQuery:start()