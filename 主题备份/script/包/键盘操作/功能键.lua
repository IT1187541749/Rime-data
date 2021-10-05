require "import"
import "com.osfans.trime.*" --载入包


function 功能_全选()
 Key.presetKeys.lua_Keyboard={label="全选", send="Control+a"}
 service.sendEvent("lua_Keyboard")
end

function 功能_剪切()
 Key.presetKeys.lua_Keyboard={label="剪切", send="Control+x"}
 service.sendEvent("lua_Keyboard")
end

function 功能_复制()
 Key.presetKeys.lua_Keyboard={label="复制", send="Control+c"}
 service.sendEvent("lua_Keyboard")
end

function 功能_删除()
 Key.presetKeys.lua_Keyboard={label="删除", send="BackSpace"}
 service.sendEvent("lua_Keyboard")
end

function 功能_部署()
Key.presetKeys.lua_Keyboard={label= '重新部署', send= "function", functional= "false", command= "broadcast", option="com.osfans.trime.deploy"}
service.sendEvent("lua_Keyboard")
end

function 功能_脚本(路径,参数)
Key.presetKeys.lua_Keyboard={label= "脚本", send="function", command=路径, option=参数}
service.sendEvent("lua_Keyboard")
end

