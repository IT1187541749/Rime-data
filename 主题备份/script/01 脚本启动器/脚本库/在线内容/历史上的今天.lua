


local 日期=tostring(os.date("%Y年%m月%d日"))

local 云输入内容="http://m.verydaily.com/"
--print("在线连接中,稍等片刻马上喝汤...\nヾ ^_^♪")
local 内容=""
local 内容组={}
Http.get(云输入内容,nil,"gb2312",nil,function(a,b)
 if a==200 then 
  local 开始位置=string.find(b,"picbox")
  开始位置=string.find(b,"<p><a",开始位置+1)
  开始位置=string.find(b,">",开始位置+1)
  local 结束位置=string.find(b,"</a><br>",开始位置+1)
  内容="▂▂▂▂▂▂▂▂\n历史上的今天\n今日: "..日期.."\n"..string.sub(b,开始位置+1,结束位置-1)--日期 星期
  开始位置=string.find(b,"<span>",开始位置)
  结束位置=string.find(b,"</span>",开始位置)
  内容=内容.."【"..string.sub(b,开始位置+6,结束位置-1).."】"--
  
  开始位置=string.find(b,"<p><a",开始位置+1)
  开始位置=string.find(b,">",开始位置+1)
  结束位置=string.find(b,"</a><br>",开始位置+1)
  内容=内容.."\n"..string.sub(b,开始位置+1,结束位置-1)--日期 星期
  开始位置=string.find(b,"<span>",开始位置)
  结束位置=string.find(b,"</span>",开始位置)
  内容=内容.."【"..string.sub(b,开始位置+6,结束位置-1).."】"--
  
  开始位置=string.find(b,"<p><a",开始位置+1)
  开始位置=string.find(b,">",开始位置+1)
  结束位置=string.find(b,"</a><br>",开始位置+1)
  内容=内容.."\n"..string.sub(b,开始位置+1,结束位置-1)--日期 星期
  开始位置=string.find(b,"<span>",开始位置)
  结束位置=string.find(b,"</span>",开始位置)
  内容=内容.."【"..string.sub(b,开始位置+6,结束位置-1).."】"--
  
  开始位置=string.find(b,"<p><a",开始位置+1)
  开始位置=string.find(b,">",开始位置+1)
  结束位置=string.find(b,"</a><br>",开始位置+1)
  内容=内容.."\n"..string.sub(b,开始位置+1,结束位置-1)--日期 星期
  开始位置=string.find(b,"<span>",开始位置)
  结束位置=string.find(b,"</span>",开始位置)
  内容=内容.."【"..string.sub(b,开始位置+6,结束位置-1).."】"--
  
  开始位置=string.find(b,"<p><a",开始位置+1)
  开始位置=string.find(b,">",开始位置+1)
  结束位置=string.find(b,"</a><br>",开始位置+1)
  --内容=内容.."\n"..string.sub(b,开始位置+1,结束位置-1)--日期 星期
  开始位置=string.find(b,"<span>",开始位置)
  结束位置=string.find(b,"</span>",开始位置)
  --内容=内容.."【"..string.sub(b,开始位置+6,结束位置-1).."】"--
  
  内容=string.gsub(内容,"<br>","\n")
  内容=string.gsub(内容,"&nbsp;"," ")
  内容=string.gsub(内容,"<.->","")
  内容=string.gsub(内容,"&ldquo;","\"")
  内容=string.gsub(内容,"&rdquo;","\"")
  --内容=string.gsub(内容,"&nbsp"," ")
 --print(内容)
 task(100,function()
  service.addCompositions({内容}) end)
 else
 print("对不起,你的网络似乎出现了点问题")
 end
 end)
