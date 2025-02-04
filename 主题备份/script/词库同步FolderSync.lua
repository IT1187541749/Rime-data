

--[[
①在主题里添加⬇️⬇️⬇️
FolderSynclua: {label: "同步", functional: false, send: function, command: "词库同步FolderSync.lua", option: "FolderSync里面“自动操作”的“同步”内容。"}
②添加到相应的按键
注释：option的内容为：FolderSync里面“自动操作”的“同步”内容。
--]]

require "import"
import "android.content.Intent"
import "android.net.Uri"



local 参数=(...)

local intent =  Intent(Intent.ACTION_VIEW,Uri.parse(参数));
service.sendEvent({functional= "false", send= "function", command="broadcast", option="com.osfans.trime.sync"})

task(1500,function()
 this.startActivity(intent);
end)


