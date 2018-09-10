function pprint( t ) 
    local same={}

    local function _print(t,indent)
        if (same[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            same[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..tostring(pos).."]>"..tostring(val).." {")
                        _print(val,indent..string.rep(" ",string.len(tostring(pos))+8))
                        print(indent..string.rep(" ",string.len(tostring(pos))+6).."}")
                    else
                        print(indent.."["..tostring(pos).."]>"..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end

    if (type(t)=="table") then
        print(tostring(t).." {")
        _print(t,"  ")
        print("}")
    else
        _print(t,"  ")
    end
    print()
end
