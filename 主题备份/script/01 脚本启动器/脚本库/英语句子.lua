
require "import"
import "java.io.File"
import "android.os.*"

import "script.包.其它.主键盘"
import "script.包.其它.自定义短语键盘"
--自定义短语键盘(键盘名称,单个键盘短语数,默认宽度,默认高度,按键组,参数,脚本相对路径,数据文件)

local 参数=(...)
local 编号=0

local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径

local 脚本相对路径=string.sub(脚本名,#脚本目录+1)
local 纯脚本名=File(脚本名).getName()
local 数据文件=string.sub(脚本名,1,#脚本名-4)..".txt"

local 当前编码=Rime.RimeGetInput() --当前编码
local 句子=""
if #当前编码>1 then
  if string.find(当前编码,"\'")!=nil then
   句子=string.gsub(当前编码,"\'"," ")  
end--if
   end--if


if string.find(参数,"<<")!=nil && string.find(参数,">>")!=nil then
 编号=tonumber(string.sub(参数,string.find(参数,"<<")+2,string.find(参数,">>")-1))
 if 编号==1 then service.commitText(句子) end
 
 
 --print(编号)
end



local 短语数=5--单个键盘的短语数量
local 默认宽度=100
local 默认高度=32
local 短语组={}
local 按键组={}


local 键盘名称=string.sub(纯脚本名,1,#纯脚本名-4)

local 按键={}
 按键["width"]=100
 按键["height"]=25
 按键["click"]=""
 --按键["click"]={label=短语组[i],commit=短语组[i]}
 按键["label"]=键盘名称
 按键组[#按键组+1]=按键


if 句子!="" then
 local 按键={}
 按键["label"]=句子
 按键["click"]={label="◀", send="function",command= 脚本相对路径,option= "<<1>>"}
 按键组[#按键组+1]=按键

end





local 按键={}
  按键["width"]=默认宽度
  for i=1,3 do
   按键组[#按键组+1]=按键
  end--for

  local 按键=主键盘()
  --按键["label"]="退出"
  --按键["width"]=50
  按键组[#按键组+1]=按键


service.setKeyboard{
  name=键盘名称,
  ascii_mode=0,
  width=默认宽度,
  height=默认高度,
  keys=按键组
  }




