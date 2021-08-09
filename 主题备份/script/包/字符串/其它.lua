
require "import"

--返回当前字符实际占用的字符数
function SubStringGetByteCount(str, index)
    local curByte = string.byte(str, index)
    local byteCount = 1;
    if curByte == nil then
        byteCount = 0
    elseif curByte > 0 and curByte <= 127 then
        byteCount = 1
    elseif curByte >= 192 and curByte <= 223 then
        byteCount = 2
    elseif curByte >= 224 and curByte <= 239 then
        byteCount = 3
    elseif curByte >= 240 and curByte <= 247 then
        byteCount = 4
    end
    return byteCount;
end 




--获取中英混合UTF8字符串的真实字符数量
function SubStringGetTotalIndex(str)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat
        lastCount = SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(lastCount == 0);
    return curIndex - 1;
end

--获取字符串的真实索引值
local function SubStringGetTrueIndex(str, index)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat
        lastCount = SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(curIndex >= index);
    return i - lastCount;
end



--截取中英混合的UTF8字符串，endIndex可缺省
function SubStringUTF8(str, startIndex, endIndex)
    if startIndex < 0 then
        startIndex = SubStringGetTotalIndex(str) + startIndex + 1;
    end

    if endIndex ~= nil and endIndex < 0 then
        endIndex = SubStringGetTotalIndex(str) + endIndex + 1;
    end

    if endIndex == nil then
        return string.sub(str, SubStringGetTrueIndex(str, startIndex));
    else
        return string.sub(str, SubStringGetTrueIndex(str, startIndex), SubStringGetTrueIndex(str, endIndex + 1) - 1);
    end
end

--字符串操作

--获取中英混合UTF8字符串的真实字符数量
function 中英字符串长度(str)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat
        lastCount = SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(lastCount == 0);
    return curIndex - 1;
end


function 中英字符串转数组(内容) 
   local 单字组={}
   local 中英字符串长=中英字符串长度(内容)
   for i=1, 中英字符串长 do
    单字组[i]=SubStringUTF8(内容,i,i)
   end
  return 单字组
end--中英字符串转数组


-- 忽略字符串首尾的空白字符
function 字符串首尾空(input)
	return (string.gsub(input, "^%s*(.-)%s*$", "%1"))
end

function 中文字符长度(str)
  local _,n=str:gsub('[\128-\255]','')
  return #str-n/2
  end

--检查是否全部为中文，存在其它字符则返回false
function 汉字否(s) 
if #s < SubStringGetTotalIndex(s)*3-2 then
 return false 
end
return true;
end

function 字符串_汉字否(s) 
if #s < SubStringGetTotalIndex(s)*3-2 then
 return false 
end
return true;
end


