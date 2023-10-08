ESX = exports["es_extended"]:getSharedObject()
local isReloading = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        if DoesEntityExist(ped) and not IsEntityDead(ped) then
            if IsPedReloading(ped) and not isReloading then
                isReloading = true
                local weapon = GetSelectedPedWeapon(ped)
                local weaponName = Config.WeaponNames[weapon] or "Unknown Weapon"
                local _, ammoInClip = GetAmmoInClip(ped, weapon)
                local maxClipAmmo = GetMaxAmmoInClip(ped, weapon, false)
                local ammoToFill = maxClipAmmo - ammoInClip
                ESX.UI.ShowInventoryItemNotification(false, weaponName, ammoToFill)
            elseif not IsPedReloading(ped) then
                isReloading = false
            end
        end
    end
end)