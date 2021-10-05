
require "import"
import "cjson"

import "com.osfans.trime.*" --载入包

  --拼音云输入
  --当前首选项为谷歌拼音云，后续为百度拼音云
local 当前编码=Rime.RimeGetInput() --当前编码
local 云输入内容1="https://www.google.cn/inputtools/request?ime=pinyin&text="..当前编码
local 候选组={}

Http.get(云输入内容1,function(c,t)
 if c==200 then
  local s1 = string.find(t,当前编码)+#当前编码+4 
  local s2 = string.find(t,"]") -2
  local 谷歌候选=string.sub(t,s1,s2)
  候选组[#候选组+1]=谷歌候选
  local 云输入内容2="http://olime.baidu.com/py?input="..当前编码.."&inputtype=py&bg=0&ed=20&result=hanzi&resultcoding=utf-8&ch_en=0&clientinfo=web&version=1"
  Http.get(云输入内容2,function(c2,t2)
  local s1 = string.find(t2,"result")+12
  local s2 = string.find(t2,"\"",s1+1) -2
  local 百度候选=string.sub(t2,s1,s2+1)
  if 百度候选!=谷歌候选 then 候选组[#候选组+1]=百度候选 end
  service.addCompositions(候选组)
  end)
  
 else
   print("对不起,你的网络似乎出现了点问题")
 end--if c==200
 
end)


