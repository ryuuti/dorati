LuaR  

         ;   %     %@   %    %À  e  ¥@ ¥  ¥À ¥   ¥@ ¥  ¥À ¥   ¥@ ¥    @ @C CÃ        Ä@C @DÃ   @ @C D@ ÀC  DûÀD @   À@     Àùù@A @ Àø            EditNametoStatus        isim        setHexMemory        filerebort        tyuui        Main 
       tblchoice        active        Button        ButtonA        ButtonB        logaut        EXIT        gg 
       isVisible        FSQRT       ð?       setVisible        clearResults        isMainActive              Æ @ Ç Ê Æ @ @  A@Ç @  @Ç Ê             Status        type        Num          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end                                                        Name               Tag               value                  _ENV               F @ G@À   ]   À@  @ @@Á   @     @ ÆA ÇÀÁ GAÂ GÂÝÀ                    gg        getRangesList        libSGF                split_config.arm64_v8a.apk        0x        string        format        %X       ð?       start          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end                            	   	   	   	   	                                                          startAddress              aralik                 _ENV    !    0    @  Ë   A  F@ GÁÀ Á ]ÀFBA GÁËÂ   ÊCB BÊ  A CÊ]BACbA  ãAûFAB GÁÃ] @FD C ] XÀ C _ @FAB GAÄC ]A C  _             isim                string        gmatch        %S%S        table        insert        address        flags        gg 
       TYPE_BYTE        value        r       ð?       sonuc 
       setValues        type        alert          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end 0                                                                                                                                                !   	          offset     0          hex     0          startAddress    0          t    0          hepsi    0          (for generator) 	             (for state) 	             (for control) 	             h 
                _ENV #        8  %   e@  À  ÀË   ÀË   À     À    AA  Ý@ À    AÁ Á  ÂË  ÁË  ÁÝ@ À    AA Á  ÂË  ÁË  ÁÝ@ À    A Á Ý@ À    A A Ý@ À    A Á Ý@ Æ @ ÇÀÀÀÁÀ    A A Ý@ À    A Á Ý@ Æ @ ÇÀÀ@ÂÀ    A Á  ÂË  ÁË  ÁÝ@ À    AA Á  ÂË  ÁË  ÁÝ@ À    A Á Ý@ À    A Á Ý@ Æ @ ÇÀÀÇ@ÂÇÀÀ ÅÀ    A Á Ý@ À    AA  Ý@ Æ @ ÇÀÀÇ@ÂÇÀÀ@ÅÀ    AÁ Á Ý@ À    AA  Ý@ Á  AG K  
A   KA JÇJÄJÁ JÈ  Ë  BI FI Â	 ] ÊAJ FJ ÊAÁË  BI FI 
 ] ÊAJ FJ ÊAÁJ À     KA JÇJÄJÁ JÁÊ  Ë  BI FI 
 ] ÊAJ FJ ÊAÁË  BI FI  ] ÊAJ FJ ÊAÁJ À     KA JÇJÄJÁ JËA Ë  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FJ ÊAJ FBI ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁJ À     KA JÇJÄJÁ JÎÁ Ë  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FJ ÊAJ FBI ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁJ À     KA JÇJÄJÁ JÁÎ  Ë  BI FBI ÊAJ FJ ÊAÁË  BI FBI ÊAJ FJ ÊAÁJ À  Á  AG K  
A   K JÏJÆJÁ JÎA  Ë  ÊAP   FJ 
ÂÐFBI 
ÑÊ¡ÁJA  Ë  ÊQ   FJ 
ÂÑFBI 
ÒÊ¡ÁJ¢ À     KA JÏJÆJÁ JAÎA  Ë  ÊAR   FJ 
ÒFBI 
ÂÒÊ¡ÁJ¢ À     K JÏJÆJÁ JAÌA  Ë  ÊAP   FJ 
ÂÐFBI 
ÓÊ¡ÁJA  Ë  ÊAS   FJ 
ÓFBI 
ÂÓÊ¡ÁJ¢ À     K JÏJÆJÁ JÌA  Ë  ÊT   FJ 
ÂÐFBI 
ÓÊ¡ÁJA  Ë  ÊAT   FJ 
ÔFBI 
ÂÔÊ¡ÁJ¢ À     K JÏJÁÆJÁ JÍA  Ë  ÊU   FJ 
BÕFBI 
ÕÊ¡ÁJ  Ë  ÊÁU   FJ 
ÖFBI 
ÂÔÊ¡ÁË  ÊAV   FJ 
ÖFBI 
ÂÔÊ¡ÁJ¢ À     K JÏJÁÆJÁ JAÍA  Ë  ÊÁV   FJ 
ÂÐFBI 
×Ê¡ÁJ  Ë  ÊAW   FJ 
×FBI 
ÂÔÊ¡ÁË  ÊAW   FJ 
Â×FBI 
ÂÔÊ¡ÁJ¢ À     K JÏJÁÆJÁ JÍ  Ë  ÊX   FJ 
ÂÐFBI 
×Ê¡ÁË  ÊAX   FJ 
ÂÐFBI 
×Ê¡ÁJ  Ë  ÊX   FJ 
Â×FBI 
ÂÔÊ¡ÁË  ÊÁX   FJ 
Â×FBI 
ÂÔÊ¡ÁJ¢ À     KA JÏJÁÆJÁ JÙA  Ë  ÊAY   FJ 
ÔFBI 
ÂÔÊ¡ÁJ¢ À     KA JÏJÁÆJÁ JÙA  Ë  ÊÁY   FJ 
ÚFBI 
ÂÔÊ¡ÁJ¢ À     KA JÏJÁÆJÁ JAÚA  Ë  ÊZ   FJ 
ÂÚFBI 
ÂÔÊ¡ÁJ¢ À     K JÏJÁÆJÁ JÁÍA  Ë  Ê[   FJ 
BÕFBI 
ÕÊ¡ÁJA  Ë  ÊA[   FJ 
ÂÚFBI 
ÂÔÊ¡ÁJ¢ À     K JÏJÅJÁ JÉA  Ë  Ê[  FJ 
ÂÛFI  ] 
ÜFI Â	 ] 
BÜFI 
 ] 
ÜÊ¡ÁJA  Ë  ÊÁ\  FJ 
ÂÛFI  ] 
ÝFI Â	 ] 
BÝFI 
 ] 
ÝÊ¡ÁJ¢ À     KA JÏJÅJÁ JAÊA  Ë  ÊÁ]  FJ 
ÞFI  ] 
BÞFI Â	 ] 
ÞFI 
 ] 
