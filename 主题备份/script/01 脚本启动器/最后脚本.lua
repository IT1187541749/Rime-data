

require "import"
import "java.io.File"

local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 脚本相对路径=string.sub(脚本名,#脚本目录+1)
local 纯脚本名=File(脚本名).getName()
local 纯脚本名无后缀=File(脚本名).getName():sub(1,-5)

local 最近文件=string.sub(脚本名,1,#脚本名-#纯脚本名).."最近文件.txt"
local 最后脚本=""
--按行读取文件
for c in io.lines(最近文件) do
 最后脚本=c
 break --退出循环
end --for结束



Key.presetKeys.lua_script_l={label= "脚本", send="function", command=最后脚本, option="%1$s"}
service.sendEvent("lua_script_l")

