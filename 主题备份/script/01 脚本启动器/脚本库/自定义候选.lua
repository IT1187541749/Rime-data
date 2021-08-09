
require "import"

import "com.osfans.Rime.*"



local 候选组=Rime.getCandidates()
local 显示内容组={}

for i=1,#候选组 do
 显示内容组[i]=候选组[i-1].text
 if 候选组[i-1].comment!=nil then
  显示内容组[i]=候选组[i-1].text.." "..候选组[i-1].comment
  
 end 
end
local 显示内容组1={}

显示内容组1[1]=显示内容组

--print(候选组[0].comment)

local 候选="测试一下"
service.newActivity("98五笔字根拆分",显示内容组1) --启动工具


