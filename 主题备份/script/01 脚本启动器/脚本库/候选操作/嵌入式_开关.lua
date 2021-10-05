
require "import"
import "com.osfans.trime.*" --载入包

local 嵌入式编辑模式=tostring(Config.get().getInlinePreedit())--读取嵌入式编辑模式
--service.commitText(tostring(嵌入式编辑模式))
if 嵌入式编辑模式=="INLINE_NONE" then
  service.setSharedData("inline_preedit","preedit")
  print("嵌入式编辑模式_开")
else
  service.setSharedData("inline_preedit","none")
  print("嵌入式编辑模式_关")
end

service.invalidate()
