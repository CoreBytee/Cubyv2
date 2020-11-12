return function(Data)

    local Json = require("json")
    --local PP = require('pretty-print')

    Client = Data.Client

    local Channel = Client:getChannel("769510813588914186")
    local Guild = Client:getGuild("657227821047087105")

    local Messages = {
        Amongo = Channel:getMessage("770300036508418098"),
        Counting = Channel:getMessage("775993790783553608"),
        Chain = Channel:getMessage("775995595806474250")
    }

    local Roles = {
        Amongo = Guild:getRole("769574625553678366"),
        Counting = Guild:getRole("775993321457713193"),
        Chain = Guild:getRole("776003260086616084")
    }

    local Reactions = {
        Amongo = Messages.Amongo.reactions:toArray()[1],
        Counting = Messages.Counting.reactions:toArray()[1],
        Chain = Messages.Chain.reactions:toArray()[1]
    }

    local BeginAmounts = {
        Amongo = Reactions.Amongo.count,
        Counting = Reactions.Counting.count,
        Chain = Reactions.Chain.count
    }

    --print(Messages.Amongo.reactions:toArray()[1].count)
    for i, v in pairs(Messages.Amongo.reactions:toArray()) do
        --print(v)
    end

    Client:on("reactionAdd", function(Reaction, UserId)
    
        local User = Client:getUser(UserId)
        local Member = Guild:getMember(UserId)

        if BeginAmounts.Amongo ~= Reactions.Amongo.count then
            Member:addRole(Roles.Amongo.id)
            BeginAmounts.Amongo = Reactions.Amongo.count 
        end

        if BeginAmounts.Counting ~= Reactions.Counting.count then
            Member:addRole(Roles.Counting.id)
            BeginAmounts.Counting = Reactions.Counting.count 
        end
        
        if BeginAmounts.Chain ~= Reactions.Chain.count then
            Member:addRole(Roles.Chain.id)
            BeginAmounts.Chain = Reactions.Chain.count 
        end
        
    end)

    Client:on("reactionRemove", function(Reaction, UserId)
    
        local User = Client:getUser(UserId)
        local Member = Guild:getMember(UserId)

        if BeginAmounts.Amongo ~= Reactions.Amongo.count then
            Member:removeRole(Roles.Amongo.id)
            BeginAmounts.Amongo = Reactions.Amongo.count 
        end

        if BeginAmounts.Counting ~= Reactions.Counting.count then
            Member:removeRole(Roles.Counting.id)
            BeginAmounts.Counting = Reactions.Counting.count 
        end

        if BeginAmounts.Chain ~= Reactions.Chain.count then
            Member:removeRole(Roles.Chain.id)
            BeginAmounts.Chain = Reactions.Chain.count 
        end
        
        
    end)

    --[[
    local Channel = Client:getChannel("769510813588914186")

	local MSG = Channel:send({content = "", embed = {
		title = "**The chain!**",
		description = "React with <:plusbutton:685867382144893013> to play the Chain"
	}})

	local emoji = Client:getGuild("657227821047087105").emojis:find(function(e) return e.name == 'plusbutton' end)

	MSG:addReaction(emoji)
    ]]

    function GetCurrentCount(Topic)

        local Found = false
        local WhatFound = nil
        while Found == false do

            local Last = Guild:getChannel("775694351141175306"):getLastMessage()
            if not tonumber(Last.content) then
                Last:delete()
            else
                WhatFound = tonumber(Last.content)
                Found = true
            end

        end

        print("foudn")
        return tonumber(WhatFound)

    end

    --[[
    local CurrentCount = GetCurrentCount()

    Client:on("messageCreate", function(Message)

        local Channel = Guild:getChannel("775694351141175306")
    
        if Message.channel.id == "775694351141175306" then
            if Message.author.bot then return end
            print(CurrentCount)
            if not tonumber(Message.content) then
                Message:delete()
                print("Deleted")
            end

            local NumberMessage = tonumber(Message.content)
            print(NumberMessage)

            if NumberMessage == CurrentCount + 1 then
                Channel:setTopic("Current Count: " .. NumberMessage)
                CurrentCount = CurrentCount + 1
                print("tes")
                
            else
                Message:delete()
                print("del")
            end
            print("Cur", CurrentCount)
        else
            --print("wrong channel")
        end

    end)]]

end