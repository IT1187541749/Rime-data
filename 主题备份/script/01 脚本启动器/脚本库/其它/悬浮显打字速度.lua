

--import "com.osfans.trime.*" --载入包

local 打字速度=service.getSpeed()--打字速度
local b="当前打字速度 "..打字速度.."字/min"

if 打字速度<=0 then b="暂无统计信息" end

--间隔时间
task(300,function() service.addCompositions({b}) end)
