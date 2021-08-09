

require "import"
import "java.util.*"

function java随机整数(最大数)
 local 随机数种子 =Random()
 local 随机整数=随机数种子.nextInt(最大数)+1
 return 随机整数
end--function java随机整数
