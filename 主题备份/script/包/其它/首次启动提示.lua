

require "import"
import "java.io.*"


function 首次启动提示(脚本名, 提示内容)--有提示返回真,无提示返回假
 local 返回=false
 local 目录=tostring(service.getLuaExtDir("script"))
 local 配置文件=目录.."/脚本配置_勿删.txt"
 
 if File(配置文件).exists()==false then--配置文件不存在
  返回=true
 else
  local 已启用=false
  for c in io.lines(配置文件) do--按行读取文件,检测脚本是否己启用
   if c==脚本名.."=已启用" then 已启用=true end
  end--for
  if 已启用==false then 返回=1 end
 end--if 配置文件不存在
 if 返回 then
  io.open(配置文件,"a+"):write("\n"..脚本名.."=已启用"):close()
  task(300,function() service.addCompositions({提示内容})
end)
 end--if 返回==1
 return 返回
end--首次启动提示
