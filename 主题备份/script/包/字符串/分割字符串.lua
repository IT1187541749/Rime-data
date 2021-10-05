--import "script.包.字符串.分割字符串"
--功能
--字符串分割(字符串 内容,字符串 分割符)
--string.split,同上

function 字符串_分割(内容, 分割符)
  内容 = tostring(内容)
  分割符 = tostring(分割符)
  if (分割符=='') then return false end
  local pos,arr = 0, {}
  for st,sp in function() return string.find(内容, 分割符, pos, true) end do
      table.insert(arr, string.sub(内容, pos, st - 1))
      pos = sp + 1
  end
  table.insert(arr, string.sub(内容, pos))
  return arr
end

function 字符串分割(内容, 分割符)
  内容 = tostring(内容)
  分割符 = tostring(分割符)
  if (分割符=='') then return false end
  local pos,arr = 0, {}
  for st,sp in function() return string.find(内容, 分割符, pos, true) end do
      table.insert(arr, string.sub(内容, pos, st - 1))
      pos = sp + 1
  end
  table.insert(arr, string.sub(内容, pos))
  return arr
end

function 分割字符串(内容, 分割符)
  内容 = tostring(内容)
  分割符 = tostring(分割符)
  if (分割符=='') then return false end
  local pos,arr = 0, {}
  for st,sp in function() return string.find(内容, 分割符, pos, true) end do
      table.insert(arr, string.sub(内容, pos, st - 1))
      pos = sp + 1
  end
  table.insert(arr, string.sub(内容, pos))
  return arr
end

--------------------

function string.split(内容, 分割符)

  内容 = tostring(内容)

  分割符 = tostring(分割符)

  if (分割符=='') then return false end

  local pos,arr = 0, {}

  -- for each divider found

  for st,sp in function() return string.find(内容, 分割符, pos, true) end do

      table.insert(arr, string.sub(内容, pos, st - 1))

      pos = sp + 1

  end

  table.insert(arr, string.sub(内容, pos))

  return arr

end