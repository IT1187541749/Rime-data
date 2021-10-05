

function 字符串转数组(str)
    if str == nil or type(str) ~= "string" then
        return
    end

    return loadstring("return " .. str)()
end



local function 数组字符串(value)
    if type(value)=='table' then
        return 数组转字符串(value)
    elseif type(value)=='string' then
        return "\'"..value.."\'"
    else
        return tostring(value)
    end
end

--使用的时候是这个
function 数组转字符串(t)
    if t == nil then return "" end
    local retstr= "{"

    local i = 1
    for key,value in pairs(t) do
        local signal = ","
        if i==1 then
            signal = ""
        end

        if key == i then
            retstr = retstr..signal..数组字符串(value)
        else
            if type(key)=='number' or type(key) == 'string' then
                retstr = retstr..signal..'['..数组字符串(key).."]="..数组字符串(value)
            else
                if type(key)=='userdata' then
                    retstr = retstr..signal.."*s"..数组转字符串(getmetatable(key)).."*e".."="..数组字符串(value)
                else
                    retstr = retstr..signal..key.."="..数组字符串(value)
                end
            end
        end

        i = i+1
    end

    retstr = retstr.."}"
    return retstr
end

