local net_name = SWEP.net_name

local tablet = process.tablet

tablet.buttons = {}

function tablet.buttons.play_sound(index)
    net.Start(net_name)
    net.WriteUInt(index, 16)
    net.SendToServer()
end

function tablet.buttons.stop()
    net.Start(net_name)
    net.WriteUInt(0, 16)
    net.SendToServer()
end

function tablet.buttons.fin_alerte()
    net.Start(net_name)
    net.WriteUInt(tonumber("0xffff"), 16)
    net.SendToServer()
end

local size_factor = 1
local responsive_factor = math.min(ScrW() / 1920, ScrH() / 1080) * size_factor
local size = {x = 1000 * responsive_factor, y = 800 * responsive_factor}

local files = tablet.files

function tablet.open_main_html()
    local html = process.tablet.html
    html:SetHTML(files.main)

    function html:OnFinishLoadingDocument()
        html.OnFinishLoadingDocument = function()end

        html:RunJavascript([[
            const center = document.getElementsByTagName('center')[0]
        ]])

        for category, sounds in pairs(tablet.sounds) do
            tablet.html:AddFunction('process', category, function ()
                html:SetHTML(files.list)
                
                function html:OnFinishLoadingDocument()
                    html.OnFinishLoadingDocument = function()end
                    html:RunJavascript([[
                        const center = document.getElementsByTagName('center')[0]
                    ]])

                    for i, sound in pairs(sounds) do
                        html:RunJavascript([[             
                            button = document.createElement("button")
                            button.type = 'action'
                            button.onclick = function(){console.log("RUNLUA:process.tablet.buttons.play_sound(]]..sound.all_sound_index..[[)")}
                            button.textContent = ']]..string.JavascriptSafe(sound.name)..[['
        
                            document.getElementsByTagName('center')[0].appendChild(button)
                            document.getElementsByTagName('center')[0].appendChild(document.createElement("br"))
                        ]])
                    end
                end
            end)
        end

        for category, _ in pairs(tablet.sounds) do
            html:RunJavascript([[
                button = document.createElement("button")
                button.type = 'action'
                button.onclick = function(){process["]]..category..[["]()} 
                button.textContent = ']]..string.JavascriptSafe(category)..[['

                document.getElementsByTagName('center')[0].appendChild(button)
                document.getElementsByTagName('center')[0].appendChild(document.createElement("br"))
            ]])
        end
    end
end

net.Receive(net_name, function (len)
    process.tablet.html = vgui.Create("DHTML")
    local html = process.tablet.html
    html:SetSize(size.x, size.y)
    html:Center()
    html:SetAllowLua(true)
    html:MakePopup()
    
    tablet.open_main_html()
end)