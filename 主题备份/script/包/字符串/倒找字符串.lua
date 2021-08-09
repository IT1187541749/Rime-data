
require "import"
import "java.lang.String"

--倒找字符串,返回字符串位置,失败返回0
--string.reverse(str)方法仅适合非中文内容,有中文内容则乱码
function 倒找字符串(str,k)
 local 最后位置=0
 local 位置=0
 while 最后位置!=nildo
  位置=最后位置
  最后位置=string.find(str,k,最后位置+1)
 end
 return 位置
end

function 字符串_倒找(str,k)
 local 最后位置=0
 local 位置=0
 while 最后位置!=nildo
  位置=最后位置
  最后位置=string.find(str,k,最后位置+1)
 end
 return 位置
end
