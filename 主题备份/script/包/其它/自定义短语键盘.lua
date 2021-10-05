--
require "import"
import "java.io.File"
import "android.os.*"

import "script.包.其它.主键盘"

--string.sub(纯脚本名,1,#纯脚本名-4)
--默认高度=32
function 自定义短语键盘(键盘名称,单个键盘短语数,默认宽度,默认高度,参数,脚本相对路径,数据文件)

import "android.content.pm.PackageManager"
local 版本号 = service.getPackageManager().getPackageInfo(service.getPackageName(), 0).versionName

local 版本号1=0
版本号1=tonumber(string.sub(版本号,-8))

if 版本号1<20200526 then
 print("说明: 中文输入法版本号低于20200526,请升级到以上版本,否则无法运行该脚本")
 return
end

local 编号=1
local 短语组={}
local 按键组={}




if 参数=="《《编辑数据》》" then
 service.editFile(数据文件) 
 return
end


if File(数据文件).exists()==false then
 io.open(数据文件,"w"):write("无数据,请编辑文件"):close()
end

for c in io.lines(数据文件) do
 if c!="" && string.sub(c,1,1)!="#" then
  c=c:gsub("<br>","\n")
  c=c:gsub("\\#","#")
  短语组[#短语组+1]=c 
 end
end--for




if 参数=="《《返回首页》》" || 参数=="《《导出数据_取消》》" || 参数=="《《导入数据_取消》》" then  编号=1 end


--跳转位置
if string.find(参数,"<<")!=nil && string.find(参数,">>")!=nil then
 编号=tonumber(string.sub(参数,string.find(参数,"<<")+2,string.find(参数,">>")-1))
 --print(编号)
end

local 总序号=math.ceil(#短语组/单个键盘短语数)
 local 按键={}
 按键["width"]=100
 按键["height"]=25
 按键["click"]=""
 --按键["click"]={label=短语组[i],commit=短语组[i]}
 按键["label"]=键盘名称.."("..编号.."/"..总序号..")"
 按键组[#按键组+1]=按键


--上屏数据
if string.find(参数,"【【")!=nil && string.find(参数,"】】")!=nil then
 local 位置=tonumber(string.sub(参数,string.find(参数,"【【")+6,string.find(参数,"】】")-1))
 service.commitText(短语组[位置])
 
 --print(位置)
end


if 编号==1 then
 if #短语组<单个键盘短语数 then
  for i=1,#短语组 do
    local 按键={}
    local 位置=i
    按键["click"]={label=短语组[位置], send="function",command= 脚本相对路径,option= "【【"..位置.."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
  end--
  local 按键={}
  按键["width"]=默认宽度
  for i=1,单个键盘短语数-#短语组 do
   按键组[#按键组+1]=按键
  end--for
  
 local 按键={}
 按键["width"]=15
 按键["click"]={label="编辑", send="function",command= 脚本相对路径,option= "《《编辑数据》》"}
 按键组[#按键组+1]=按键
 local 按键={}
 按键["width"]=15
 按键["click"]={label="下页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=25
  按键["click"]={label="➖", repeatable="true", send= "space"}
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=15
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=15
  按键["click"]={label="Enter", repeatable="true", send= "Return"}
  按键组[#按键组+1]=按键
  local 按键=主键盘()
  按键["width"]=15
  按键组[#按键组+1]=按键
 else
  
 按键组[#按键组+1]=按键2
  for i=1,单个键盘短语数 do
   local 子编号=i
   if #短语组>子编号-1 then
    local 按键={}
    local 位置=子编号
    按键["click"]={label=短语组[位置], send="function",command= 脚本相对路径,option= "【【"..位置.."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
   end--if
  end--for
 local 按键={}
 按键["width"]=15
 按键["click"]={label="编辑", send="function",command= 脚本相对路径,option= "《《编辑数据》》"}
 按键组[#按键组+1]=按键
 local 按键={}
 按键["width"]=15
 按键["click"]={label="下页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=25
  按键["click"]={label="➖", repeatable="true", send= "space"}
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=15
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=15
  按键["click"]={label="Enter", repeatable="true", send= "Return"}
  按键组[#按键组+1]=按键
  local 按键=主键盘()
  按键["width"]=15
  按键组[#按键组+1]=按键


 end--if #短语组<25
end--if 编号==1

if 编号>1 then
if #短语组<编号*单个键盘短语数 then
  for i=1,#短语组-(编号-1)*单个键盘短语数 do
    local 按键={}
    local 位置=i+(编号-1)*单个键盘短语数
    按键["click"]={label=短语组[位置], send="function",command= 脚本相对路径,option= "【【"..位置.."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=默认宽度
  for i=1,单个键盘短语数*编号-#短语组 do
   按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["width"]=20
  按键["click"]={label="上页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
  按键["width"]=20
  按键["click"]={label="➖", repeatable="true", send= "space"}
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=20
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=20
  按键["click"]={label="Enter", repeatable="true", send= "Return"}
  按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=20
 按键组[#按键组+1]=按键

else
  for i=1,单个键盘短语数 do
   local 子编号=i
   if #短语组>子编号-1 then
    local 按键={}
    local 位置=子编号+(编号-1)*单个键盘短语数
    按键["click"]={label=短语组[位置], send="function",command= 脚本相对路径,option= "【【"..位置.."】】<<"..编号..">>"}
    按键组[#按键组+1]=按键
   end--if
  end--for
  local 按键={}
  按键["width"]=15
 按键["click"]={label="上页", send="function",command= 脚本相对路径,option= "<<"..(编号-1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
 按键["width"]=15
 按键["click"]={label="下页", send="function",command= 脚本相对路径,option= "<<"..(编号+1)..">>"}
 按键组[#按键组+1]=按键
 local 按键={}
  按键["width"]=25
  按键["click"]={label="➖", repeatable="true", send= "space"}
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=15
  按键["click"]={label="⌫", repeatable="true", send= "BackSpace"}
  按键组[#按键组+1]=按键
  local 按键={}
  按键["width"]=15
  按键["click"]={label="Enter", repeatable="true", send= "Return"}
  按键组[#按键组+1]=按键
 local 按键=主键盘()
 按键["width"]=15
 按键组[#按键组+1]=按键


end--if #短语组>编号*22
end--if 编号>1 


service.setKeyboard{
  name=键盘名称,
  type="long",
  ascii_mode=0,
  width=默认宽度,
  height=默认高度,
  keys=按键组
  }


end--function 自定义短语键盘


