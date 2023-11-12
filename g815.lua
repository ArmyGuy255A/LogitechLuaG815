local charToKeyMap = {
    ["~"] = {key = "`", shift = true},
    ["!"] = {key = "1", shift = true},
    ["@"] = {key = "2", shift = true},
    ["#"] = {key = "3", shift = true},
    ["$"] = {key = "4", shift = true},
    ["%"] = {key = "5", shift = true},
    ["^"] = {key = "6", shift = true},
    ["&"] = {key = "7", shift = true},
    ["*"] = {key = "8", shift = true},
    ["("] = {key = "9", shift = true},
    [")"] = {key = "0", shift = true},
    ["_"] = {key = "-", shift = true},
    ["+"] = {key = "=", shift = true},
    ["{"] = {key = "[", shift = true},
    ["}"] = {key = "]", shift = true},
    ["|"] = {key = "\\", shift = true},
    [":"] = {key = "semicolon", shift = true},
    ["\""] = {key = "BA", shift = FALSE},
    ["<"] = {key = ",", shift = true},
    [">"] = {key = ".", shift = true},
    ["?"] = {key = "/", shift = true},
    [" "] = {key = "spacebar", shift = false}
}

local cmdToKeyMap = {
    ["t"] = {key = "tab", shift = false},
    ["n"] = {key = "enter", shift = false},
    ["r"] = {key = "enter", shift = false}
}

function OnEvent(event, arg)
    if event == "G_PRESSED" and arg == 2 then -- Assuming G2 key is pressed
        local sequence = "Hello World"
        OutputLogMessage("PRK function called with: "..sequence.."\n")
        -- PRK("for i in range(10):")
        -- PRK("`thello world`n`nHi`n")
        -- PRK("Som3R@nd0mP@ssw0rd")
        PRK(sequence)
    end
end

-- This function will take a string and press the keys on the keyboard to type it out
-- Use the ` character to indicate a command. Commands can be added in the cmdToKeyMap table
function PRK(sequence)
    OutputLogMessage("PRK started. Processing sequence: "..sequence.."\n")
    local skipNext = false
    for i = 1, #sequence do

        -- If the previous character was a command, skip this character
        if skipNext == true then
          skipNext = false
        else
        
            local char = sequence:sub(i, i)
            local keyInfo = charToKeyMap[char] or {key = char, shift = false}
            
            -- If the key is a command, get the key info for the command
            if keyInfo.key == "`" then
                local command = sequence:sub(i + 1, i + 1)
                skipNext = true
                OutputLogMessage("Command Found: "..command.."\n")
                keyInfo = cmdToKeyMap[command]
            end
                
            if keyInfo.shift then
                OutputLogMessage("Pressing Shift for character: "..char.."\n")
                PressKey("lshift")
            end
    
            OutputLogMessage("Pressing key: "..keyInfo.key.."\n")
            PressAndReleaseKey(keyInfo.key)
    
            if keyInfo.shift then
                OutputLogMessage("Releasing Shift for character: "..char.."\n")
                ReleaseKey("lshift")
            end
        end
    end
    OutputLogMessage("PRK finished processing sequence.\n")
end