require "import"
import "java.io.*"
import "android.content.*"

import "com.osfans.trime.*" --载入包


local 主题实例=Config.get()
local 主题=主题实例.getTheme()


主题实例.setTheme(tostring(主题)) 
 
local 按键界面=Trime.getService()
 
按键界面.initKeyboard()
print("当前主题已刷新")



