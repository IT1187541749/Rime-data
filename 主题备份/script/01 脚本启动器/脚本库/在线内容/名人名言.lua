
local 云输入内容="http://www.zzsky.cn/code/mrmy/mrmy.asp"
--print("在线连接中,稍等片刻喔...\nヾ ^_^♪")
Http.get(云输入内容,nil,"utf8",nil,function(a,b)
 if a==200 then 
  local 开始位置=string.find(b,"http")
  local 结束位置=string.find(b,"asp",开始位置)
  local 网址=string.sub(b,开始位置,结束位置+2)
 --print(内容)
  Http.get(网址,nil,"gbk",nil,function(a1,b1)
  local 开始位置2=string.find(b1,"hwmrmy")
  local 结束位置2=string.find(b1,"<",开始位置2)
  local 内容=string.sub(b1,开始位置2+8,结束位置2-1)
  
  task(100,function()
   service.addCompositions({内容}) end)
  end)--Http.get(网址
 else
 print("对不起,你的网络似乎出现了点问题")
 end
 end)
