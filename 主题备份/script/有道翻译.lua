--[[
--无障碍版专用脚本
--有道翻译
--版本号: 1.1
--新增翻译【剪切板】内容
--说明: 
--1.【编辑框选中文字】模式经测试小米max2_miui10.3上可用,其它系统可能存在兼容问题.若存在此问题,推荐复制到【剪切板】,再启用相关脚本功能
--2.经测试,中文»英语,中文»韩语,英语»中文可常用,其它短时间使用频繁的话易被有道检测为ip异常,脚本会报错,可切换网络通道避开
--制作日期
▂▂▂▂▂▂▂▂
日期: 2020年03月08日🗓️
农历: 鼠(庚子)年二月十五
时间: 21:30:55🕘
星期: 周日


--版本号: 1.0
--制作日期
▂▂▂▂▂▂▂▂
日期: 2020年03月07日🗓️
农历: 鼠(庚子)年二月十四
时间: 21:27:01🕘
星期: 周六
--用途：多国语言互译,可翻译【当前候选】,【编辑框选中文字】及【编码】,翻译内容在悬浮窗口显示
--说明: 【编码】翻译模式只支持将编码转成英文,然后翻译为中文,默认将分隔符转换为空格.目前分隔符只支持',其它待优化
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)
--目前支持以下语种间的转换
type的类型有：
AUTO 自动识别内容并翻译
ZH_CN2EN 中文　»　英语
ZH_CN2JA 中文　»　日语
ZH_CN2KR 中文　»　韩语
ZH_CN2FR 中文　»　法语
ZH_CN2RU 中文　»　俄语
ZH_CN2SP 中文　»　西语
EN2ZH_CN 英语　»　中文
JA2ZH_CN 日语　»　中文
KR2ZH_CN 韩语　»　中文
FR2ZH_CN 法语　»　中文
RU2ZH_CN 俄语　»　中文
SP2ZH_CN 西语　»　中文


]]

require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.Context" 
import "java.io.File"




有道翻译=0
local 候选 = (...)



if string.sub(候选,#候选,#候选)!=">" then
 local 目录=tostring(service.getLuaExtDir("script"))
 local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
 脚本名=string.sub(脚本名,#目录+1)--相对路径
 
 local 有道按键组={}
 --第1行
 --编码转单词或英语句子,翻译为中文
 local 按键={}
 按键["label"]="有道翻译"
 按键["click"]=""
 按键["width"]=100
 按键["height"]=20
 有道按键组[#有道按键组+1]=按键
 --第2行
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="英»中", send="function",command= 脚本名,option= "%2$s<EN2ZH_CN>"}
 按键["hint"]="编码"
 有道按键组[#有道按键组+1]=按键
 
 local 按键={}
 按键["width"]=64
 有道按键组[#有道按键组+1]=按键
 
 local 按键={}
 按键["click"]={label="返回", send="Eisu_toggle",select= "default"}
 import "script.包.其它.主键盘"
 有道按键组[#有道按键组+1]=主键盘()
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键
 
 --第3行
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键
 --中文翻译到其它语种
 local 按键={}
 按键["click"]={label="中»英", send="function",command= 脚本名,option= "%1$s<ZH_CN2EN>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»日", send="function",command= 脚本名,option= "%1$s<ZH_CN2JA>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»韩", send="function",command= 脚本名,option= "%1$s<ZH_CN2KR>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»法", send="function",command= 脚本名,option= "%1$s<ZH_CN2FR>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»俄", send="function",command= 脚本名,option= "%1$s<ZH_CN2RU>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»西", send="function",command= 脚本名,option= "%1$s<ZH_CN2SP>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键
 

 
 --第4行
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键
 --其它语种翻译为中文,一般为选中文本,部分系统有效
 local 按键={}
 按键["click"]={label="英»中", send="function",command= 脚本名,option= "%1$s<EN2ZH_CN>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="日»中", send="function",command= 脚本名,option= "%1$s<JA2ZH_CN>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="韩»中", send="function",command= 脚本名,option= "%1$s<KR2ZH_CN>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="法»中", send="function",command= 脚本名,option= "%1$s<FR2ZH_CN>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="俄»中", send="function",command= 脚本名,option= "%1$s<RU2ZH_CN>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="西»中", send="function",command= 脚本名,option= "%1$s<SP2ZH_CN>"}
 按键["hint"]="候选"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键

 --第5行
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键
 --中文翻译到其它语种
 local 按键={}
 按键["click"]={label="中»英", send="function",command= 脚本名,option= "<ZH_CN2EN>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»日", send="function",command= 脚本名,option= "<ZH_CN2JA>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»韩", send="function",command= 脚本名,option= "<ZH_CN2KR>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»法", send="function",command= 脚本名,option= "<ZH_CN2FR>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»俄", send="function",command= 脚本名,option= "<ZH_CN2RU>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="中»西", send="function",command= 脚本名,option= "<ZH_CN2SP>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键
 

 
 --第6行
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键
 --其它语种翻译为中文,一般为选中文本,部分系统有效
 local 按键={}
 按键["click"]={label="英»中", send="function",command= 脚本名,option= "<EN2ZH_CN>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="日»中", send="function",command= 脚本名,option= "<JA2ZH_CN>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="韩»中", send="function",command= 脚本名,option= "<KR2ZH_CN>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="法»中", send="function",command= 脚本名,option= "<FR2ZH_CN>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["click"]={label="俄»中", send="function",command= 脚本名,option= "<RU2ZH_CN>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 
 local 按键={}
 按键["click"]={label="西»中", send="function",command= 脚本名,option= "<SP2ZH_CN>"}
 按键["hint"]="剪切板"
 有道按键组[#有道按键组+1]=按键
 local 按键={}
 按键["width"]=2
 有道按键组[#有道按键组+1]=按键


service.setKeyboard{
  name="有道键盘",
  ascii_mode=0,
  width=16,
  height=30,
  keys=有道按键组
  }


 有道翻译=1
 
 else--if 有道翻译==0


local 实际内容=候选
local 翻译类型="AUTO"

if string.sub(候选,1,1)!="<" && string.sub(候选,#候选-9,#候选-9)=="<" && string.sub(候选,#候选,#候选)==">" then
 实际内容=string.sub(候选,1,#候选-10)
 实际内容=string.gsub(实际内容,"'"," ")
 实际内容=string.gsub(实际内容,"%.","")
 翻译类型=string.sub(候选,#候选-8,#候选-1)
end

if string.sub(候选,1,1)=="<" then
 实际内容=tostring(service.getSystemService(Context.CLIPBOARD_SERVICE).getText()) --获取剪贴板 
 翻译类型=string.sub(候选,#候选-8,#候选-1)
end--if string.sub(候选,1,1)=="<"


local 云输入内容="http://fanyi.youdao.com/translate?&doctype=json&type="..翻译类型.."&i="..实际内容

Http.get(云输入内容,nil,"utf8",nil,function(a,b)
 if a==200 then 
  if string.find(b,"ip的请求异常频繁")!=nil then
   print("有道检测ip请求频繁,建议切换网络")
   return
  end
 json=import"cjson"
 local jx=json.decode(b)
 local 翻译内容=jx.translateResult[1][1].tgt
 local 内容1=翻译内容..".("..实际内容..")"
 task(100,function()
  service.addCompositions({翻译内容,内容1}) end)
 else
 print("网络似乎出了问题")
 end
 end)
有道翻译=0


end--if 有道翻译==0











