return function(Link)

    local Parse = require("url").parse

    local Parsed = Parse(Link or "")
    --print(Link)

    --print(Parsed.hostname)

    local HostNames = {
        "www.youtube.com",
        "youtube.com",
        "youtu.be",
        "www.youtu.be",

    }

    local Found = false

    for i, v in pairs(HostNames) do

        if Parsed.hostname == v then
            Found = true
            break
        end

    end

    local FirstUrl = require("Code/Website/GetParams")(Parsed.path)

    if FirstUrl.v then
        NewUrl = "http://www.youtube.com/watch?v=" ..FirstUrl.v
    else
        NewUrl = Link
    end

    return Found, NewUrl

end