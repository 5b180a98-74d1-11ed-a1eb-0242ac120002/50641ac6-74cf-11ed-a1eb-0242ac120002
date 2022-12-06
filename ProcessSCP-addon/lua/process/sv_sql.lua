require("mysqloo")
process.sql = {}

local mysqloo_db = mysqloo.connect("", "", "", "", ) -- Faut vraiment être une quiche pour laisser en dure les accès OVH

function mysqloo_db:onConnectionFailed( err )
    error("process: Connection to database failed! Error : ".. err)
end

function mysqloo_db.onConnected()
    print("process: Base de donné connectée!")

    function process.sql.query(query, callback)
        local mysqloo_query = mysqloo_db:query(query)
        function mysqloo_query:onError(err)
            error("mysql error : "..err)
        end

        if (callback) then
            mysqloo_query:start()
            if (isfunction(callback)) then
                function mysqloo_query:onSuccess(data)
                    callback(data)
                end
            end
        else
            mysqloo_query:start()
            mysqloo_query:wait(true) // the query is being swapped to the front of the queue making it the next query to be executed
    
            return mysqloo_query:getData()
        end
    end
    function process.sql.is_ply_exist(steamID, table_name)
        return process.sql.query("select * from "..table_name.." where steamID = "..sql.SQLStr(steamID))[1]
    end
end

mysqloo_db:connect()
mysqloo_db:wait() // wait for connexion
process.sql.mysqloo_db = mysqloo_db

local function unpacks_query_result(query_result)
    local t2 = {}
    for key, value in pairs(query_result) do
        if (key != "steamID") then
            table.insert(t2, value)
        end
    end
    
    return unpack(t2)
end

local player_sql_tables = {
    donator = {
        name = "ProcessDonator",
        values = {{name = "duration", type = "int"},{name = "statut", type = "int"}}, // 0 : not donator, > 0 donator and -1 permanent donator
    },
    level = {
        name = "ProcessLevel",
        values = {{name = "level", type = "int"}, {name = "point", type = "int"}},
    },
    pins = {
        name = "ProcessPins",
        values = {{name = "pins", type = "int"}, {name = "authorized_pins", type = "text"}}
    }
}

for key, sql_table in pairs(player_sql_tables) do
    local functions = {}
    local create_values = "" // like : int level,int point
    local update_values = "" // like : int,int
    local insert_into_values = "" // like : level,point

    process.sql[key] = {}

    for i, value in pairs(sql_table.values) do
        process.sql[key][("get_"..value.name)] = function (steamID, callback)
            if (callback) then
                process.sql.query("select "..value.name.." from "..sql_table.name.." where steamID = "..sql.SQLStr(steamID), function (data)
                    callback(data[1] and data[1][value.name])
                end)
            else
                local data = process.sql.query("select "..value.name.." from "..sql_table.name.." where steamID = "..sql.SQLStr(steamID))[1]
                return data and data[value.name]
            end
        end
        process.sql[key][("set_"..value.name)] = function (steamID, arg, callback)
            process.sql.query("update "..sql_table.name.." set "..value.name.." = "..tostring(value.type == "text" and sql.SQLStr(arg) or arg).." where steamID = "..sql.SQLStr(steamID), callback)
        end
        
        if (i != 1) then
            update_values = update_values..","
        end
        create_values = create_values..","..value.name.." "..value.type
        update_values = update_values..value.name.." = %s"
        insert_into_values = insert_into_values..","..value.name
    end
    
    process.sql[key].set = function (steamID, ...)
        local args = {...}
        for i = 1, #sql_table.values do
            args[i] = tostring(sql_table.values[i].type == "text" and sql.SQLStr(args[i]) or args[i])
        end

        process.sql.query("update "..sql_table.name.." set "..string.format(update_values, unpack(args)).." where steamID = "..sql.SQLStr(steamID), args[#sql_table.values + 1])
    end
    process.sql[key].get = function (steamID, callback)
        if (isfunction(callback)) then
            process.sql.query("select * from "..sql_table.name.." where steamID = "..sql.SQLStr(steamID), function (data)
                if (data[1]) then
                    callback(unpacks_query_result(data[1]))
                else
                    callback(false)
                end
            end)
        else
            local data = process.sql.query("select * from "..sql_table.name.." where steamID = "..sql.SQLStr(steamID))[1]
            if (data[1]) then
                return unpacks_query_result(data)
            else
                return false
            end
        end
    end
    process.sql[key].exist = function (steamID)
        return process.sql.query("select * from "..sql_table.name.." where steamID = "..sql.SQLStr(steamID))[1]
    end
    process.sql[key].insert_into = function (steamID, ...)
        local args = {...}
        local fromatted_args = ""
        for i, arg in pairs(args) do
            fromatted_args = fromatted_args..","..tostring(sql_table.values[i].type == "text" and sql.SQLStr(arg) or arg)
        end
        process.sql.query("insert into "..sql_table.name.." (steamID"..insert_into_values..") values ("..sql.SQLStr(steamID)..fromatted_args..")")
    end

    process.sql.query( "CREATE TABLE IF NOT EXISTS "..sql_table.name.." (steamID text"..create_values.." )" )
end