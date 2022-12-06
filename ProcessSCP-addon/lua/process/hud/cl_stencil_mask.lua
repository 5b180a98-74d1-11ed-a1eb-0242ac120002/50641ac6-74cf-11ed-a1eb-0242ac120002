--[[ https://github.com/alexsnowrun/easymask but modified
Copyright 2021 alexsnowrun

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the
Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]
table.insert(process.credits, "https://github.com/alexsnowrun/easymask")

EZMASK = {}

local function ResetStencils()
	render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	render.SetStencilPassOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.ClearStencil()
end

local function EnableMasking()
	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(1)
	render.SetStencilCompareFunction(STENCIL_NEVER)
	render.SetStencilFailOperation(STENCIL_REPLACE)
end

local function SaveMask()
    render.SetStencilCompareFunction(STENCIL_EQUAL)
    render.SetStencilFailOperation(STENCIL_KEEP)
end

local function SaveReversedMask()
    render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
    render.SetStencilFailOperation(STENCIL_KEEP)
end

local function DisableMasking()
    render.SetStencilEnable(false)
end

local function DrawWithMask(func_mask, func_todraw)
    ResetStencils()
    EnableMasking()
    func_mask()
    SaveMask()
    func_todraw()
    DisableMasking()
end

local function DrawWithReversedMask(func_mask, func_todraw)
    ResetStencils()
    EnableMasking()
    func_mask()
    SaveReversedMask()
    func_todraw()
    DisableMasking()
end

local function DrawWithMask_vgui(shape, container)
	for key, child in pairs(container:GetChildren()) do
		child:SetPaintedManually(true)
	end

	function container:Paint()
		DrawWithMask(function ()
			surface.SetDrawColor(color_white)
			surface.DrawPoly(shape)
		end,
		function ()
			for key, child in pairs(container:GetChildren()) do
				child:PaintManual()
			end
		end)
	end
end

EZMASK.ResetStencils = ResetStencils
EZMASK.EnableMasking = EnableMasking
EZMASK.SaveMask = SaveMask
EZMASK.DisableMasking = DisableMasking
EZMASK.DrawWithMask = DrawWithMask
EZMASK.DrawWithMask_vgui = DrawWithMask_vgui
EZMASK.DrawWithReversedMask = DrawWithReversedMask