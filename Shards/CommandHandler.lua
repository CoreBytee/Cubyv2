return function(Data)
    local Client = Data.Client
    local Prefix = Data.Prefix
    local Wait = Data.Libs.Code.Wait
    local Commands = Data.Libs.Tables.Commands
    local WebHooks = Data.Libs.Tables.WebHooks
    local String = string
    local Table = table

    Client:on("messageCreate", function(MSG)
        local Text = string.lower(MSG.content)
        local Channel = MSG.channel
        local Author = MSG.author
        
        
        if String.sub(Text, 1, 1) == Data.Prefix then

            local PreMSG = MSG:reply("Laden")

            local Args = {}
            local MSGData = {}
            
            local Commands = Data.Libs.Tables.Commands
            
            for C in String.gmatch(String.sub(Text, 2), "%a+") do
                Table.insert(Args, String.lower(tostring(C)))
            end
            local Command = Args[1]
            
            Table.remove(Args, 1)
    
            --Creating the data
    
            MSGData.Args = Args
            MSGData.Client = Data.Client
       	    MSGData.MusicClient = Data.MusicClient
            MSGData.OrgMSG = MSG
            MSGData.Author = MSG.author
            MSGData.Guild = MSG.guild
            MSGData.Content = MSG.content
            MSGData.CleanContent = MSG.cleanContent
            MSGData.Member = MSG.member
            MSGData.PreMSG = PreMSG
            MSGData.Wait = Wait
            MSGData.TableToString = TableToString
            MSGData.ShardData = Data
            MSGData.Mentioned = MSG.mentionedUsers
    
            --MSG:reply({content = "test", tts = true})
            
            local CommandFound = false
            local CommandTable = nil
            
            for i, v in pairs(Commands) do
                if v.Name == Command then
                    CommandTable = v
                    
                    --v.Function(MSGData)
                    CommandFound = true
                    break
                else
                    for i, b in pairs(v.Aliases) do
                        if Command == b then
                            CommandTable = v
                            
                            --v.Function(MSGData)
                            CommandFound = true
                            break
                        end
                    end
                end
            end
            
            local Respons = ""
			local Executed = false
			
			--:Cube1::Cube2: 
			--:Cube3::Cube4:
            
            if CommandFound then
                if CommandTable.Perms.User == true then
                    CommandTable.Function(MSGData)
					Executed = true
                end
				
                
                if CommandTable.Perms.Owner == true and MSGData.Author.id == Data.Client.owner.id and Executed == false then
                    CommandTable.Function(MSGData)
					Executed = true
                elseif CommandTable.Perms.Owner == true and Executed == false then
                    Respons = "Alleen **__CoreBite__** kan dit Commando uitvoeren."
                end
				
			
				if CommandTable.Perms.Admin == true and MSGData.Member:hasRole(Data.Libs.Strings.Roles.Admin) and Executed == false then
                    CommandTable.Function(MSGData)
					Executed = true
                elseif CommandTable.Perms.Admin == true and Executed == false then
                    Respons = "Je moet minstens **__ADMIN__** zijn om dit commando uit te voeren."
                end
				
				
                if CommandTable.Perms.Moderator == true and MSGData.Member:hasRole(Data.Libs.Strings.Roles.Moderator) and Executed == false then
                    CommandTable.Function(MSGData)
					Executed = true
                elseif CommandTable.Perms.Moderator == true and Executed == false then
                    Respons = "Je moet minstens **__MODERATOR__** zijn om dit commando uit te voeren."
                end
				
				
				if Executed == false then
                    MSGData.PreMSG:setContent(Respons)
                    print(MSGData.Author.name .. " probeerde het commando: " .. Command .. " geen permissie")
                else
                    print(MSGData.Author.name .. " heeft successvol het commando " .. Command .. " uitgevoerd!")
				end
            else
                PreMSG:setContent("Command Not found")
                Wait(5000)
                PreMSG:delete()
            end
            
    
            
    
        end
    
        
    end)
end