RegisterNetEvent("NAT2K15:GETCHARCTERS")
AddEventHandler("NAT2K15:GETCHARCTERS", function()
  local src = source
  local player = exports[config.framework]:getdept(src)
  if(player) then
    exports.npwd:unloadPlayer(src)
  end
end)

RegisterNetEvent("NAT2K15:CHECKSQL")
AddEventHandler("NAT2K15:CHECKSQL", function(steam, discord, first_name, last_name, twt, dept, dob, gender, data)
  local src = source
  MySQL.Async.fetchAll("SELECT * FROM characters WHERE id=@charid", {["@charid"] = data.char_id}, function(response)
  if(not response[1].phone_number) then
      local newphone = exports.npwd:generatePhoneNumber()
      MySQL.Async.execute("UPDATE characters SET phone_number=@newphone WHERE id=@id", {["@newphone"] = newphone, ["@id"] = data.char_id})
      exports.npwd:newPlayer({
        source = src,
        phoneNumber = newphone,
        identifier = response[1].id,
        firstname = response[1].first_name,
        lastname = response[1].last_name
      })
    else
      exports.npwd:newPlayer({
        source = src,
        phoneNumber = response[1].phone_number,
        identifier = first_name,
        firstname = response[1].first_name,
        lastname = response[1].last_name
      })
      print(first_name .. ' ' .. last_name .. ' has loaded with Server ID ' .. src .. ', CharacterID is ' .. response[1].id .. ', Phone Number is ' .. response[1].phone_number)
    end
  end)
end)
