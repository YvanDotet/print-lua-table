# print-lua-table
La fonction pprint permet d'afficher tous les éléments d'un tableau en LUA.


Par exemple :

local t={4,"abc", {true} }

t[function() end]=-1

pprint(t)

--> output :

table: 0A65A460 {
  
  [1]>4
  
  [2]>abc
  
  [3]>table: 0A65A618 {
  
           [1]>true
         }
  
  [function: 0A6443B0]>-1
  
}
