local function EditNametoStatus(n,t,v)
    Status[n][t]=v
    Status[Status[n]['type']][Status[n]['Num']][t]=v
end

local function isim()
    local a=gg.getRangesList'libSGF'
    if#a<=0 then a=gg.getRangesList'split_config.arm64_v8a.apk'end
    if#a>0 then return'0x'..string.format('%X',a[1].start)end
    return nil
end

local function setHexMemory(o, h)
    local a,b=isim(),0
    local t={}
    for x in h:gmatch'%S%S'do
        t[#t+1]={address=a+o+b,flags=gg.TYPE_BYTE,value=x..'r'}
        b=b+1
    end
    local s=gg.setValues(t)
    if type(s)~='string'then return true else gg.alert(s)return false end
end

local function Koumoku()
    local function AddStatus(args)
        local value = {type = args.type,isEnabled = args.isEnabled or off, Num = args.Num, Name = args.Name , toggle = args.toggle or nil, N = args.N or nil, LD = args.LD or nil}
        Status[args.Name] = value
        Status[args.type][args.Num] = value
        group[args.Tag] = group[args.Tag] or {}
        table.insert(group[args.Tag], args.Name)
        return args.Num +1
    end
    local function Addchoicetbl(address,Name,value)
        (address or choicetbl).value[Name] = value
        local i = #(address or choicetbl).order + 1
        (address or choicetbl).order[i] = Name
    end
    choicetbl = {type = 'choice',value = {},order = {}}
    local address = nil
    Addchoicetbl(address,'⚠️注意事項⚠️','tyuui')
    Addchoicetbl(address,'一括設定',{type= 'multiChoice',value = {},order = {}})
    Addchoicetbl(address,'個別設定',{type= 'multiChoice',value = {},order = {}})
    Addchoicetbl(address,'スクリプト履歴削除','fileremove')
    Addchoicetbl(address,'ログアウト','logaut')
    Addchoicetbl(address,'スクリプト終了','Scriptend')
    address = choicetbl.value['一括設定']
    Addchoicetbl(address,'NoneA','ButtonA')
    Addchoicetbl(address,'戻る','back')
    address = choicetbl.value['個別設定']
    Addchoicetbl(address,'ドロップ系',{type= 'multiChoice',value = {},order = {}})
    Addchoicetbl(address,'無効系',{type= 'multiChoice',value = {},order = {}})
    --[[Addchoicetbl(address,'ゲート系',{['type']= 'multiChoice',['value'] = {},['order'] = {}})]]
    Addchoicetbl(address,'NoneB','ButtonB')
    Addchoicetbl(address,'戻る','back')
    address = choicetbl.value['個別設定'].value['ドロップ系']
    Addchoicetbl(address,'drop','ButtonB')
    Addchoicetbl(address,'閉じる','end')
    address = choicetbl.value['個別設定'].value['無効系']
    Addchoicetbl(address,'Mukou','ButtonB')
    Addchoicetbl(address,'閉じる','end')
    --[[address = choicetbl['value']['個別設定']['value']['ゲート系']
    Addchoicetbl(address,'gate','ButtonB')
    Addchoicetbl(address,'閉じる','end')]]
    if true then
        local i = 1
        Status.A = {}
        i = AddStatus({type = 'A', Tag = 'NoneA',Num = i, Name = 'おすすめ倍速遅延(UG)', toggle = {['倍速'] = {[on] = S_(2), [off] = off}, ['ぷに遅延'] = {[on] = S_(3), [off] = off}}})
        i = AddStatus({type = 'A', Tag = 'NoneA',Num = i, Name = 'おすすめ倍速遅延(PC)', toggle = {['倍速'] = {[on] = S_(3), [off] = off}, ['ぷに遅延'] = {[on] = S_(1), [off] = off}}})
        i = AddStatus({type = 'A', Tag = 'NoneA',Num = i, Name = '完凸用', toggle = {['ワンパン'] = {[on] = on, [off] = off}, ['敵ターン無効'] = {[on] = on, [off] = off}, ['スコア'] = {[on] = on, [off] = off}, ['アイテム泥無効'] = {[on] = on, [off] = off}, ['妖怪泥無効'] = {[on] = off, [off] = on}, ['鍵演出スキップ'] = {[on] = on, [off] = off}, ['リザルトスキップ'] = {[on] = on, [off] = off}, ['フレンドアイコン無効'] = {[on] = on, [off] = off}, ['会話無効'] = {[on] = on, [off] = off}, ['虫眼鏡無効'] = {[on] = on, [off] = off}, ['封印無効'] = {[on] = on, [off] = off},['確泥(妖怪)'] = {[on] = on, [off] = off}, ['確泥エラー回避'] = {[on] = on, [off] = off}}})
        --[[i = AddStatus({type = 'A', Tag = 'NoneA',Num = i, Name = 'Yポ周回用', toggle = {['ワンパン'] = {[on] = on, [off] = off}, ['敵ターン無効'] = {[on] = on, [off] = off}, ['スコア'] = {[on] = on, [off] = off}, ['妖怪泥無効'] = {[on] = on, [off] = off}, ['鍵演出スキップ'] = {[on] = on, [off] = off}, ['リザルトスキップ'] = {[on] = on, [off] = off}, ['フレンドアイコン無効'] = {[on] = on, [off] = off}, ['会話無効'] = {[on] = on, [off] = off}, ['虫眼鏡無効'] = {[on] = on, [off] = off}, ['封印無効'] = {[on] = on, [off] = off}, }})]]
        i = AddStatus({type = 'A', Tag = 'NoneA',Num = i, Name = 'アイテム周回用', toggle = {['ワンパン'] = {[on] = on, [off] = off}, ['敵ターン無効'] = {[on] = on, [off] = off}, ['スコア'] = {[on] = on, [off] = off}, ['アイテム泥無効'] = {[on] = off, [off] = on}, ['妖怪泥無効'] = {[on] = on, [off] = off}, ['鍵演出スキップ'] = {[on] = on, [off] = off}, ['リザルトスキップ'] = {[on] = on, [off] = off}, ['フレンドアイコン無効'] = {[on] = on, [off] = off}, ['会話無効'] = {[on] = on, [off] = off}, ['虫眼鏡無効'] = {[on] = on, [off] = off}, ['封印無効'] = {[on] = on, [off] = off},}})
        i = AddStatus({type = 'A', Tag = 'NoneA',Num = i, Name = '初期垢用スキップ', toggle = {['チュートリアルスキップ'] = {[on] = on, [off] = off},['スコアタ郵便イベ解放'] = {[on] = on, [off] = off}}})
    end
    if true then
        local i = 1
        Status.B = {}
        i = AddStatus({type = 'B', Tag = 'drop',Num = i, Name = '確泥(妖怪)',
                        ['LD'] = {{offset = '30034C8',Value = {[off] = 'h F0 B5 03 AF',[on] = 'h 70 47 00 00'}}},
                        ['N'] = {{offset = '3918774',Value = {[off] = 'h F6 03 1F 2A',[on] = 'h 20 11 22 2A'}}}})
        i = AddStatus({type = 'B', Tag = 'drop',Num = i, Name = '確泥エラー回避',
                        ['N'] = {{offset = '3EFA9EC',Value = {[off] = 'h E0 03 1F 2A',[on] = 'h 20 00 80 52'}}}})
        i = AddStatus({type = 'B', Tag = 'drop',Num = i, Name = '妖怪泥無効',
                        ['LD'] = {{offset = '30034C8',Value = {[off] = 'h F0 B5 03 AF',[on] = 'h 00 20 70 47'}}},
                        ['N'] = {{offset = '3918738',Value = {[off] = 'h F3 03 1F 2A',[on] = 'h 33 00 80 52'}}}})
        i = AddStatus({type = 'B', Tag = 'drop',Num = i, Name = 'アイテム泥無効',
                        ['LD'] = {{offset = '300345C',Value = {[off] = 'h F0 B5 03 AF',[on] = 'h 00 20 70 47'}}},
                        ['N'] = {{offset = '320C7B8',Value = {[off] = 'h FD 7B BA A9',[on] = 'h C0 03 5F D6'}}}})
        i = AddStatus({type = 'B', Tag = 'Mukou',Num = i, Name = 'フレンドアイコン無効',
                        ['LD'] = {{offset = '3607478',Value = {[off] = 'h B0 B5 02 AF',[on] = 'h 70 47 02 AF'}}},
                        ['N'] = {{offset = '4408E04',Value = {[off] = 'h FF 83 03 D1',[on] = 'h C0 03 5F D6'}},
                                 {offset = '44A1E64',Value = {[off] = 'h FF 03 03 D1',[on]= 'h C0 03 5F D6'}}}})
        i = AddStatus({type = 'B', Tag = 'Mukou',Num = i, Name = '会話無効',
                        ['LD'] = {{offset = '38555D0',Value = {[off] = 'h F0 B5 03 AF',[on] = 'h 70 47 03 AF'}}},
                        ['N'] = {{offset = '492B7A8',  ['E'] = {[off] = 'h FF 83 01 D1 E8 23 00 FD',[on] = 'h C0 03 5F D6 C0 03 5F D6'}}}})
        i = AddStatus({type = 'B', Tag = 'Mukou',Num = i, Name = '虫眼鏡無効',
                        ['LD'] = {{offset = '3636820',Value = {[off] = 'h F0 B5 03 AF',[on] = 'h 70 47 03 AF'}},
                                  {offset = '371DF0C',Value = {[off] = 'h F0 B5 03 AF',[on] = 'h 70 47 03 AF'}}},
                        ['N'] = {{offset = '44F97E8',Value = {[off] = 'h FF 43 02 D1',[on] = 'h C0 03 5F D6'}},
                                 {offset = '46CFE48',Value = {[off] = 'h FF 43 02 D1',[on] = 'h C0 03 5F D6'}}}})
        --[[i = AddStatus({type = 'B', Tag = 'Mukou',Num = i, Name = '実況無効1',
                        ['N'] = {{['offset'] = , ['S'] = 'h 63 8D 1B 94 FD 7B BE A9 F4 4F 01 A9'',Value = {[off] = '',[on] = 'h 63 8D 1B 94 C0 03 5F D6 F4 4F 01 A9'}}}})]]
        i = AddStatus({type = 'B', Tag = 'Mukou',Num = i, Name = 'ランキング無効',
                        ['N'] = {{offset = '449D2F8',Value = {[off] = 'h FD 7B BA A9',[on] = 'h C0 03 5F D6'}}}})
        i = AddStatus({type = 'B', Tag = 'Mukou',Num = i, Name = 'スコアタ無効',
                        ['N'] = {{offset = '430FD9C',Value = {[off] = 'h FF C3 05 D1',[on] = 'h C0 03 5F D6'}}}})
        i = AddStatus({type = 'B', Tag = 'Mukou',Num = i, Name = '郵便無効',
                        ['N'] = {{offset = '42A2BF4',Value = {[off] = 'h FF C3 02 D1',[on] = 'h C0 03 5F D6'}}}})
        i = AddStatus({type = 'B', Tag = 'Mukou',Num = i, Name = '封印無効',
                        ['LD'] = {{offset = '371E588',Value = {[off] = 'h B0 B5 02 AF',[on] = 'h 70 47 02 AF'}}},
                        ['N'] = {{offset = '46D068C',Value = {[off] = 'h FF C3 02 D1',[on] = 'h C0 03 5F D6'}}}})
        --[[i = AddStatus({type = 'B', Tag = 'gate',Num = i, Name = '実況無効2',
                        ['N'] = {{['offset'] = , ['S'] = 'h 3A E9 1E 14 FF 43 02 D1 FD 7B 07 A9'',Value = {[off] = '',[on] = 'h 3A E9 1E 14 C0 03 5F D6 FD 7B 07 A9'}}}})
        i = AddStatus({type = 'B', Tag = 'gate',Num = i, Name = 'BOX無効',
                        ['N'] = {{['offset'] = , ['S'] = 'h F1 37 27 14 FF 83 03 D1 FD 7B 0B A9'',Value = {[off] = '',[on] = 'h F1 37 27 14 C0 03 5F D6 FD 7B 0B A9'}}}})]]
        i = AddStatus({type = 'B', Tag = 'NoneB',Num = i, Name = '倍速',
                        ['LD'] = {{offset = '2C4200C',Value = {[off] = 'h 4D 62 50 3F',[S_(1)] = 'h 3D 0A 57 3F',[S_(2)] = 'h F6 28 5C 3F',[S_(3)] = 'h 0A D7 63 3F'}}},
                        ['N'] = {{offset = '2360CB4',Value = {[off] = 'h 4D 62 50 3F',[S_(1)] = 'h 9A 99 59 3F',[S_(2)] = 'h 52 B8 5E 3F',[S_(3)] = 'h 66 66 66 3F'}}}})
        i = AddStatus({type = 'B', Tag = 'NoneB',Num = i, Name = 'ぷに遅延',
                        ['N'] = {{offset = '3956104',Value = {[off] = 'h 00 18 28 1E',[S_(1)] = 'h 00 50 2A 1E ',[S_(2)] = 'h 00 D0 28 1E ',[S_(3)] = 'h 00 10 28 1E '}}}})
        i = AddStatus({type = 'B', Tag = 'NoneB',Num = i, Name = 'ワンパン',
                        ['LD'] = {{offset = '312DAF8',Value = {[off] = 'h C2 68 01 2A',[on] = 'h C2 68 00 2A'}}},
                        ['N'] = {{offset = '3B3B7D8',Value = {[off] = 'h 81 00 00 54',[on] = 'h 80 00 00 54'}}}})
        i = AddStatus({type = 'B', Tag = 'NoneB',Num = i, Name = '敵ターン無効',
                        ['LD'] = {{offset = '330982C',Value = {[off] = 'h F0 B5 03 AF',[on] = 'h 70 47 03 AF'}},
                                  {offset = '3309A3C',Value = {[off] = 'h F0 B5 03 AF', [on] = 'h 70 47 03 AF'}}},
                        ['N'] = {{offset = '3ED490C',Value = {[off] = 'h 96 83 08 91',[on] = 'h 96 07 00 91'}}}})
        i = AddStatus({type = 'B', Tag = 'NoneB',Num = i, Name = 'スコア',
                        ['LD'] = {{offset = '330BE34',Value = {[off] = 'h 00 29 18 BF',[on] = 'h 01 29 00 00'}}},
                        ['N'] = {{offset = '3ED4620',Value = {[off] = 'h 01 00 15 8B',[on] = 'h 21 B3 A0 D2'}}}})
        i = AddStatus({type = 'B', Tag = 'NoneB',Num = i, Name = 'リザルトスキップ',
                        ['LD'] = {{offset = '330163C',Value = {[off] = 'h 02 28 00 F0',[on] = 'h 01 28 00 F0'}}},
                        ['N'] = {{offset = '3EC789C',Value = {[off] = 'h 1F 0C 00 71',[on] = 'h 1F 04 00 71'}}}})
        i = AddStatus({type = 'B', Tag = 'NoneB',Num = i, Name = '鍵演出スキップ',
                        ['LD'] = {{offset = '383BA30',Value = {[off] = 'h C4 00 78 B1 D0 F8 10 11',[on] = 'h C4 00 78 B9 00 00 10 11'}}},
                        ['N'] = {{offset = '49035FC',Value = {[off] = 'h 01 09 40 B9 21 03 00 34',[on] = 'h 1F 09 40 B9 21 03 00 35'}}}})
        i = AddStatus({type = 'B', Tag = 'NoneB',Num = i, Name = 'チュートリアルスキップ',
                        ['LD'] = {{offset = '3D5FB78',Value = {[off] = 'h 01 01 01 01',[on] = 'h 00 00 00 00'}}},
                        ['N'] = {{offset = '51001CC',Value = {[off] = 'h 01 01 01 01',[on] = 'h 00 00 00 00'}}}})
        i = AddStatus({type = 'B', Tag = 'NoneB',Num = i, Name = 'スコアタ郵便イベ解放',
                        ['LD'] = {{offset = '3605554',Value = {[off] = 'h F8 B5 04 AF',[on] = 'h 70 47 04 AF'}}},
                        ['N'] = {{offset = '449C8EC',Value = {[off] = 'h FF 03 01 D1',[on] = 'h C0 03 5F D6'}},
                                 {offset = '4672F84',Value = {[off] = 'h 21 00 80 52',[on] = 'h E1 03 1F 2A'}}}})
    end
end

local function ShokiSettei()
    _G.NN = (_G.NN == 'MSDK' and '4.131.0') or (_G.NN or '4.131.0')
    if os.date('%Y%m%d%H%M') >= '202411302359' or _G.NN ~= '4.131.0' then
        gg.alert('✔︎︎︎scriptの有効期限が切れています✔︎scriptが更新されるまでしばらくお待ちください')
        EXIT()
    end
    gg.setVisible(true)
    local application, package = gg.getTargetPackage(), 'com.Level5.YWP'
    if application ~= package then
        gg.alert('プロセスが 妖怪ウォッチぷにぷに に設定されていません\nPackageName: ' .. package)
        EXIT()
    end
    folderPatch, shoki, success2, on, off, S_, Status, group, isMainActive = gg.FILES_DIR, true, true, '[ON]', '[OFF]', function(Num) return '['..Num..']' end, {TYPE = ' ',ver = ' ',Sver = 5,Fver = 5}, {}, false
    Koumoku()
end
function filerebort()
    --[[local filePath = '/storage/emulated/0/Dorati_script_rebort_file.txt']]
    local filePath = folderPatch..'Dorati_script_rebort_file.txt'
    local function fileExists(path)
        local file = io.open(path, 'r')
        if file then
            shoki = false
            file:close()
            return true
        else
            return false
        end
    end

    local function Shokifile(type)
        local file, Kakikomi = io.open(filePath, 'w'), {}
        if not file then
            gg.alert('ファイルの作成に失敗しました: ')
            os.exit()
        end
        table.insert(Kakikomi, 'TYPE:'..type)
        table.insert(Kakikomi, 'ver:'..Status.Sver)
        for i = 1, #Status.A do
            table.insert(Kakikomi, Status.A[i].Name..':'..Status.A[i].isEnabled)
        end
        for i = 1, #Status.B do
            table.insert(Kakikomi, Status.B[i].Name..':'..Status.B[i].isEnabled)
        end
        for _, value in ipairs(Kakikomi) do
            file:write(value .. '\n')
        end
        file:close()
        gg.toast('ファイルが作成されました: ')
    end

    function Uwagaki()
        local file, Kakikomi = io.open(filePath, 'w'), {}
        if not file then
            gg.alert('ファイルの上書きに失敗しました: ')
            os.exit()
        end
        table.insert(Kakikomi, 'TYPE:'..Status.TYPE)
        table.insert(Kakikomi, 'ver:'..Status.ver)
        for i = 1, #Status.A do
            table.insert(Kakikomi, Status.A[i].Name..':'..Status.A[i].isEnabled)
        end
        for i = 1, #Status.B do
            table.insert(Kakikomi, Status.B[i].Name..':'..Status.B[i].isEnabled)
        end
        for _, value in ipairs(Kakikomi) do
        file:write(value .. '\n')
        end
        file:close()
        gg.toast('ファイルが上書きされました: ')
    end

    function fileremove()
        Koumoku()
        local result, err = os.remove(filePath)

        if result then
            shoki = true
            gg.toast('ファイルが削除されました: ')
        else
            gg.alert('ファイル削除に失敗しました: ' .. err)
            os.exit()
        end
    end

    local function TYPE2()
        local TYPE3 = gg.choice({
            "'UG' or 'PC(NOX)'",
            "'PC(LD)'",
            'スクリプト終了'
        }, nil, 'この端末の実行環境は？')
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
        --if Status['TYPE'] and Status['TYPE'] ~= ' ' then
        --    Shokifile(Status['TYPE'])
        --elseif not TYPE2() then
        --    return false
        --end
    end

    local function processFile()
        local file = io.open(filePath, 'r')
        if not file then
            print('ファイルを開けませんでした: ')
            EXIT()
        end
        local i = 1
        local line
        while true do
            line = file:read('*line')
            if not line then
                file:close()
                local ver = tonumber(Status.ver)
                local Fver = tonumber(Status.Fver)
                if Status.TYPE == 'N' or Status.TYPE == 'LD' then
                    if ver >= Fver then
                        Status.ver = Status.Sver
                        return true
                    end
                else
                    return false
                end
            end
            local key, value = string.match(line, '([^:]+):(.+)')
            if key and value and Status[key] then
                if Status[key].isEnabled then
                    EditNametoStatus(key,'isEnabled',value)
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
            for _, value in pairs(Status.B) do
                if value.isEnabled ~= off then
                ButtonB(value.Name,value.isEnabled,true)
                end
            end
        end
        gg.toast('前回のデータから復元されました')
        Main()
    else
        fileremove()
    end
end

function tyuui()
    gg.alert(
    '⚠️スクリプト使用上の注意⚠️\n' ..
    '　■ぷに遅延は一度戦闘画面へ行くとその状態で固定されます\n' ..
    '　■倍速、ぷに遅延はご自身で調整してください\n' ..
    '　■確泥エラー回避はなつき5体時の稀なエラーを回避するものですBAN回避などではありません\n' ..
    '　■人魂演出無効、フィニッシュ演出無効は倍速環境ではBANの可能性があるため検証して使用ください\n' ..
    '⚠️PCで使用する際の注意\n' ..
    '　■LDではぷに遅延,確泥エラー回避,ランキング・スコアタ・郵便無効は未実装です\n' ..
    '　■敵ターン無効は一度戦闘画面へ行くとその状態で固定されます\n' ..
    '　■その他無効系も途中での変更は反映されない可能性があります\n' ..
    '　 アプリ初回起動時のタイトル画面で設定することを推奨します'
    )
end

function Main()
    isMainActive = true
    FSQRT = -1
    if tblchoice('製作者:ドラチ',choicetbl) ~= false then
        Uwagaki()
        Main()
    end
end

function tblchoice(str,tbl)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl.order) do
        if string.match(value, '%a') ~= nil then
            for _, v in ipairs(group[value]) do
                table.insert(tbl2,v)
                table.insert(tbl4,v..Status[v].isEnabled)
                tbl3[v] = tbl.value[value]
            end
        else
            table.insert(tbl2,value)
            table.insert(tbl4,value)
        end
    end
    local function filter(key)
        local a, b, c, d, cache = false, false, false, false, tbl2[key]
        if tbl.value[cache] and type(tbl.value[cache]) == 'table' then
            if tblchoice(cache,tbl.value[cache]) == 'back' then
                tblchoice(str,tbl)
            end
        elseif string.match(tbl3[cache]or' ', '^Button') then
            local type1 = cache
            b = tbl3[cache]
            c = type1
            d = Status[c].isEnabled
        else
            if active(tbl.value[cache]) == 'back' then
                a = true
            end
        end
        return a, b, c, d
    end
    local choices = gg[tbl.type](tbl4, nil, str)
    local a, b, c
    if choices == nil then
        return false
    elseif tbl.type == 'multiChoice' then
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
            Button(b,c)
        end
    end
    if a then
        return 'back'
    end
end

function active(value)
    if string.match(value,'^tyuui$') then
        tyuui()
        Main()
    elseif string.match(value,'^back$') then
        return 'back'
    elseif string.match(value,'^fileremove') then
        fileremove()
        ShokiSettei()
        success2 = true
        isMainActive = false
        shoki = false
        FSQRT = 1
    elseif string.match(value,'^logaut$') then
        logaut()
    elseif string.match(value,'^Scriptend$') then
        EXIT()
    end
end

function Button(type1, Name)

    local tbl, tblcount = {}, 0

    local function filetr()
        if type1 == 'ButtonA' then
            return false
        end
        print(Name)
        for _, n in pairs(Status[Name].N) do
            for key in pairs(n.Value) do
                local index = tonumber(key:match('%[(%d+)%]'))
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
        table.insert(tbl, '閉じる')

        local choices = gg.choice(tbl, nil, Name)
        if choices then
            _G[type1](Name, tbl[choices])
        end
    else
        local state = Status[Name].isEnabled
        _G[type1](Name, state == on and off or on)
    end
end

function ButtonA(Name,isEnabled)
    for key, value in pairs(Status[Name].toggle) do
        ButtonB(key,value[isEnabled],true)
    end
    EditNametoStatus(Name,'isEnabled',isEnabled)
    gg.toast(Name .. isEnabled)
end

function ButtonB(Name, isEnabled, data)
    local cache = Status[Name]
    local type = (Status.TYPE == 'LD' and 'LD' or 'N')

    if cache[type] then
        for _, v in pairs(cache[type]) do
            setHexMemory(tonumber(v.offset,16), v.Value[isEnabled])
        end
        EditNametoStatus(Name, 'isEnabled', isEnabled)
        if not data then gg.toast(Name .. isEnabled) end
    else
        return gg.toast(Name .. 'は' .. type .. 'には対応していません')
    end
end

function logaut()
    local paths = {
        '/data/user/0/top.niunaijun.blackboxa64/blackbox/data/user/0/',
        '/data/data/',
        '/data/user/0/',
        '/data/data/com.Ymd.Modz64/blackbox/data/user/0/',
        '/data/data/top.niunaijun.dog64/blackbox/data/user/0/',
        '/data/data/top.niunaijun.blackboxa64/blackbox/data/user/0/'
    }
    for _, path in ipairs(paths) do
        os.remove(path..'com.Level5.YWP/files/.library/ywp_cud/data00.cud')
        os.remove(path..'com.Level5.YWP/files/.library/ywp_cud/data01.cud')
    end
    gg.processKill()
    gg.toast('ログアウトしました')
end

function EXIT()
    print('作成者:ドラチ')
    print('2次配布、転売禁止')
    print('(X)Twitter→@ryuuti_puni')
    gg.skipRestoreState()
    os.exit()
    gg.setVisible(true)
end

ShokiSettei()
--fileaaa = io.open('/storage/emulated/0/Pictures/１スクリプト/オフセット更新/aaa.txt', 'w')
--for _, value in pairs(Status['B']) do
--    for Nm, va in pairs(value['N']) do
--        fileaaa:write(value['Name']..((#value['N'] > 1) and '('..Nm..')'or'')..' :\n検索　　　'..(va['S'] or 'nil')..'\n書き換え　'..(va['E'] and va['E'][on] or va['E'] and va['E'][S_(1)] or 'nil')..'\n~\n\n')
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
end
