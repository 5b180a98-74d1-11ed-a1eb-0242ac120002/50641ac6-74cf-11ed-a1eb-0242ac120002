function draw.RotatedText(text, x, y, angle, panel) -- inspired by https://forum.facepunch.com/t/rotated-text-on-panels/183770/30
    local mat = Matrix()
	local posx, posy = panel:LocalToScreen(0, 0)

    local w, h = surface.GetTextSize(text)

	local matAng =  Angle(0, angle, 0)
    local vec = Vector(posx, posy)

	vec:Rotate(-matAng)
	vec.x = vec.x + x + posx
	vec.y = vec.y + y + posy
	mat:SetAngles(matAng)
	mat:SetTranslation(vec)

	cam.PushModelMatrix(mat)
		surface.SetTextPos(0, 0)
		surface.DrawText(text)
	cam.PopModelMatrix()
end