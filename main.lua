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
t[{}]=true
t[function() end]=t

pprint(t)

--[[ output

table: 0A9258F8 {
  [1]>1
  [2]>table: 0A9257B8 {
        [1]>abc
        [2]>table: 0A925A10 {
            }
      }
  [table: 0A9255D8]>true
  [function: 0AFD3370]>*table: 0A9258F8
}

]]--
