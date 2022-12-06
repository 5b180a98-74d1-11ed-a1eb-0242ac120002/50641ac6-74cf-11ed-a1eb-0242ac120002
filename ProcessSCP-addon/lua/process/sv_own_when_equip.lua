// by default you don't own weapon you equip.

hook.Add( "WeaponEquip", "process.own_when_equip", function( weapon, ply )
	weapon:SetOwner(ply)
end )