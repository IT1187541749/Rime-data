--[[
--无障碍版专用脚本
--用途：自定义词典，可查选中参数词汇(若为字母,不区分字母大小写),若屏幕无参数,可查编辑框选中文本,释义在悬浮窗口显示
--关于词典:
-- 词条格式为 词条tab释义
--可自定义词典,为文件夹下同名txt文件,在参数中指定,详见下面例子
--滤镜及mdict词典文本文件可用,文件大小不建议超过2m,超过会卡.电脑上有相关工具将mdx词典文件转换为txt文件,转换后的txt文件可直接使用
--版本号: 1.0
--制作日期
▂▂▂▂▂▂▂▂
日期: 2020年03月25日🗓️
农历: 鼠(庚子)年三月初二
时间: 22:53:50🕥
星期: 周三
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)
--如何安装并使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf

--配置说明
第①步 将 自定义词典/词典.lua 文件放置 rime/script 文件夹内

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys，加入以下按键

preset_keys:
  lua_dic_4w_en: {label: 翻译, send: function, command: "自定义词典/词典.lua", option: "%1$s<英语4w简明词典>"} #选中的参数»释义
  lua_dic_4w_en_2: {label: 翻译, send: function, command: "自定义词典/词典.lua", option: "%2$s<英语4w简明词典>"} #编码»英语单词»中文释义


向该主题方案任意按键加入上述按键既可
]]

require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "android.content.Context" 

local function 单词典搜索(参数,文件)
 local 内容1=""
 for 行内容 in io.lines(文件) do
 if string.lower(string.sub(行内容,1,#参数+1))==string.lower(参数.."\t") then
  内容1=string.sub(行内容,#参数+1,#行内容)
  return 内容1
 end
 end
return 内容1
end

local function 词典搜索(参数内容)
  local 文件组={}
  local 内容=参数内容
  if string.sub(参数内容,-1)==">"then
   local 左括号位置=string.find(string.reverse(参数内容),"<")--字符串反转
   if 左括号位置!=nil then
    local 参数内容=string.sub(参数内容,#参数内容-左括号位置+2,#参数内容-1)
    内容=string.sub(参数内容,1,#参数内容-左括号位置)
    分隔符位置=string.find(参数内容,",")
    if 分隔符位置!=nil then
     文件名组=字符串分割(参数内容,",")
     for i=1,#文件名组 do
     文件组[#文件组+1]=tostring(service.getLuaExtDir("script")).."/自定义词典/"..文件名组[i]..".txt"      
     end
    else
     if 参数内容=="all" then
      文件组=递归查找文件(File(tostring(service.getLuaExtDir("script/自定义词典"))),".txt")
     else
     文件组[1]=tostring(service.getLuaExtDir("script")).."/自定义词典/"..参数内容..".txt"
     end
    end
    --print(参数内容)
   end
  end
  local 返回内容组={内容}
  for i=1, #文件组 do
    local 返回内容=单词典搜索(内容,tostring(文件组[i]))
    if 返回内容!="" then 返回内容组[#返回内容组+1]=返回内容 end
  end
  return 返回内容组
end



local 参数 = (...)
local 默认宽度=33


local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 目录=string.sub(脚本路径,1,倒找字符串(脚本路径,"/")-1)
local 纯脚本名=File(脚本路径).getName()
local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)

local 数据文件=string.sub(脚本路径,1,#脚本路径-3).."txt"

local 候选=""
if string.find(参数,"【【")!=nil && string.find(参数,"】】")!=nil then
 if 参数=="【【3】】" then 

  import "android.content.Context"  --导入类
  候选=service.getSystemService(Context.CLIPBOARD_SERVICE).getText() --获取剪贴板 
  候选=tostring(候选)
 else
  候选=string.sub(参数,1,string.find(参数,"【【")-1)
 end--if 参数=="【【3】】"
end--if string.find(参数

if 候选!="" then
 local 内容=单词典搜索(候选,数据文件)
 内容=内容:gsub("<br>","\n")
 内容=内容:gsub("&nbsp"," ")
 local 内容组={}
 if 内容=="" then
  内容组[1]="无【"..候选.."】相关内容" 
 else
  内容组[1]="你当前查询的内容是【"..候选.."】"
  内容组[2]="释义如下\n"..内容
 end
 task(300,function()
  service.addCompositions(内容组)
  end)
end--if 候选




local 按键组={}
 --第1行
 local 按键1={}
 按键1["width"]=100
-- 按键1["height"]=25
 按键1["click"]=""
 按键1["label"]=string.sub(纯脚本名,1,#纯脚本名-4)
 按键组[#按键组+1]=按键1
 --第2行
  local 按键={}
 按键["label"]="查编码"
 按键["click"]={label="", send="function",command= 脚本相对路径,option= "%2$s【【1】】"}
 按键组[#按键组+1]=按键
 
  local 按键={}
 按键["label"]="查候选"
 按键["click"]={label="", send="function",command= 脚本相对路径,option= "%1$s【【1】】"}
 按键组[#按键组+1]=按键
 
 local 按键={}
 按键["label"]="查剪切板"
 按键["click"]={label="", send="function",command= 脚本相对路径,option= "【【3】】"}
 按键组[#按键组+1]=按键
 

 --第3行
 local 按键={}
 按键["click"]="Left"
 按键["has_menu"]="Left"
 按键组[#按键组+1]=按键
 
 local 按键={}
 按键["click"]="Up"
 按键["has_menu"]="Up"

 按键组[#按键组+1]=按键
 local 按键={}
 按键["click"]="Right"
 按键["has_menu"]="Right"

 按键组[#按键组+1]=按键
 
 --第4行
 local 按键={}
 按键["width"]=33
 按键组[#按键组+1]=按键
 local 按键={}
 按键["click"]="Down"
 按键["has_menu"]="Down"

 按键组[#按键组+1]=按键
 
 import "script.包.其它.主键盘"
 local 按键=主键盘()
 按键组[#按键组+1]=按键
 
service.setKeyboard{
  name=string.sub(纯脚本名,1,#纯脚本名-4),
  ascii_mode=0,
  width=默认宽度,
  height=50,
  keys=按键组
  }









