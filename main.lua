function pprint( t ) 
  local same={} -- éviter les répétitions

  local function _print(t,indent)
    if type(t)~="table" then return tostring( t ) end
    if same[tostring(t)] then return "*"..tostring(t) end

    same[tostring(t)]=true
    
    local sg=tostring(t).." {".."\n"
  
    for pos,val in pairs(t) do
      local len=string.len( indent.."["..tostring(pos).."]>".."  " )
      local toAdd = string.rep( " ", len )
      
      sg=sg..indent.."["..tostring(pos).."]>".._print(val,toAdd).."\n"
    end

    return sg..string.sub(indent,0,-3).."}"
  end

  print( _print(t,"  ") )
end
}

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
