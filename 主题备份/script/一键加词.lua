--[[
--无障碍版专用脚本
--用途：一键加词
--如何使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf
--感谢风老师的细心指导🐂🍺
--配置说明
第①步 修改个人词库文件名，默认为xklb_phone_sdjc.txt，请修改为自己的词库名

第②步 将 一键加词.lua 文件放置 rime/script 文件夹内

第➂步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
preset_keys:
  yjjc_lua: {label: 📑, send: function, command: '一键加词.lua', option: "%4$s"}
向任意按键加入上述按键既可

第④步 在任意输入框输入“词条”，例如 星空两笔
然后点击第③步添加的按键即可(可批量一次性添加多个词,一行一个词)
]]

require "import"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "java.io.File"
import "com.osfans.trime.*" --载入包
import "script.包.字符串.其它"



Key.presetKeys.lua_script_1={label= '全选', send= "Control+a"}
Key.presetKeys.lua_script_2={label= '删除', send="BackSpace"}
service.sendEvent("lua_script_1")
local 词组= service.getCurrentInputConnection().getSelectedText(0)--取编辑框选中内容,部分app内无效
local 数据文件=tostring(service.getLuaDir("")).."/X1.extended.dict.yaml"--用户码表

if 词组== nil or 词组==""then
do return end --强制退出
end

io.open(数据文件,"a+"):write(词组):close()
io.open(数据文件,"a+"):write("\n"):close()
service.sendEvent("lua_script_2")
Toast.makeText(service," 词组【"..词组.."】 添加成功",100).show()

--重新部署(需要等待10秒左右才能部署完成,请耐心等待),删除下行行首的字符--可启用部署.
service.sendEvent("Deploy")