ÂÞÊ¡ÁJ¢ À     K JÏJÅJÁ JAËA  Ë  Ê_   FJ 
BßFBI 
ßÊ¡ÁJA  Ë  ÊÁ_   FJ 
àFBI 
BàÊ¡ÁJ¢ À     K JÏJÅJÁ JË  Ë  Ê`   FJ 
ÂÐFBI 
×Ê¡ÁË  ÊÁ`   FJ 
ÂÐFBI 
×Ê¡ÁJA  Ë  Êa   FJ 
BáFBI 
áÊ¡ÁJ¢ À     K JÏJÅJÁ JÁËA  Ë  ÊÁa   FJ 
âFBI 
BâÊ¡ÁJA  Ë  Êb   FJ 
ÂâFBI 
ãÊ¡ÁJ¢ À     K JÏJÅJÁ JÁÌA  Ë  ÊAc   FJ 
ãFBI 
ÂãÊ¡ÁJA  Ë  Êd   FJ 
BäFBI 
äÊ¡ÁJ¢ À     K JÏJÅJÁ JÌ  Ë  ÊÁd   FJ 
åFBI 
BåÊ¡ÁË  Êe   FJ 
ÂåFBI 
æÊ¡ÁJ  Ë  ÊAf   FJ 
æFBI 
ÂæÊ¡ÁË  Êg   FJ 
BçFBI 
çÊ¡ÁJ¢ À     K JÏJÅJÁ JÏA  Ë  ÊÁg   FJ 
èFBI 
BèÊ¡ÁJA  Ë  Êh   FJ 
èFBI 
BèÊ¡ÁJ¢ À     K JÏJÅJÁ JAÏA  Ë  ÊÁh   FJ 
éFBI 
BéÊ¡ÁJ  Ë  Êi   FJ 
ÂéFBI 
ÂÔÊ¡ÁË  Êj   FJ 
BêFBI 
êÊ¡ÁJ¢ À    «   
       choicetbl        type        choice        value        order        â ï¸æ³¨æäºé â ï¸        tyuui        ä¸æ¬è¨­å®        multiChoice        åå¥è¨­å®        ã¹ã¯ãªããå±¥æ­´åé¤        fileremove        ã­ã°ã¢ã¦ã        logaut        ã¹ã¯ãªããçµäº 
       Scriptend        NoneA        ButtonA        æ»ã        back        ãã­ããç³» 
       ç¡å¹ç³»        NoneB        ButtonB        drop 
       éãã        end        Mukou       ð?       Status        A        Tag        Num        Name        ããããåééå»¶(UG)        toggle        åé        on        S_        @       off        ã·ã«éå»¶       @       ããããåééå»¶(PC) 
       å®å¸ç¨        ã¯ã³ãã³        æµã¿ã¼ã³ç¡å¹ 
       ã¹ã³ã¢        ã¢ã¤ãã æ³¥ç¡å¹        å¦æªæ³¥ç¡å¹        éµæ¼åºã¹ã­ãã        ãªã¶ã«ãã¹ã­ãã        ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹        ä¼è©±ç¡å¹        è«ç¼é¡ç¡å¹        å°å°ç¡å¹        ç¢ºæ³¥(å¦æª)        ç¢ºæ³¥ã¨ã©ã¼åé¿        ã¢ã¤ãã å¨åç¨        åæå¢ç¨ã¹ã­ãã "       ãã¥ã¼ããªã¢ã«ã¹ã­ãã        ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾        B        LD        offset    @° A       E        h F0 B5 03 AF        h 70 47 00 00        N     A       h F6 03 1F 2A        h 20 11 22 2A    àÜ|A       h E0 03 1F 2A        h 20 00 80 52        h 00 20 70 47     A       h F3 03 1F 2A        h 33 00 80 52    à¬ A   @úA       h FD 7B BA A9        h C0 03 5F D6    @A       h B0 B5 02 AF        h 70 47 02 AF    ØëûA       h FF 83 03 D1    `-"A       h FF 03 03 D1     ©)A       h 70 47 03 AF    @DA       h FF 83 01 D1        h FF 43 02 D1    ;A   àòA   p8A   °®­A       ã©ã³ã­ã³ã°ç¡å¹    °ÿ A       ã¹ã³ã¢ã¿ç¡å¹    @ª½A       h FF C3 05 D1        éµä¾¿ç¡å¹     c¢A       h FF C3 02 D1    À&A   ÐÏ­A   ` A       h 4D 62 50 3F        h 3D 0A 57 3F        h F6 28 5C 3F        h 0A D7 63 3F    à¦A       h 9A 99 59 3F        h 52 B8 5E 3F        h 66 66 66 3F    `V A       h 00 18 28 1E        h 00 50 2A 1E         h 00 D0 28 1E         h 00 10 28 1E     ÀáA       h C2 68 01 2A        h C2 68 00 2A    àýA       h 81 00 00 54        h 80 00 00 54    `ËA   àÛA   `p_A       h 96 83 08 91        h 96 07 00 91     ûA       h 00 29 18 BF        h 01 29 00 00     Y_A       h 01 00 15 8B        h 21 B3 A0 D2    à»A       h 02 28 00 F0        h 01 28 00 F0    íXA       h 1F 0C 00 71        h 1F 04 00 71     ÌA       h C4 00 78 B1        h C4 00 78 B9     ÌA       h D0 F8 10 11        h 00 00 10 11    :A       h 01 09 40 B9        h 1F 09 40 B9     :A       h 21 03 00 34        h 21 03 00 35    @p®A       h 01 01 01 01        h 00 00 00 00    ð9A    ¥A       h F8 B5 04 AF        h 70 47 04 AF    × A       h FF 03 01 D1    °sA       h 21 00 80 52        h E1 03 1F 2A    $   +    7   KÀ  @ J @@ @    @ JÀ@ J A J @A @       JA @       J ÀA @       J B Ç A @ B Ç @ À ÇÀ@ @@B ÇB AB GB AA       ÀB  CÆ@B B Ç A @À@ @C              type 
       isEnabled        off        Num        Name        toggle        N        LD        Status        group        Tag        table        insert       ð?         4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end 7   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   %   &   &   &   '   '   '   '   '   (   (   (   (   (   (   (   (   (   )   )   )   )   )   )   )   *   *   *   +             args     7          value    7             _ENV ,   0       Ü@    Æ @ Ç@ÀÊ Ü@    Æ @ ÇÀÕ ÍÀÀA    @ @
