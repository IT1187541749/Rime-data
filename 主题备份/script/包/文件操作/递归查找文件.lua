





--参数catalog,文件夹目录
--参数name,如".lua",搜索lua后缀文件
function 递归查找文件(catalog,name)
  local t=os.clock()
  local 文件组={}
  require "import"
  import "java.io.File" 
  import "java.lang.String"
  function FindFile(catalog,name)
    local name=tostring(name)
    local ls=catalog.listFiles() or File{}
    for 次数=0,#ls-1 do
      --local 目录=tostring(ls[次数])
      local f=ls[次数]
      if f.isDirectory() then--如果是文件夹则继续匹配
        FindFile(f,name)
      else--如果是文件则
        local nm=f.Name
        if string.find(nm,name) then
          文件组[#文件组+1]=tostring(f)
        end
      end
      luajava.clear(f)
    end
  end
  FindFile(catalog,name)
  --call("outPath",ret)
  return 文件组
end --递归查找文件