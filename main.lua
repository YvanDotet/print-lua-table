local function _print(tab,indent,same)
  local sg=tostring(tab).." {\n"

  for key,value in pairs(tab) do
    local line=indent.."  ["..tostring(key).."]>"

    if type(value)=="table" then
      if same[tostring(value)] then
        line = line.."*"..tostring(value)
      else
        same[tostring(value)]=true
        local len=string.len(line)
        local newIndent=string.rep(" ",len)
        line = line.._print(value,newIndent,same)
      end
    else
      line = line..tostring(value)
    end

    line=line.."\n"
    sg=sg..line
  end

  sg=sg..indent.."}"

  return sg
end

local function pprint(tab)
  local same={-- éviter les répétitions
    [tostring(tab)]=true
  }

  local _str=_print(tab,"",same)
  print(_str)
end

--Exemple

local t={1,{"abc",{}}}
t[{}]={}
t[function() end]={[t]=t}

pprint(t)

--[[ output

table: 0B1349C0 {
  [1]>1
  [2]>table: 0B134A38 {
        [1]>abc
        [2]>table: 0B134C40 {
            }
      }
  [table: 0B134AB0]>table: 0B134C18 {
                    }
  [function: 0AAD0168]>table: 0B1348D0 {
                         [table: 0B1349C0]>*table: 0B1349C0
                       }
}

]]--
