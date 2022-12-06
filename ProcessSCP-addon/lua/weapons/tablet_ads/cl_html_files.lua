// css
local css_header = [[
    <style>
        html{
            background-color: rgb(38, 50, 57);
        }
        
        ::-webkit-scrollbar {
            width: 12px;
        }
        
        /* Track */
        ::-webkit-scrollbar-track {
            border-radius: 10px;
        }
        
        /* Handle */
        ::-webkit-scrollbar-thumb {
            border-radius: 10px;
            background: rgb(255, 172, 77); 
        }
        
        button{
            outline: none;
            
            margin-bottom: 1%;
            
            height: 12%;
            width: 100%;
            
            border-radius: 5px;
            border: none;
            background-color: rgb(38, 50, 57);
            transition: background-color 0.5s , color 0.5s , font-size 0.5s;
            
            text-transform: uppercase;
            font-family: 'Varela Round';
            font-size: 100%;
            font-weight: 600;
            color: rgb(255, 183, 77);

            animation: 1s;
            animation-name: open;
        }
        button:hover{
            background: rgb(255, 183, 77);
            
            font-size: 120%;
            color: rgb(38, 50, 57);
            
            cursor: pointer;
        }
        
        #return_close{
            color:rgb(219, 38, 38)
        }
        #return_close:hover{
            background-color: #Cc5500;
            color: rgb(38, 50, 57);
        }

        @keyframes open{
            from{
                background-color: rgb(38, 50, 57);
                
                font-size: 0;
                color: rgb(255, 183, 77);
            }
        }
    </style>
]]

// html
process.tablet.files = {
    list = css_header..[[
        <html>
        <head>
            <link href='https://fonts.googleapis.com/css?family=Varela Round' rel='stylesheet'>
        </head>
        <body style="margin:0px 0px 0px 0px;padding:0px 0px 0px 0px;">
            <center>    
                <button type="action" id="return_close" onclick='console.log("RUNLUA:process.tablet.open_main_html()")'>retour</button>
            </center>
        </body>
        </html>
    ]],
    main = css_header..[[
        <html>
            <head>
                <link href='https://fonts.googleapis.com/css?family=Varela Round' rel='stylesheet'>
                <link rel='stylesheet' type='text/css' media='screen' href='asset://garrysmod/addons/ProcessCommunity/lua/weapons/tablet_ads/html/header.css'>
            </head>
        <body style="margin:0px 0px 0px 0px;padding:0px 0px 0px 0px;">
            <center>    
                <button type="action" id="return_close" onclick='console.log("RUNLUA:process.tablet.html:Remove()")'>fermer</button><br>
                <button type="action" onclick='console.log("RUNLUA:process.tablet.buttons.stop()")'>stoper les alarmes</button><br>
                <button type="action" onclick='console.log("RUNLUA:RunConsoleCommand(\"sam\", \"scanbio\")")'>scan biométrique</button><br>
                <button type="action" onclick='console.log("RUNLUA:process.tablet.buttons.fin_alerte()")'>fin d'alerte</button><br>
            </center>
        </body>
        </html>
    ]]
}