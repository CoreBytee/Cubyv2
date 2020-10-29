local Commands = {}


function New(Client)

    local Info = {Prefix = "!"}
    local NewCommand = {Info}

    Client:on("messageCreate", function(MSG)
        
        local Args = {}

        

        local Text = MSG.cleanContent

        if string.sub(Text, 1, 1) ~= Info.Prefix then --[[print("Prefix not found")]] return end

        for C in string.gmatch(string.sub(Text, #Info.Prefix), "%a+") do
            table.insert(Args, string.lower(tostring(C)))
            print(C)
        end

        for i, v in pairs(Args) do
            
        end

        print(Args[1])

        if Args[1] ~= Info.Name then --[[print("Command not found")]] return end

        if Info.Function then
            Info.Function()
        else
            MSG:reply("An internal command error occured: `Command function not found`")
        end

    end)

    

    function NewCommand:SetPrefix(Prefix)
        Info.Prefix = Prefix
    end

    function NewCommand:SetName(Name)
        Info.Name = string.lower(Name)
        print("Name set: " .. Name)
    end

    function NewCommand:SetFunction(Function)
        Info.Function = Function
        print("Function set: " .. Function)
    end

    function NewCommand:SetAliases(TableAliases)
        Info.Aliases = TableAliases
    end

    function NewCommand:SetMinPerm(Perm)
        if Perm == "Owner" or Perm == "Admin" or Perm == "Mod" or Perm == "Vip" or Perm == "User" then
            Info.Perm = Perm
        else
            print("Incorrect Perms")
            return
        end
    end

    function NewCommand:SetDesk(Desk)
        Info.Desk = Desk
        print("Desk set: " .. Desk)
    end

    function NewCommand:NewArg()
        local Argument = {Type = "String", Req = false}
        local Arg = {}

        function Arg:SetType(StringType)
            Argument.Type = StringType
        end

        function Arg:SetReq(BoolReq)
            Argument.Req = BoolReq
        end

        function Arg:SetName(Name)
            Argument.Name = Name
        end


        return Arg
    end

    table.insert(Commands, #Commands + 1, Info)

    return NewCommand
end

local Module = {}

function Module:Init(Client)
    return {Commands = {}, New = function() return New(Client) end, }
end



return Module