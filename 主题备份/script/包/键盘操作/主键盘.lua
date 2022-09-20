
require "import"
import "java.io.File"--导入File类
import "com.osfans.trime.*" --载入包
function 主键盘(高度,宽度)--设置主键盘按键
 local 脚本目录=tostring(service.getLuaExtDir("script"))
 local 脚本配置=脚本目录.."/脚本配置_非通用键盘.txt"
 --print(脚本配置)
 local 按键={}
 if File(脚本配置).exists() then
  按键["click"]={label="退出", send="function",command= "自定义键盘.lua",option= "%1$s"}
 else
  local 键盘组=Config.get().getKeyboardNames()--读取注册键盘组
  按键["click"]={label="退出", send="Eisu_toggle",select= 键盘组[0]}--取首个键盘
 end--if File(脚本配置)
 if 高度!=nil then 按键["height"]=高度 end
 if 宽度!=nil then 按键["width"]=宽度 end
 
 
 return 按键
end--function 主键盘

function 主键盘_按键信息()--设置主键盘按键
 return 主键盘()
end--function 主键盘

function 主键盘_返回()--一键返回主键盘
 local 脚本目录=tostring(service.getLuaExtDir("script"))
 local 脚本配置=脚本目录.."/脚本配置_非通用键盘.txt"
 --print(脚本配置)
 local 按键信息={}
 if File(脚本配置).exists() then
  按键信息={label="退出", send="function",command= "自定义键盘.lua",option= "%1$s"}
 else
  local 键盘组=Config.get().getKeyboardNames()--读取注册键盘组
  按键信息={label="退出", send="Eisu_toggle",select= 键盘组[0]}--取首个键盘
 end--if File(脚本配置)
 Key.presetKeys.lua_script_Keyboard=按键信息
 service.sendEvent("lua_script_Keyboard")
end--function 主键盘_执行



