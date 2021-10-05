
require "import"
import "cjson"

local 云输入内容="http://pv.sohu.com/cityjson?ie=utf-8"
--print("在线连接中,稍等片刻马上喝汤...\nヾ ^_^♪")
local 内容=""
local 内容组={}
Http.get(云输入内容,nil,"gbk",nil,function(a,b)
 if a==200 then 
  local 开始位置=string.find(b,"{")
  local 结束位置=string.find(b,"}",开始位置)
  内容=b:sub(开始位置,结束位置)
  local json = require "cjson"
  local 内容组=json.decode(内容)
  
  --内容=string.gsub(内容,"&nbsp"," ")
 --print(内容)
 task(100,function()
  service.addCompositions({"当前ip是 "..内容组["cip"]}) end)
 else
 print("对不起,你的网络似乎出现了点问题")
 end
 end)
