require "import"
import "java.io.*"
import "android.content.*"

import "com.osfans.trime.*" --载入包


local 主题组=Config.get()
local 主题=主题组.getTheme()

local 数据文件=tostring(主题)..".yaml"

service.editFile(数据文件) 

