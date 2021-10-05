

function 返回默认键盘()
 require "import"
 import "com.osfans.trime.*" --载入包
 local 首键盘=Config.get().getKeyboardNames()[0]
 Key.presetKeys.lua_Keyboard={label="退出", send="Eisu_toggle",select= 首键盘}
 service.sendEvent("lua_Keyboard")

end
