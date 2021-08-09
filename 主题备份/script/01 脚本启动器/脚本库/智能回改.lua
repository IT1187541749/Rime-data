
require "import"
import "android.content.Context" 
import "com.osfans.trime.*" --载入包
import "script.包.字符串.倒找字符串"
import "script.包.其它.首次启动提示"


local 提示内容=[[
首次使用说明:本脚本效果为增强esc键,以分词键为最小间隔去除编码
目前支持的分词符为 '"`
更多请自行在脚本中加入
适用于整句
]]

if 首次启动提示("智能回改",提示内容) then return end


local 编码=Rime.RimeGetInput() --当前编码
local 分词码组="\'\"`"
local 分词最后=false
for i=1,#分词码组 do
 local 分词码=string.sub(分词码组,i,i)
 if string.sub(编码,#编码,#编码)==分词码 then
  编码=string.sub(编码,1,#编码-1)
  分词最后=true
 end
 
end--for

--print(编码)

local 最后位置=0
for i=1,#分词码组 do
 local 分词码=string.sub(分词码组,i,i)
 
 
 local 最后位置1=倒找字符串(编码,分词码)
 if 最后位置1>0 then 最后位置=最后位置1 end
 
end--for

if 分词最后 then 最后位置=最后位置-1 end

if 最后位置>0 then
 local 字母数=#编码-最后位置
 for i=1,字母数 do
  task(100,function() service.sendEvent("BackSpace") end)
 end--for
else
 task(100,function() service.sendEvent("Escape") end)
 
 --print("无匹配分词编码")
end--if



