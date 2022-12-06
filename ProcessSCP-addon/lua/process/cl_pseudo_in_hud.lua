local scale_factor = 0.8
local img_size = {x = 512 * scale_factor, y = 51 * scale_factor}
local text_x_pos = 25 * scale_factor
local text_box_weight = 415 * scale_factor

local background_img = Material("hud/background_pseudo.png")

hook.Add("PostDrawTranslucentRenderables", "Process.pseudo_in_hud", function()
    local target = LocalPlayer():GetEyeTrace().Entity
    
    if IsValid(target) and target:IsPlayer() and !target:GetNoDraw() and target:getJobTable().category != "SCP" then 
        local distance = LocalPlayer():GetPos():DistToSqr(target:GetPos())
        if distance > process.config.distance_to_see_pseudo_in_hud ^ 2 then return end
        
        local pos = target:GetPos()
        pos.z = pos.z + target:BoundingRadius() * 1.8

        -- Get the game's camera angles
        local angle = EyeAngles()

        -- Only use the Yaw component of the angle
        angle = Angle( 0, angle.y, 0 )

        -- Correct the angle so it points at the camera
        -- This is usually done by trial and error using Up(), Right() and Forward() axes
        angle:RotateAroundAxis( angle:Up(), -90 )
        angle:RotateAroundAxis( angle:Forward(), 90 )

        -- Notice the scale is small, so text looks crispier
        cam.Start3D2D( pos, angle, 0.1 * scale_factor )
            surface.SetMaterial(background_img)
            surface.SetDrawColor(Color(255,255,255,212))
            local img_pos_x = -img_size.x / 2
            surface.DrawTexturedRect(img_pos_x, 0, img_size.x, img_size.y)

            surface.SetFont("DarkRPHUD2")
            surface.SetTextColor(process.orange)
            local w, text_height = surface.GetTextSize(target:Name())
            surface.SetTextPos(text_x_pos + img_pos_x + (text_box_weight - w) / 2, (img_size.y - text_height) / 2)
            surface.DrawText(target:Name())
        cam.End3D2D()
    end
end)