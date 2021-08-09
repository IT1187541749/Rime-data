
require "import"
import "script.包.其它.java随机数"



print("在线连接中,稍等片刻马上喝汤...\nヾ ^_^♪")

--[[
local 云输入内容="https://duanziwang.com/category/%E4%B8%80%E5%8F%A5%E8%AF%9D%E6%AE%B5%E5%AD%90"

Http.get(云输入内容,nil,"utf8",nil,function(a,b)
 local 内容=""
 if a==200 then 
  local 开始位置=string.find(b,"page.number")
  local 开始位置=string.find(b,"共",开始位置)
  local 结束位置=string.find(b,"</span>",开始位置)
  
  local 总页数=tonumber(string.sub(b,开始位置+3,结束位置-4))
  local 随机页数=java随机整数(总页数-1)

]]

  local 随机页数=java随机整数(323)+1--实际页面325,取2到324
  local 云输入内容01="https://duanziwang.com/category/%E4%B8%80%E5%8F%A5%E8%AF%9D%E6%AE%B5%E5%AD%90/"..随机页数.."/"
print(云输入内容01)
  Http.get(云输入内容01,nil,"utf8",nil,function(a1,b1)
  if a1==200 then
   local 笑话位置=java随机整数(10)
   local 开始位置=0
   local 内容=""
   for i=1,笑话位置 do
    开始位置=string.find(b1,"post.content",开始位置+1)
    if 笑话位置==i then
     local 结束位置=string.find(b1,"</div>",开始位置)
     内容=string.sub(b1,开始位置+18,结束位置-1)
     --替换空格,换行
     内容=内容:gsub("&nbsp"," ")
     内容=内容:gsub("<br>","\n")
     内容=内容:gsub("ldquo;","\"")
     --清除网页标签
     内容=内容:gsub("<.->","")
     
    end--if 笑话位置
   end--for i=1,笑话位置
   task(100,function()
    service.addCompositions({内容}) end)
  else
   print("对不起,你的网络似乎出现了点问题")
  end--if a1==200
 end)
 
--[[
 else
 print("对不起,你的网络似乎出现了点问题")
 end--if a==200
 end)


]]