A     
       choicetbl        value        order       ð?         4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end    -   -   -   -   -   .   .   .   .   .   .   /   /   /   /   /   0             address               Name               value               i                 _ENV      4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end 8  +   0   1   1   1   1   1   1   1   2   3   3   3   3   3   4   4   4   4   4   4   4   4   4   4   5   5   5   5   5   5   5   5   5   5   6   6   6   6   6   7   7   7   7   7   8   8   8   8   8   9   9   9   :   :   :   :   :   ;   ;   ;   ;   ;   <   <   <   =   =   =   =   =   =   =   =   =   =   >   >   >   >   >   >   >   >   >   >   @   @   @   @   @   A   A   A   A   A   B   B   B   B   B   C   C   C   C   C   D   D   D   D   D   E   E   E   E   E   F   F   F   F   F   G   G   G   G   G   L   M   M   M   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   N   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   P   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   R   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   S   V   W   W   W   X   X   X   X   X   X   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   X   Z   [   [   [   [   [   [   \   \   \   \   \   \   \   \   \   \   \   [   \   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   _   _   _   _   _   _   _   _   _   _   _   ]   _   `   `   `   `   `   `   a   a   a   a   a   a   a   a   a   a   a   b   b   b   b   b   b   b   b   b   b   b   `   b   c   c   c   c   c   c   d   d   d   d   d   d   d   d   d   d   d   e   e   e   e   e   e   e   e   e   e   f   f   f   f   f   f   f   f   f   f   c   f   g   g   g   g   g   g   h   h   h   h   h   h   h   h   h   h   h   i   i   i   i   i   i   i   i   i   i   j   j   j   j   j   j   j   j   j   j   g   j   k   k   k   k   k   k   l   l   l   l   l   l   l   l   l   l   m   m   m   m   m   m   m   m   m   m   n   n   n   n   n   n   n   n   n   n   o   o   o   o   o   o   o   o   o   o   k   o   r   r   r   r   r   r   s   s   s   s   s   s   s   s   s   s   s   r   s   t   t   t   t   t   t   u   u   u   u   u   u   u   u   u   u   u   t   u   v   v   v   v   v   v   w   w   w   w   w   w   w   w   w   w   w   v   w   x   x   x   x   x   x   y   y   y   y   y   y   y   y   y   y   y   z   z   z   z   z   z   z   z   z   z   z   x   z                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
       AddStatus    8         Addchoicetbl    8         address 
   8         i    ¬         i ­  7            _ENV     ¸     7    @ @@ A   Z À  A @A A @ÀA  B A@ @ B @ ÀA ÀB C  @ ÀA  C  A@ X@  ÀÀA  BÁ   Ö @ B @ ÀA  DÄÄ@EÀE¥      ÀFÀFÇÇ    È  @   #          os        date        %Y%m%d%H%M        202411302359        _G        NN        4.130.0        gg        alert |       âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã        EXIT        setVisible        getTargetPackage        com.Level5.YWP \       ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã
PackageName:         folderPatch 
       FILES_DIR        shoki 	       success2        on        [ON]        off        [OFF]        S_        Status        TYPE                 ver        Sver       @       Fver        group        isMainActive     ±   ³       A      Á@  VÀ _              [        ]         4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end    ²   ²   ²   ²   ²   ³             Num                  4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end 7   ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¢   ¢   ¢   ¢   £   £   ¥   ¥   ¥   ¥   ¦   ¦   ¦   §   ¨   ¨   ©   ©   ©   ©   ©   ©   ª   ª   ¬   ¬   ¬   ­   ®   ¯   °   ³   ±   ´   ´   ´   ´   ´   ´   µ   µ   ¶   ·   ·   ¸             application    7          package    7             _ENV        Koumoku ¹   K    3    @ A@  @  e   ¥@  å  À åÀ  Àå    @   A  @  A  @    %A @ ] [  @A A  ÀAA ÆA ÇÁÁ ÆB CBGB ÝB ¢  #þÁB CÁA A C A @ Á@ A             folderPatch        Dorati_script_rebort_file.txt        Uwagaki        fileremove        shoki        pairs        Status        B        ButtonB        Name 
       isEnabled        gg        toast .       ååã®ãã¼ã¿ããå¾©åããã¾ãã        Main    ¼   Å       F @ G@À    Á  ][   @ Á@Á @     @                  io        open        r        shoki         close          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end    ½   ½   ½   ½   ½   ¾   ¾   ¿   À   À   Á   Á   Á   Ã   Ã   Å             path               file                 _ENV Ç   Û    Z   F @ G@À   Á  ][@  À@  AÁ@ @ A ÀA@    Æ B Ç@Â  A   VÝ@Æ B Ç@Â  AÁ C ACVÝ@Á C ÁC A á@ÆB ÇAÂ  FC GÂÃGGÄB ÆC ÇÂÃÇÇÄVÂÝAà üÁ C ÁD A á@ÆB ÇAÂ  FC GÂÄGGÄB ÆC ÇÂÄÇÇÄVÂÝAà üÆ E   Ý  BÅ Á ÂBâ  cþÌÀÅ Ý@ ÆÀ@ Ç ÆA Ý@             io        open        w        gg        alert -       ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã:         os        exit        table        insert        TYPE:        ver:        Status        Sver       ð?       A        Name        : 
       isEnabled        B        ipairs        write        
        close        toast '       ãã¡ã¤ã«ãä½æããã¾ãã:            4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end Z   È   È   È   È   È   É   É   Ê   Ê   Ê   Ê   Ë   Ë   Ë   Í   Î   Î   Î   Î   Î   Î   Î   Ï   Ï   Ï   Ï   Ï   Ï   Ï   Ï   Ð   Ð   Ð   Ð   Ð   Ð   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ð   Ó   Ó   Ó   Ó   Ó   Ó   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ó   Ö   Ö   Ö   Ö   ×   ×   ×   ×   ×   Ö   Ö   Ù   Ù   Ú   Ú   Ú   Ú   Û             type     Z          file    Z   	       Kakikomi    Z          (for index) #   3          (for limit) #   3          (for step) #   3          i $   2          (for index) 8   H          (for limit) 8   H          (for step) 8   H          i 9   G          (for generator) K   S          (for state) K   S          (for control) K   S          _ L   Q          value L   Q             _ENV 	       filePath Ý   ñ     [    @ @@ E    @  FÀ@ G Á @ ]@ FA GÀÁ ]@ K    B @BÀ   FÁB GÃA@ B @BÀ  A FÁB GÃA@À ÆÀB Ç ÄÕ Á ¡@B ABÀ ÂB DBBDA ÂB DBÂDA  üÀ ÆÀB Ç ÅÕ Á ¡@B ABÀ ÂB EBBDA ÂB EBÂDA  ü@E À    ÌE @ Â VÝA¢  #þ F @ À@ @FÁ @             io        open        w        gg        alert 0       ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã:         os        exit        table        insert        TYPE:        Status        TYPE        ver:        ver       ð?       A        Name        : 
       isEnabled        B        ipairs        write        
        close        toast *       ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã:            4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end [   Þ   Þ   Þ   Þ   Þ   ß   ß   à   à   à   à   á   á   á   ã   ä   ä   ä   ä   ä   ä   ä   ä   å   å   å   å   å   å   å   å   æ   æ   æ   æ   æ   æ   ç   ç   ç   ç   ç   ç   ç   ç   ç   ç   ç   ç   ç   ç   æ   é   é   é   é   é   é   ê   ê   ê   ê   ê   ê   ê   ê   ê   ê   ê   ê   ê   ê   é   ì   ì   ì   ì   í   í   í   í   í   ì   ì   ï   ï   ð   ð   ð   ð   ñ             file    [   	       Kakikomi    [          (for index) $   4          (for limit) $   4          (for step) $   4          i %   3          (for index) 9   I          (for limit) 9   I          (for step) 9   I          i :   H          (for generator) L   T          (for state) L   T          (for control) L   T          _ M   R          value M   R             _ENV 	       filePath ó   þ           @  À @@ E  À    @HÀ@ Á @AÁ @   Á ÀAÁ    Ö @  À @B@   
          os        remove        shoki        gg        toast '       ãã¡ã¤ã«ãåé¤ããã¾ãã:         alert *       ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã:         exit            4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end    ô   ô   õ   õ   õ   õ   ÷   ÷   ø   ù   ù   ù   ù   ù   û   û   û   û   û   û   ü   ü   ü   þ             result              err                 Koumoku        _ENV 	       filePath        !    @ @@ K   ÁÀ   d@   Á@  A À  ÂC   _  À@B  E   ]@ ÀB  E    ]@ @C @ FC ]@ C  _              gg        choice        "UG" or "PC(NOX)" 	       "PC(LD)"        ã¹ã¯ãªããçµäº "       ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼         FSQRT       ð¿      ð?       N        @       LD       @       EXIT          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end !                                   
  
  
  
  
                                    TYPE3 
   !             _ENV 
       Shokifile   =    	N    @ @@ E    @   FÀ@   ]@ F@A ]@ A    ÌÀA A Ý @   Ì@B Ý@ ÆB ÁB CÝ B FÁB GAÃ FÁB GÃXÀÃÀ FÁB GÃ Ä À  FÁB ÁB ADJC _ @ C  _ ÆD ÇÀÄ  A ÝÀÛ      FÁB GÁ[   FÁB GÁGAÅ[  @FE ÁA   ]A @ FÁB JMÁ  ð            io        open        r        print *       ãã¡ã¤ã«ãéãã¾ããã§ãã:         EXIT       ð?       read        *line        close 	       tonumber        Status        ver        Fver        TYPE        N        LD        Sver        string        match        ([^:]+):(.+) 
       isEnabled        EditNametoStatus           4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end N                             "  #  %  %  %  %  &  &  '  '  (  (  (  (  )  )  )  )  *  *  *  *  *  *  *  *  +  +  ,  ,  ,  ,  -  -  .  0  0  3  3  3  3  3  4  4  4  4  4  4  4  4  5  5  5  5  5  6  6  6  6  6  6  8  8  ;  ;  =            file    N          i    N          line    N          ver    1          Fver    1          key 6   L          value 6   L             _ENV 	       filePath       4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end 3   »   »   »   Å   Û   ñ   Ý   þ   ó                           =  ?  ?  @  @  A  A  A  B  B  B  B  B  C  C  C  C  C  B  B  F  F  F  F  G  G  G  I  I  K     	       filePath    3          fileExists    3   
       Shokifile    3          TYPE2 
   3          processFile    3          success    3          (for generator) !   )          (for state) !   )          (for control) !   )          _ "   '          value "   '             _ENV        Koumoku M  Z        @ @@ A  À  Á  A A Á Á B A Â V @             gg        alert /       â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸
 V       ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã
 D       ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã
        ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã
        ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã
 %       â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ
 r       ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã
 \       ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã
 \       ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã
 Y       ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end    N  N  O  P  Q  R  S  T  U  V  W  X  W  N  Z                _ENV \  c       @@À@ A A@ A XÀA À  B @ @B @   
          isMainActive        FSQRT       ð¿
       tblchoice        è£½ä½è:ãã©ã 
       choicetbl         Uwagaki        Main          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end    ]  ^  _  _  _  _  _  _  `  `  a  a  c                _ENV e  ¨         Ë     F@ AÀ ]@
@ Â@À X@A @ ÆA ÇB ÆÃA ÇÂ  @ ÝCÆÃA ÇÂ  @ DB 	B	VÝCÇÃÂ ÇCÊÀ¢  #û@ÂA BÀ  BÂA BÀ  Bb  ãÁôe  C ÇAÃ ÁÀ   @   Ä @A    @BÃ C@  Ë    FÃC  ] 	@ ]D  
@	  	ÀX@AÀX@Á@FD @ FÄA GÂ ÁD   ]D FÄA GÂÁD  ]D @FÄA GÂ À ]DFÄA GÂÀ]DbC  ãöAC  ÁC aCG[  G[  À FD Ç]D`ý À @  À    [  ÂD Á B D À  BÛ  @ B              ipairs        order        string        match        %a         group        table        insert        Status 
       isEnabled        value        gg        type        multiChoice        pairs        on       ð?       Button        print        A        back    u     
9   C      Ã     F  À A  @A@ÆÀ ÇA @ÀÁ@ÀÀ B A Á@Å AÀAAAÆAÛA    ÁÁ    @À  ÆABÇÁÂÁBÆÀ ÇA  A  C   À  @             value        type        table 
       tblchoice        back        string        match                 ^Button        Status 
       isEnabled        active           4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end 9   v  v  v  v  v  w  w  w  w  w  w  w  w  w  w  x  x  x  x  x  x  x  y  y  y  y  z  {  {  {  {  {  {  {  {  {  {  |  }  ~                                              key     9          a    9          b    9          c    9          d    9          cache    9          type1 &   +             tbl2        tbl        _ENV        str        tbl3      4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end    f  g  h  i  i  i  i  j  j  j  j  j  j  j  k  k  k  k  k  l  l  l  l  l  m  m  m  m  m  m  m  m  m  n  n  n  k  k  o  q  q  q  q  q  r  r  r  r  r  i  i                                                                                                                                                                                        ¡  ¡  ¡  ¢  ¢  ¢  ¢  ¥  ¥  ¦  ¦  ¨            str               tbl               tbl2              tbl3              tbl4              (for generator)    3          (for state)    3          (for control)    3          _    1          value    1          (for generator)    &          (for state)    &          (for control)    &          _    $          v    $          filter 4             choices ;             a <             b <             c <             type1 G             Name G      
       isEnabled G             (for generator) J   r          (for state) J   r          (for control) J   r          key K   p          (for index) u             (for limit) u             (for step) u             i v                _ENV ª  ¼   :   F @ G@À    Á  ][    FÀ@ ]@ F A ]@  F @ G@À    Á@ ][    A _  F @ G@À    ÁÀ ][    F B ]@ E  ]@ Â Ã ÃÀCF @ G@À    Á  ][    F@D ]@  F @ G@À    Á ][   @ FÀD ]@             string        match        ^tyuui$        tyuui        Main        ^back$        back        ^fileremove        fileremove 	       success2        isMainActive         shoki        FSQRT       ð?	       ^logaut$        logaut        ^Scriptend$        EXIT          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end :   «  «  «  «  «  «  «  ¬  ¬  ­  ­  ­  ®  ®  ®  ®  ®  ®  ®  ¯  ¯  ¯  °  °  °  °  °  °  °  ±  ±  ²  ²  ³  ´  µ  ¶  ¶  ·  ·  ·  ·  ·  ·  ·  ¸  ¸  ¸  ¹  ¹  ¹  ¹  ¹  ¹  ¹  º  º  ¼            value     :             _ENV        ShokiSettei ¾  á   :      Á   %  @ ] [  ÀAA  ÁA  aF@ GÂÀ ÆA   Ý ]B  `ÁýF@ GÁÀ ÆAA ]AF@ GÁÀ Á ]AFÁA GÂ Ä    ] [  ÀAB  À BA@FB GAGÁÂAB  À C   BA B    C A                   ð?       table        insert        S_        off 
       éãã        gg        choice        _G        Status 
       isEnabled        on    Â  Ð    )       @ @      @À E  @ À FÀÀ   G G Á   FÀ AA]FÁ ÂA ]  [  À @  IbA  ãü"  £ û Y   @        
          ButtonA        print        pairs        Status        N        E 	       tonumber        match 
       %[(%d+)%]                   4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end )   Ã  Ã  Ã  Ä  Ä  Æ  Æ  Æ  Ç  Ç  Ç  Ç  Ç  Ç  Ç  È  È  È  È  É  É  É  É  É  Ê  Ê  Ê  Ê  Ê  Ë  È  È  Ç  Ç  Ï  Ï  Ï  Ï  Ï  Ï  Ð  
          (for generator)    "          (for state)    "          (for control)    "          _               n               (for generator)               (for state)               (for control)               key              index                 type1        _ENV        Name 	       tblcount      4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end :   À  À  Ð  Ò  Ò  Ò  Ò  Ó  Ó  Ó  Ó  Ô  Ô  Ô  Ô  Ô  Ô  Ô  Ó  Ö  Ö  Ö  Ö  Ö  ×  ×  ×  ×  ×  Ù  Ù  Ù  Ù  Ù  Ù  Ú  Ú  Û  Û  Û  Û  Û  Ü  Þ  Þ  Þ  ß  ß  ß  ß  ß  ß  ß  ß  ß  ß  ß  á            type1     :          Name     :          tbl    :   	       tblcount    :          filetr    :          (for index) 
             (for limit) 
             (for step) 
             i              choices #   *          state .   9             _ENV ã  é       @ Æ@@ Ç ÇÀ  ÆÁ@  GB  ÝA ¢  #þ A À   A @ @ A ÀAÀ     Ö @             pairs        Status        toggle        ButtonB        EditNametoStatus 
       isEnabled        gg        toast          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end    ä  ä  ä  ä  ä  ä  å  å  å  å  å  ä  ä  ç  ç  ç  ç  ç  è  è  è  è  è  è  é            Name        
       isEnabled               (for generator)              (for state)              (for control)              key              value                 _ENV ë  ù   0   Æ @ Ç @ A@@   A    Á  G[   FA ] BA ÇÁÃÁC Bb  ãþFB   ÁA   ]A @  ÀFB GÁÂ  À Á]A  FB GÁÂ  Á   AB A^ _              Status        TYPE        LD        N        pairs        setHexMemory        offset        E        EditNametoStatus 
       isEnabled        gg        toast        ã¯        ã«ã¯å¯¾å¿ãã¦ãã¾ãã          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end 0   ì  ì  í  í  í  í  í  í  í  í  ï  ï  ï  ð  ð  ð  ð  ñ  ñ  ñ  ñ  ñ  ð  ð  ô  ô  ô  ô  ô  õ  õ  õ  õ  õ  õ  õ  õ  õ  ÷  ÷  ÷  ÷  ÷  ÷  ÷  ÷  ÷  ù  
          Name     0   
       isEnabled     0          data     0          cache    0          type 
   0          (for generator)              (for state)              (for control)              _              v                 _ENV û  
    	"     A   @  Á  Á  A A $@ FA    ] ÀÁA BÀB ÖA ÁA BÀ ÖA b  ã@üFÀB G Ã ]@ FÀB G@Ã  ]@      =       /data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/        /data/data/        /data/user/0/ 0       /data/data/com.Ymd.Modz64/blackbox/data/user/0/ 5       /data/data/top.niunaijun.dog64/blackbox/data/user/0/ ;       /data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/        ipairs        os        remove 1       com.Level5.YWP/files/.library/ywp_cud/data00.cud 1       com.Level5.YWP/files/.library/ywp_cud/data01.cud        gg        processKill        toast        ã­ã°ã¢ã¦ããã¾ãã          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end "   ü  ý  þ  ÿ                                                     	  	  	  	  
            paths    "          (for generator)              (for state)              (for control)              _              path                 _ENV           @ A@  @  @ A  @  @ AÀ  @  A @A @ A ÀA @  A  B C  @   	          print        ä½æè:ãã©ã        2æ¬¡éå¸ãè»¢å£²ç¦æ­¢        (X)Twitterâ@ryuuti_puni        gg        skipRestoreState        os        exit        setVisible          4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end                                                          _ENV     4i      function EditNametoStatus(Name,Tag,value)
    Status[Name][Tag] = value
    Status[Status[Name]["type"]][Status[Name]["Num"]][Tag] = value
end
function isim()
    local startAddress
    local aralik = gg.getRangesList("libSGF")
    if #aralik <= 0 then
        aralik = gg.getRangesList("split_config.arm64_v8a.apk")
    end
    if #aralik > 0 then
        -- æåã®ç¯å²ã®startã¢ãã¬ã¹ãåå¾ãã
        startAddress = "0x"..string.format("%X", aralik[1].start)
        return startAddress
    end
    return nil
end

function setHexMemory(offset, hex)
    local startAddress = isim()
    local t, hepsi = {}, 0
    for h in string.gmatch(hex, "%S%S") do
        table.insert(t, {address = startAddress + offset + hepsi, flags = gg.TYPE_BYTE,value = h .. "r"})
        hepsi = hepsi + 1
    end
    sonuc = gg.setValues(t)
    if type(sonuc) ~= 'string' then
        return true
    else
        gg.alert(sonuc)
        return false
    end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args["type"],isEnabled = args["isEnabled"] or off, Num = args["Num"], Name = args["Name"] , toggle = args["toggle"] or nil, N = args["N"] or nil, LD = args["LD"] or nil}
        Status[args["Name"]] = value
        Status[args["type"]][args["Num"]] = value
        group[args["Tag"]] = group[args["Tag"]] or {}
        table.insert(group[args["Tag"]], args["Name"])
        return args["Num"] +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl)["value"][Name] = value
        local i = #(address or choicetbl)["order"] + 1
        (address or choicetbl)["order"][i] = Name
    end
    choicetbl = {["type"] = "choice",["value"] = {},["order"] = {}}
    local address = nil
    Addchoicetbl(address,"â ï¸æ³¨æäºé â ï¸","tyuui")
    Addchoicetbl(address,"ä¸æ¬è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"åå¥è¨­å®",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ã¹ã¯ãªããå±¥æ­´åé¤","fileremove")
    Addchoicetbl(address,"ã­ã°ã¢ã¦ã","logaut")
    Addchoicetbl(address,"ã¹ã¯ãªããçµäº","Scriptend")
    address = choicetbl["value"]["ä¸æ¬è¨­å®"]
    Addchoicetbl(address,"NoneA","ButtonA")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]
    Addchoicetbl(address,"ãã­ããç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"ç¡å¹ç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    --Addchoicetbl(address,"ã²ã¼ãç³»",{["type"]= "multiChoice",["value"] = {},["order"] = {}})
    Addchoicetbl(address,"NoneB","ButtonB")
    Addchoicetbl(address,"æ»ã","back")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ãã­ããç³»"]
    Addchoicetbl(address,"drop","ButtonB")
    Addchoicetbl(address,"éãã","end")
    address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ç¡å¹ç³»"]
    Addchoicetbl(address,"Mukou","ButtonB")
    Addchoicetbl(address,"éãã","end")
    --address = choicetbl["value"]["åå¥è¨­å®"]["value"]["ã²ã¼ãç³»"]
    --Addchoicetbl(address,"gate","ButtonB")
    --Addchoicetbl(address,"éãã","end")
    if true then
        local i = 1
        Status["A"] = {}
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(UG)", ["toggle"] = {["åé"] = {[on] = S_(2), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ããããåééå»¶(PC)", ["toggle"] = {["åé"] = {[on] = S_(3), [off] = off}, ["ã·ã«éå»¶"] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "å®å¸ç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},["ç¢ºæ³¥(å¦æª)"] = {[on] = on, [off] = off}, ["ç¢ºæ³¥ã¨ã©ã¼åé¿"] = {[on] = on, [off] = off}}})
        --i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "Yãå¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off}, }})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "ã¢ã¤ãã å¨åç¨", ["toggle"] = {["ã¯ã³ãã³"] = {[on] = on, [off] = off}, ["æµã¿ã¼ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ã¹ã³ã¢"] = {[on] = on, [off] = off}, ["ã¢ã¤ãã æ³¥ç¡å¹"] = {[on] = off, [off] = on}, ["å¦æªæ³¥ç¡å¹"] = {[on] = on, [off] = off}, ["éµæ¼åºã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãªã¶ã«ãã¹ã­ãã"] = {[on] = on, [off] = off}, ["ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹"] = {[on] = on, [off] = off}, ["ä¼è©±ç¡å¹"] = {[on] = on, [off] = off}, ["è«ç¼é¡ç¡å¹"] = {[on] = on, [off] = off}, ["å°å°ç¡å¹"] = {[on] = on, [off] = off},}})
        i = AddStatus({["type"] = "A", ["Tag"] = "NoneA",["Num"] = i, ["Name"] = "åæå¢ç¨ã¹ã­ãã", ["toggle"] = {["ãã¥ã¼ããªã¢ã«ã¹ã­ãã"] = {[on] = on, [off] = off},["ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾"] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status["B"] = {}
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥(å¦æª)",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3903300, ["E"] = {[off] = "h F6 03 1F 2A",[on] = "h 20 11 22 2A"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ç¢ºæ³¥ã¨ã©ã¼åé¿",
                        ["N"] = {[1] = {["offset"] = 0x3EF9B9C, ["E"] = {[off] = "h E0 03 1F 2A",[on] = "h 20 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "å¦æªæ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3001608, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x39032C4, ["E"] = {[off] = "h F3 03 1F 2A",[on] = "h 33 00 80 52"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "drop",["Num"] = i, ["Name"] = "ã¢ã¤ãã æ³¥ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x300159C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 00 20 70 47"}}},
                        ["N"] = {[1] = {["offset"] = 0x31F5248, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ãã¬ã³ãã¢ã¤ã³ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x36053C8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x43EFAF6, ["E"] = {[off] = "h FF 83 03 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4488B58, ["E"] = {[off] = "h FF 03 03 D1",[on]= "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ä¼è©±ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3853520, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 83 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4912510,  ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "è«ç¼é¡ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x3634770, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x371BE5C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44E04DC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x46B6BAC, ["E"] = {[off] = "h FF 43 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å®æ³ç¡å¹1",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9", ["E"] = {[off] = "",[on] = "h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã©ã³ã­ã³ã°ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x4483FEC, ["E"] = {[off] = "h FD 7B BA A9",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42F6A90, ["E"] = {[off] = "h FF C3 05 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "éµä¾¿ç¡å¹",
                        ["N"] = {[1] = {["offset"] = 0x42898E8, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "Mukou",["Num"] = i, ["Name"] = "å°å°ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x371C4D8, ["E"] = {[off] = "h B0 B5 02 AF",[on] = "h 70 47 02 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x46B73F4, ["E"] = {[off] = "h FF C3 02 D1",[on] = "h C0 03 5F D6"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "å®æ³ç¡å¹2",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9", ["E"] = {[off] = "",[on] = "h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9"}}}})
        --i = AddStatus({["type"] = "B", ["Tag"] = "gate",["Num"] = i, ["Name"] = "BOXç¡å¹",
        --                ["N"] = {[1] = {["offset"] = , ["S"] = "h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9", ["E"] = {[off] = "",[on] = "h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "åé",
                        ["LD"] = {[1] = {["offset"] = 0x2C401AC, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 3D 0A 57 3F",[S_(2)] = "h F6 28 5C 3F",[S_(3)] = "h 0A D7 63 3F"}}},
                        ["N"] = {[1] = {["offset"] = 0x234D21C, ["E"] = {[off] = "h 4D 62 50 3F",[S_(1)] = "h 9A 99 59 3F",[S_(2)] = "h 52 B8 5E 3F",[S_(3)] = "h 66 66 66 3F"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã·ã«éå»¶",
                        ["N"] = {[1] = {["offset"] = 0x3940ACC, ["E"] = {[off] = "h 00 18 28 1E",[S_(1)] = "h 00 50 2A 1E ",[S_(2)] = "h 00 D0 28 1E ",[S_(3)] = "h 00 10 28 1E "}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¯ã³ãã³",
                        ["LD"] = {[1] = {["offset"] = 0x312BC38, ["E"] = {[off] = "h C2 68 01 2A",[on] = "h C2 68 00 2A"}}},
                        ["N"] = {[1] = {["offset"] = 0x3B25FBC, ["E"] = {[off] = "h 81 00 00 54",[on] = "h 80 00 00 54"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "æµã¿ã¼ã³ç¡å¹",
                        ["LD"] = {[1] = {["offset"] = 0x330796C, ["E"] = {[off] = "h F0 B5 03 AF",[on] = "h 70 47 03 AF"}},
                                  [2] = {["offset"] = 0x3307B7C, ["E"] = {[off] = "h F0 B5 03 AF", [on] = "h 70 47 03 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEE0C, ["E"] = {[off] = "h 96 83 08 91",[on] = "h 96 07 00 91"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢",
                        ["LD"] = {[1] = {["offset"] = 0x3309F74, ["E"] = {[off] = "h 00 29 18 BF",[on] = "h 01 29 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EBEB20, ["E"] = {[off] = "h 01 00 15 8B",[on] = "h 21 B3 A0 D2"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãªã¶ã«ãã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x32FF77C, ["E"] = {[off] = "h 02 28 00 F0",[on] = "h 01 28 00 F0"}}},
                        ["N"] = {[1] = {["offset"] = 0x3EB1DB0, ["E"] = {[off] = "h 1F 0C 00 71",[on] = "h 1F 04 00 71"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "éµæ¼åºã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3839980, ["E"] = {[off] = "h C4 00 78 B1",[on] = "h C4 00 78 B9"}},
                                  [2] = {["offset"] = 0x3839984, ["E"] = {[off] = "h D0 F8 10 11", [on] = "h 00 00 10 11"}}},
                        ["N"] = {[1] = {["offset"] = 0x48EA364, ["E"] = {[off] = "h 01 09 40 B9",[on] = "h 1F 09 40 B9"}},
                                 [2] = {["offset"] = 0x48EA368, ["E"] = {[off] = "h 21 03 00 34", [on] = "h 21 03 00 35"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ãã¥ã¼ããªã¢ã«ã¹ã­ãã",
                        ["LD"] = {[1] = {["offset"] = 0x3D5CE08, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}},
                        ["N"] = {[1] = {["offset"] = 0x50E663C, ["E"] = {[off] = "h 01 01 01 01",[on] = "h 00 00 00 00"}}}})
        i = AddStatus({["type"] = "B", ["Tag"] = "NoneB",["Num"] = i, ["Name"] = "ã¹ã³ã¢ã¿éµä¾¿ã¤ãè§£æ¾",
                        ["LD"] = {[1] = {["offset"] = 0x36034A4, ["E"] = {[off] = "h F8 B5 04 AF",[on] = "h 70 47 04 AF"}}},
                        ["N"] = {[1] = {["offset"] = 0x44835E0, ["E"] = {[off] = "h FF 03 01 D1",[on] = "h C0 03 5F D6"}},
                                 [2] = {["offset"] = 0x4659CEC, ["E"] = {[off] = "h 21 00 80 52",[on] = "h E1 03 1F 2A"}}}})
    end
end

local function ShokiSettei()
    if os.date("%Y%m%d%H%M") >= "202411302359" or _G.NN == "4.130.0" then
        gg.alert("âï¸ï¸ï¸scriptã®æå¹æéãåãã¦ãã¾ãâï¸scriptãæ´æ°ãããã¾ã§ãã°ãããå¾ã¡ãã ãã")
        EXIT()
    end
    gg.setVisible(true)
    local application = gg.getTargetPackage()
    local package = "com.Level5.YWP"
    if application ~= package then
        gg.alert("ãã­ã»ã¹ã å¦æªã¦ã©ããã·ã«ã·ã« ã«è¨­å®ããã¦ãã¾ãã\nPackageName: " .. package)
        EXIT()
    end
    folderPatch = gg.FILES_DIR
    shoki = true
    success2 = true
    on = '[ON]'
    off = '[OFF]'
    function S_(Num)
        return '['..Num..']'
    end
    Status = {["TYPE"] = " ",["ver"] = " ",["Sver"] = 5,["Fver"] = 5}
    group = {}
    isMainActive = false
    Koumoku()
end
function filerebort()
    -- local filePath = "/storage/emulated/0/Dorati_script_rebort_file.txt"
    local filePath = folderPatch.."Dorati_script_rebort_file.txt"
    local function fileExists(path)
        local file = io.open(path, "r")
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä½æã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..type)
        table.insert(Kakikomi, "ver:"..Status["Sver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä½æããã¾ãã: ")
    end

    function Uwagaki()
        local file = io.open(filePath, "w")
        if not file then
            gg.alert("ãã¡ã¤ã«ã®ä¸æ¸ãã«å¤±æãã¾ãã: ")
            os.exit()
        end
        local Kakikomi = {}
        table.insert(Kakikomi, "TYPE:"..Status["TYPE"])
        table.insert(Kakikomi, "ver:"..Status["ver"])
        for i = 1, #Status["A"] do
            table.insert(Kakikomi, Status["A"][i]["Name"]..":"..Status["A"][i]["isEnabled"])
        end
        for i = 1, #Status["B"] do
            table.insert(Kakikomi, Status["B"][i]["Name"]..":"..Status["B"][i]["isEnabled"])
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. "\n")
        end
        file:close()
        gg.toast("ãã¡ã¤ã«ãä¸æ¸ãããã¾ãã: ")
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast("ãã¡ã¤ã«ãåé¤ããã¾ãã: ")
        else
            gg.alert("ãã¡ã¤ã«åé¤ã«å¤±æãã¾ãã: " .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            '"UG" or "PC(NOX)"',
            '"PC(LD)"',
            "ã¹ã¯ãªããçµäº"
        }, nil, 'ãã®ç«¯æ«ã®å®è¡ç°å¢ã¯ï¼')
        if TYPE3 == nil then
            FSQRT = -1
            return false
        else
            if TYPE3 == 1 then Shokifile('N') end
            if TYPE3 == 2 then Shokifile('LD') end
            if TYPE3 == 3 then EXIT() end
            return true
        end
    end

    if not fileExists(filePath) then
        if not TYPE2() then
            return false
        end
        --if Status["TYPE"] and Status["TYPE"] ~= " " then
        --    Shokifile(Status["TYPE"])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, "r")
        if not file then
            print("ãã¡ã¤ã«ãéãã¾ããã§ãã: ")
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read("*line")
            if not line then
                file:close()
                local ver = tonumber(Status["ver"])
                local Fver = tonumber(Status["Fver"])
                if Status["TYPE"] == "N" or Status["TYPE"] == "LD" then
                    if ver >= Fver then
                        Status["ver"] = Status["Sver"]
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, "([^:]+):(.+)")
            if key and value and Status[key] then
                if Status[key]["isEnabled"] then
                    EditNametoStatus(key,"isEnabled",value)
                else
                    Status[key] = value
                end
            end
            i = i + 1
        end
    end

    local success = processFile()
    if success then
        if not shoki then
            for _, value in pairs(Status["B"]) do
                ButtonB(value["Name"],value["isEnabled"],true)
            end
        end
        gg.toast("ååã®ãã¼ã¿ããå¾©åããã¾ãã")
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    "â ï¸ã¹ã¯ãªããä½¿ç¨ä¸ã®æ³¨æâ ï¸\n" ..
    "ãâ ã·ã«éå»¶ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ åéãã·ã«éå»¶ã¯ãèªèº«ã§èª¿æ´ãã¦ãã ãã\n" ..
    "ãâ ç¢ºæ³¥ã¨ã©ã¼åé¿ã¯ãªã¤ã5ä½æã®ç¨ãªã¨ã©ã¼ãåé¿ãããã®ã§ãBANåé¿ãªã©ã§ã¯ããã¾ãã\n" ..
    "ãâ äººé­æ¼åºç¡å¹ããã£ããã·ã¥æ¼åºç¡å¹ã¯åéç°å¢ã§ã¯BANã®å¯è½æ§ãããããæ¤è¨¼ãã¦ä½¿ç¨ãã ãã\n" ..
    "â ï¸PCã§ä½¿ç¨ããéã®æ³¨æ\n" ..
    "ãâ LDã§ã¯ã·ã«éå»¶,ç¢ºæ³¥ã¨ã©ã¼åé¿,ã©ã³ã­ã³ã°ã»ã¹ã³ã¢ã¿ã»éµä¾¿ç¡å¹ã¯æªå®è£ã§ã\n" ..
    "ãâ æµã¿ã¼ã³ç¡å¹ã¯ä¸åº¦æ¦éç»é¢ã¸è¡ãã¨ãã®ç¶æã§åºå®ããã¾ã\n" ..
    "ãâ ãã®ä»ç¡å¹ç³»ãéä¸­ã§ã®å¤æ´ã¯åæ ãããªãå¯è½æ§ãããã¾ã\n" ..
    "ã ã¢ããªååèµ·åæã®ã¿ã¤ãã«ç»é¢ã§è¨­å®ãããã¨ãæ¨å¥¨ãã¾ã"
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('è£½ä½è:ãã©ã',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl["order"]) do
        if string.match(value, "%a") ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v]["isEnabled"])
                tbl3[v] = tbl["value"][value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl["value"][cache] and type(tbl["value"][cache]) == "table" then
            if tblchoice(cache,tbl["value"][cache]) == "back" then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or" ", "^Button") then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c]["isEnabled"]
        else
            if active(tbl["value"][cache]) == "back" then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl["type"]](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl["type"] == "multiChoice" then
        local type1, Name, isEnabled = {}, {}, nil
        for key in pairs(choices) do
            a, b, c, isEnabled = filter(key)
            if b ~= nil and c ~= nil then
                if isEnabled == on then
                    table.insert(type1,1,b)
                    table.insert(Name,1,c)
                else
                    table.insert(type1,b)
                    table.insert(Name,c)
                end
            end
        end
        for i = 1, #type1 do
            if type1[i] and Name[i] then
            Button(type1[i],Name[i])
            end
        end
    else
        a, b, c= filter(choices)
        if b and c then
        print("A")
        Button(b,c)
        end
    end
    if a then
        return "back"
    end
end

function active(value)
    if string.match(value,"^tyuui$") then
        tyuui()
        Main()
    elseif string.match(value,"^back$") then
        return "back"
    elseif string.match(value,"^fileremove") then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,"^logaut$") then
        logaut()
    elseif string.match(value,"^Scriptend$") then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == "ButtonA" then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name]["N"]) do
            for key in pairs(n["E"]) do
                local index = tonumber(key:match("%[(%d+)%]"))
                if index and tblcount <= index then
                    tblcount = index
                end
            end
        end
        return tblcount > 0
    end

    if filetr() then
        for i = 1, tblcount do
            table.insert(tbl, S_(i))
        end
        table.insert(tbl, off)
        table.insert(tbl, "éãã")

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name]["isEnabled"]
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name]["toggle"]) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,"isEnabled",isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status["TYPE"] == "LD" and "LD" or "N")

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(v["offset"], v["E"][isEnabled])
        end
    
        EditNametoStatus(Name, "isEnabled", isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. "ã¯" .. type .. "ã«ã¯å¯¾å¿ãã¦ãã¾ãã")
    end
end

function logaut()
    local paths = {
        "/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/",
        "/data/data/",
        "/data/user/0/",
        "/data/data/com.Ymd.Modz64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.dog64/blackbox/data/user/0/",
        "/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/"
    }
    for _, path in ipairs(paths) do
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data00.cud")
        os.remove(path.."com.Level5.YWP/files/.library/ywp_cud/data01.cud")
    end
    gg.processKill()
    gg.toast("ã­ã°ã¢ã¦ããã¾ãã")
end

function EXIT()
    print("ä½æè:ãã©ã")
    print("2æ¬¡éå¸ãè»¢å£²ç¦æ­¢")
    print("(X)Twitterâ@ryuuti_puni")
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open("/storage/emulated/0/Pictures/ï¼ã¹ã¯ãªãã/ãªãã»ããæ´æ°/aaa.txt", "w")
--for _, value in pairs(Status["B"]) do
--    for Nm, va in pairs(value["N"]) do
--        fileaaa:write(value["Name"]..((#value["N"] > 1) and "("..Nm..")"or"").." :\næ¤ç´¢ããã"..(va["S"] or "nil").."\næ¸ãæãã"..(va["E"] and va["E"][on] or va["E"] and va["E"][S_(1)] or "nil").."\n~\n\n")
--    end
--end
--fileaaa:close()

while true do
    if gg.isVisible(true) then
    FSQRT = 1
    gg.setVisible(false)
    end

    gg.clearResults()

    if FSQRT == 1 then
        if not isMainActive then
            if filerebort() then
            end
        else
            Main()
        end
    end
end ;               !         ¸   K  ¹   Z  M  c  \  ¨  e  ¼  ª  á  ¾  é  ã  ù  ë  
  û                         !  !  !  !  $  $  $  &  &  &  '  '  '  (  (  (  (  )  +  +  -  .            Koumoku    ;          ShokiSettei    ;             _ENV 