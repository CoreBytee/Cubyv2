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

            local PreMSG = MSG:reply("Working please wait")

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
            MSGData.Member = MSG.member
            MSGData.PreMSG = PreMSG
            MSGData.Wait = Wait
            MSGData.TableToString = TableToString
    
            --MSG:reply({content = "test", tts = true})
            
            local CommandFound = false
            
            
            for i, v in pairs(Commands) do
                if v.Name == Command then
                    v.Function(MSGData)
                    CommandFound = true
                    break
                else
                    for i, b in pairs(v.Aliases) do
                        if Command == b then
                            v.Function(MSGData)
                            CommandFound = true
                            break
                        end
                    end
                end
            end
            
            
            if CommandFound then
                
            else
                PreMSG:setContent("Command Not found")
                Wait(1)
                PreMSG:delete()
            end
            
    
            
    
        end
    
        
    end)
end