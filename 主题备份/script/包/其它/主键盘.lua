
require "import"
import "java.io.File"--导入File类

function 主键盘(高度,宽度)--设置主键盘按键
 
 local 脚本目录=tostring(service.getLuaExtDir("script"))
 local 脚本配置=脚本目录.."/脚本配置_非通用键盘.txt"
 --print(脚本配置)
 local 按键={}
 if File(脚本配置).exists() then
  按键["click"]={label="退出", send="Eisu_toggle",select= "default_zd"}
 else
  按键["click"]={label="退出", send="Eisu_toggle",select= "default"}
 end--if File(脚本配置)
 if 高度!=nil then 按键["height"]=高度 end
 if 宽度!=nil then 按键["width"]=宽度 end
 按键["click"]={label="退出", send="Eisu_toggle",select= "default_zd"}
 
 
 
 return 按键
end--function 主键盘

