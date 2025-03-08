--[[
--无障碍版专用脚本
--用途：一键加词到指定文件并调用FolderSync的同步功能，同步文件到云盘.
--如何使用: 请参考群文件，路径[同文无障碍LUA脚本]->同文无障碍版lua脚本使用说明.pdf
--感谢风老师的细心指导🐂🍺
--本脚本是由两个脚本合并而成，都是从qq群“中文输入法同文无障碍”中下载的，群号：938020953，一键加词的作者是谁我不知道，词库同步FolderSync.lua的作者是：合欢。
--配置说明
第①步 修改个人词库文件名，默认为xklb_phone_sdjc.txt，请修改为自己的词库名

第②步 将 一键加词+词库同步FolderSync.lua 文件放置 rime/script 文件夹内

第➂步 向主题里添加⬇️⬇️⬇️，以 XXX.trime.yaml主题方案为例
preset_keys:
  yjjc_lua+FolderSynclua: {label: "加词同步", functional: false, send: function, command: "一键加词+词库同步FolderSync.lua", option: "FolderSync里面“自动操作”的“同步”内容。"}
向任意按键加入上述按键既可
注释：option的内容为：FolderSync里面“创建文件夹对”后中有个设置项为“自动操作”的“同步”内容，需要提前在app设置-自动操作-启用□-打上✓后才能在“文件夹对”的设置中出现自动操作这个选项，option后面的内容类似如下内容，每台设备上的内容都是不同的，必须单独设置，不可共用。⬇️⬇️⬇️
  yjjc_lua+FolderSynclua: {label: "加词同步", functional: false, send: function, command: "一键加词+词库同步FolderSync.lua", option: "https://www.tacit.dk/app/foldersync/trigger/2dc64083ed204cd8bfdd35517c631b39/folderpair/2/action/sync-start?folderPairVersion=2"}

第④步 在任意输入框输入“词条”，例如 星空两笔
然后点击第③步添加的按键即可添加词组并同步到FolderSync(可批量一次性添加多个词,一行一个词)
]]



require "import"
import "android.content.Intent"
import "android.net.Uri"
import "android.widget.*"
import "android.view.*"
import "java.io.*"
import "java.io.File"
import "com.osfans.trime.*" --载入包
import "script.包.字符串.其它"



--一键加词组件:
Key.presetKeys.lua_script_1={label= '全选', send= "Control+a"}
Key.presetKeys.lua_script_2={label= '删除', send="BackSpace"}
service.sendEvent("lua_script_1")
local 词组= service.getCurrentInputConnection().getSelectedText(0)--取编辑框选中内容,部分app内无效
local 数据文件=tostring(service.getLuaDir("")).."/X2.extended.dict.yaml"--用户码表

if 词组== nil or 词组==""then
do return end --强制退出
end

io.open(数据文件,"a+"):write(词组):close()
io.open(数据文件,"a+"):write("\n"):close()
service.sendEvent("lua_script_2")
Toast.makeText(service," 词组【"..词组.."】 添加成功",100).show()



--同步词库组件:
local 参数=(...)

local intent =  Intent(Intent.ACTION_VIEW,Uri.parse(参数));

task(500,function()
 this.startActivity(intent);
end)



--重新部署组件(需要等待10秒左右才能部署完成,请耐心等待),删除下行行首的字符--可启用部署.
service.sendEvent("Deploy")
