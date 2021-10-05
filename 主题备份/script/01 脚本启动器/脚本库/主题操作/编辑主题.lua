

require "import"
import "java.io.*"
import "android.content.*"
import "script.包.其它.主键盘"


import "com.osfans.trime.*" --载入包

local 参数=(...)
local 输入法目录=tostring(service.getLuaExtDir(""))

local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
--local 目录=string.sub(脚本路径,1,字符串_倒找(脚本路径,"/")-1)

local 纯脚本名=File(脚本路径).getName()
local 目录=string.sub(脚本路径,1,#脚本路径-#纯脚本名)

local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)


local 主题组1=Config.getThemeKeys(true)

local 主题组={}

--读取数组元素
for i=1,#主题组1 do
 主题组[i]=tostring(主题组1[i-1])
end
table.sort(主题组)--数组排序

local 文件组={}
local 主题名称组={}
--读取数组元素
for i=1,#主题组 do
 文件组[i]=输入法目录.."/"..主题组[i]
 主题名称组[i]=主题组[i]:sub(1,-12)
 if 主题组[i]=="tongwenfeng.trime.yaml" then 主题名称组[i]="同文风" end
 if 主题组[i]=="trime.yaml" then 主题名称组[i]="默认" end
end

if 参数!=nil && string.find(参数,"【【")!=nil && string.find(参数,"】】")!=nil then
 local 数据文件=string.sub(参数 ,string.find(参数,"【【")+6,string.find(参数,"】】")-1)
 service.editFile(数据文件) 
 return
end





local 编号=1
local 短语数=10--单个键盘的短语数量
local 默认宽度=50
local 总序号=math.ceil(#文件组/短语数)


if string.find(参数,"<<")!=nil && string.find(参数,">>")!=nil then
 编号=tonumber(string.sub(参数,string.find(参数,"<<")+2,string.find(参数,">>")-1))
 --print(编号)
end





local 按键组={}

local 按键1={}
 按键1["width"]=100
 按键1["height"]=25
 按键1["click"]=""
 按键1["label"]=string.sub(纯脚本名,1,#纯脚本名-4).."("..tostring(编号).."/"..总序号..")"
 按键组[#按键组+1]=按键1



if 编号==1 then
 if #文件组<=短语数 then
  --按键组=文件组
  for i=1,#文件组 do
   local 按键={}
   local 位置=i
   按键["click"]={label=主题名称组[位置], send="function",command= 脚本相对路径,option= "【【"..文件组[位置].."】】"}
   按键组[#按键组+1]=按键
   
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数-1-#文件组 do
   按键组[#按键组+1]=按键
  end--for
  按键组[#按键组+1]=主键盘()
 else
  for i=1,短语数 do
   local 子编号=i
   if #文件组>子编号-1 then
    local 按键={}
    local 位置=i
    按键["click"]={label=主题名称组[位置], send="function",command= 脚本相对路径,option=  "【【"..文件组[位置].."】】"}
    按键组[#按键组+1]=按键
   end--if
  end--for

 local 按键2={}
 按键2["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键2
 按键组[#按键组+1]=主键盘()

 end--if #文件组<25
end--if 编号==1

if 编号>1 then
if #文件组<编号*短语数 then
  for i=1,#文件组-(编号-1)*短语数 do
  local 按键={}
  local 位置=i+(编号-1)*短语数
   按键["click"]={label=主题名称组[位置], send="function",command= 脚本相对路径,option=  "【【"..文件组[位置].."】】"}
   按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,短语数*编号-#文件组 do
   按键组[#按键组+1]=按键
  end--for
  local 按键1={}
  按键1["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键1
 
 按键组[#按键组+1]=主键盘()
else
  for i=1,短语数 do
   local 按键={}
   local 位置=i+(编号-1)*短语数
   按键["click"]={label=主题名称组[位置], send="function",command= 脚本相对路径,option=  "【【"..文件组[位置].."】】"}
   按键组[#按键组+1]=按键
  end--for
  local 按键1={}
  按键1["width"]=33
 按键1["click"]={label="上一页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键1
 local 按键2={}
 按键2["width"]=33
 按键2["click"]={label="下一页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键2
 
 
 按键组[#按键组+1]=主键盘(32,33)

end--if #文件组>编号*22
end--if 编号>1 



service.setKeyboard{
  name=string.sub(纯脚本名,1,#纯脚本名-4),
  ascii_mode=0,
  width=默认宽度,
  height=32,
  keys=按键组
  }



