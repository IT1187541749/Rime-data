require "import"
import "android.content.Context"


local 云输入内容="http://www.nows.fun/"
print("在线连接中,稍等片刻马上喝汤...\nヾ ^_^♪")
local 内容=""
local 内容1=""
Http.get(云输入内容,nil,"utf8",nil,function(a,b)
 if a==200 then 
  local 开始位置=string.find(b,"id=\"sentence")
  开始位置=string.find(b,">",开始位置)
  local 结束位置=string.find(b,"<",开始位置)
  内容=string.sub(b,开始位置+1,结束位置-1)
  内容1=内容.."\n——骚年,干了这碗毒鸡汤吧"
 --print(内容)
 task(100,function()
  service.addCompositions({内容,内容1}) end)
 else
 print("对不起,你的网络似乎出现了点问题")
 end
 end)
