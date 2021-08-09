
require "import"
import "script.包.其它.首次启动提示"
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 脚本名=File(脚本路径).getName()
local 目录=string.sub(脚本路径,1,#脚本路径-#脚本名)
local 提示内容=[[
说明:本脚本获取编码,视作英语单词,通过联网查询单词相关释义
]]
if 首次启动提示(脚本名,提示内容) then return end



import "com.osfans.trime.*" --载入包
local 单词=Rime.RimeGetInput() --當前編碼

local 云输入内容="http://ws.webxml.com.cn//WebServices/TranslatorWebService.asmx/getEnCnTwoWayTranslator?Word="..单词
--print("在线连接中,稍等片刻喔...\nヾ ^_^♪")
Http.get(云输入内容,nil,"utf8",nil,function(a,t)
 if a==200 then
  
  local 起始1,结束1=string.find(t,"<string />",1,true)
  local 内容=""
  if 起始1==nil then
    local 内容1=string.sub(t,string.find(t,"<string>")+8,string.find(t,"</string>")-1)
    local 内容2=string.sub(t,string.find(t,"<string>",string.find(t,"<string>")+1)+8,string.find(t,"</string>",string.find(t,"</string>")+1)-2)
    内容=string.gsub(内容1..内容2,"|","")
  else
    内容="无【"..单词.."】注解"
  end
  
  task(100,function()
   service.addCompositions({内容}) end)
  
 else
 print("对不起,你的网络似乎出现了点问题")
 end
 end)
