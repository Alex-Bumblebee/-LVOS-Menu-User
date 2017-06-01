require "resources/mysql-async/lib/MySQL"

---------------------------------- VAR ----------------------------------

local savedOutfits = {}

---------------------------------- EVENEMENT ----------------------------------

-- FR -- Evenement : Rétabli le skin de base du joueur
-- FR -- Paramètre(s) : Aucun
---------------------------------------------------------
-- EN -- Evenement : Reset Skin Player
-- EN -- Param(s) : None
RegisterServerEvent('menuuser:changeSkin')
AddEventHandler('menuuser:changeSkin', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
      MySQL.Async.fetchAll("SELECT * FROM outfits WHERE identifier = '@name'", {['@name'] = user.identifier}, function (result)
        if(result[1]) then
          savedOutfits[source] = result[1]
          TriggerClientEvent("es_customization:setOutfit", source, savedOutfits[source])
        else
          local default = {
            hair = 1,
            haircolour = 3,
            torso = 0,
            torsotexture = 0,
            torsoextra = 0,
            torsoextratexture = 0,
            pants = 0,
            pantscolour = 0,
            shoes = 0,
            shoescolour = 0,
            bodyaccesoire = 0,
            undershirt = 0,
            armor = 0
          }
          TriggerClientEvent("es_customization:setOutfit", source, default)
        end
      end)
  end)
end)

