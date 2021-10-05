--[[
用法一
脚本放置script目录
当前主题文件找到preset_keys节点,加入以下内容
preset_keys:
  Lua_lx: {label: 联想, send: function, command: '在线联想词.lua', option: ""}
  
向该主题方案任意键盘按键中加入上述按键既可
--------------------
用法二
①放到脚本启动器->脚本库目录 下任意位置及子文件夹中,脚本启动器自动显示该脚本
②主题方案挂载脚本启动器
③显示一个键盘界面,点击按键即可




--------------------
--关键字跳转


--定义键盘
--------------------^


]]
require "import"
import "java.io.File"
import "android.os.*"


import "script.包.其它.主键盘"

import "com.osfans.trime.*" --载入包





local 参数=(...)
local 编号=1


local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 脚本相对路径=string.sub(脚本名,#脚本目录+1)
local 纯脚本名=File(脚本名).getName()


local 配置文件=脚本目录.."/脚本配置_勿删.txt"
local 测试功能=false
local 定制宽度=默认宽度
if File(配置文件).exists() then--配置文件存在
  for c in io.lines(配置文件) do--按行读取文件,检测脚本是否己启用
   if c=="测试功能=已启用" then
    测试功能=true
   end
  end--for
end--if 配置文件



local 己上屏文字=""
local 当前候选=Rime.getComposingText()  --当前候选


if 当前候选!=nil && 当前候选!="" then 
 己上屏文字=当前候选
 service.commitText(己上屏文字)
 Key.presetKeys.key_Esc={label= "aaa",send= "Escape"}
  service.sendEvent("key_Esc")
end


--跳转位置
if string.find(参数,"<<")!=nil && string.find(参数,">>")!=nil then
 编号=tonumber(string.sub(参数,string.find(参数,"<<")+2,string.find(参数,">>")-1))
 --print(编号)
end

--上屏数据
if string.find(参数,"【【")!=nil && string.find(参数,"】】")!=nil then
 己上屏文字=string.sub(参数,string.find(参数,"【【")+6,string.find(参数,"】】")-1)
 编号=1
 service.commitText(己上屏文字)
end

--翻页数据
if string.find(参数,"《《")!=nil && string.find(参数,"》》")!=nil then
 己上屏文字=string.sub(参数,string.find(参数,"《《")+6,string.find(参数,"》》")-1)
end



function 联想词组处理(联想词组)
 local 键盘名称=己上屏文字.." 联想词"
 if #联想词组<1 then
  print(己上屏文字.." 无匹配联想,请选择退出")
  return
 end

if 参数=="《《返回首页》》" then
  编号=1
end





--定义键盘
--------------------
local 短语数=10--单个键盘的短语数量
local 默认宽度=50
local 默认高度=32


import "android.content.pm.PackageManager"
local 版本号 = service.getPackageManager().getPackageInfo(service.getPackageName(), 0).versionName
local 版本号1=tonumber(string.sub(版本号,-8))

if 版本号1<20200526 then
 print("说明: 中文输入法版本号低于20200526,请升级到以上版本,否则无法运行该脚本")
 return
end


local 按键组={}

local 总序号=math.ceil(#联想词组/短语数)
 local 按键={}
 按键["width"]=100
 按键["height"]=25
 按键["click"]=""
 按键["label"]=键盘名称.."("..编号.."/"..总序号..")"
 按键组[#按键组+1]=按键

if 编号==1 then
 if #联想词组<短语数 then
  for i=1,#联想词组 do
    local 按键={}
    local 位置=i
    按键["click"]={label=联想词组[位置], send="function",command= 脚本相对路径,option= "【【"..联想词组[位置].."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
  end--
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数-#联想词组 do
   按键组[#按键组+1]=按键
  end--for
  
  local 按键={}
  按键["width"]=33
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=33
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
  local 按键=主键盘()
  按键["width"]=34
  按键组[#按键组+1]=按键
 else
  
 --按键组[#按键组+1]=按键2
  for i=1,短语数 do
   local 子编号=i
   if #联想词组>子编号-1 then
    local 按键={}
    local 位置=子编号
    按键["click"]={label=联想词组[位置], send="function",command= 脚本相对路径,option= "【【"..联想词组[位置].."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
   end--if #联想词组>
  end--for
 local 按键={}
 按键["width"]=33
 按键["click"]={label="下一页", send="function",command= 脚本相对路径,option= "《《"..己上屏文字.."》》<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=33
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=34
 按键组[#按键组+1]=按键


 end--if #联想词组<25
end--if 编号==1

if 编号>1 then
if #联想词组<编号*短语数 then
  for i=1,#联想词组-(编号-1)*短语数 do
    local 按键={}
    local 位置=i+(编号-1)*短语数
    按键["click"]={label=联想词组[位置], send="function",command= 脚本相对路径,option= "【【"..联想词组[位置].."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数*编号-#联想词组 do
   按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=33
  按键["click"]={label="上一页", send="function",command= 脚本相对路径,option= "《《"..己上屏文字.."》》<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
  按键["width"]=33
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=34
 按键组[#按键组+1]=按键

else
  for i=1,短语数 do
   local 子编号=i
   if #联想词组>子编号-1 then
    local 按键={}
    local 位置=子编号+(编号-1)*短语数
    按键["click"]={label=联想词组[位置], send="function",command= 脚本相对路径,option= "【【"..联想词组[位置].."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
   end--if
  end--for
  local 按键={}
  按键["width"]=25
 按键["click"]={label="上一页", send="function",command= 脚本相对路径,option= "《《"..己上屏文字.."》》<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
 按键["width"]=25
 按键["click"]={label="下一页", send="function",command= 脚本相对路径,option= "《《"..己上屏文字.."》》<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
  按键["width"]=25
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=25
 按键组[#按键组+1]=按键


end--if #联想词组>编号*22
end--if 编号>1 



 service.setKeyboard{
  name=键盘名称,
  ascii_mode=0,
  width=默认宽度,
  height=默认高度,
  keys=按键组
  }
end--function 联想词组处理

local 云输入内容1="http://suggestion.baidu.com/su?wd="..己上屏文字.."&p=3&cb=window.bdsug.sug"
--print("在线连接中,稍等片刻喔...\nヾ ^_^♪")
Http.get(云输入内容1,nil,"utf8",nil,function(a,b)
 if a==200 then 
  local 开始位置=string.find(b,"%[")
  local 结束位置=string.find(b,"%]",开始位置+1)
  local 内容=string.sub(b,开始位置,结束位置)
  
  local json = require "cjson"
  local 联想词组={}
  联想词组=json.decode(内容)
  for i=1, #联想词组 do
   联想词组[i]=string.sub(联想词组[i],#己上屏文字+1)
  end
  local 云输入内容2="http://w.sugg.sogou.com/sugg/ajaj_json.jsp?key="..己上屏文字.."&type=web"
   
   Http.get(云输入内容2,nil,"utf8",nil,function(a,b)
    if a==200 then 
     local 开始位置=string.find(b,",%[")
     local 结束位置=string.find(b,"%]",开始位置+1)
     local 内容=string.sub(b,开始位置+1,结束位置)
     --print(内容)
     local json = require "cjson"
     local 联想词组2={}
     联想词组2=json.decode(内容)
     for i=1, #联想词组2 do
      联想词组[#联想词组+1]=string.sub(联想词组2[i],#己上屏文字+1)
     end
     联想词组处理(联想词组)
    end
   end)
 else
 print("对不起,你的网络似乎出现了点问题")
 end
end)






