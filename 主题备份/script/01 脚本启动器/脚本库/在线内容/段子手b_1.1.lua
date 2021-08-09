
local 云输入内容="https://m.biedoul.com/wenzi/"
--print("在线连接中,稍等片刻马上喝汤...\nヾ ^_^♪")
local 内容=""
local 内容组={}
Http.get(云输入内容,nil,"utf8",nil,function(a,b)
 if a==200 then 
  local 开始位置=string.find(b,"class=\"con\">")
   
    local 结束位置=string.find(b,"</div>",开始位置)
  
  内容=string.sub(b,开始位置+12,结束位置-1)
  内容=string.gsub(内容,"<br>","\n")
  内容=string.gsub(内容,"&nbsp"," ")
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
