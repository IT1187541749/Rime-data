local charsets = {
  { first = 0x4E00, last = 0x9FFF }, -- basic
  { first = 0x3400, last = 0x4DBF }, -- extA
  { first = 0x20000, last = 0x2A6DF }, -- extB
  { first = 0x2A700, last = 0x2B73F }, -- extC
  { first = 0x2B740, last = 0x2B81F }, -- extD
  { first = 0x2B820, last = 0x2CEAF }, -- extE
  { first = 0x2CEB0, last = 0x2EBEF }, -- extF
  { first = 0x30000, last = 0x3134F }, -- extG
  { first = 0x2F00, last = 0x2FDF },
  { first = 0x2E80, last = 0x2EF3 },
  { first = 0xF900, last = 0xFAFF },
  { first = 0x2F800, last = 0x2FA1F },
  { first = 0x31C0, last = 0x31E3 },
  { first = 0x3005, last = 0x30FF },
}

local function is_cjk(code)
  for i, charset in ipairs(charsets) do
    if ((code >= charset.first) and (code <= charset.last)) then
      return true
    end
  end
  return false
end

local function should_yield(text, tag, coredb)
  local should_yield = true
  for i in utf8.codes(text) do
    local code = utf8.codepoint(text, i)
    if is_cjk(code) then
      charset = coredb:lookup(utf8.char(code))
      if string.find(charset, tag) == nil then
        should_yield = false
        break
      end
    end
  end
  return should_yield
end

local function filter(input, env)
  extended_char1 = env.engine.context:get_option("extended_char1")
  extended_char2 = env.engine.context:get_option("extended_char2")
  for cand in input:iter() do
    if extended_char1 then
      if should_yield(cand.text, '[8]', env.coredb) then  --通用规范汉字表 8105字
        yield(cand)
      end
    elseif extended_char2 then
      if should_yield(cand.text, '[2]', env.coredb) then  --GB18030-2000 27533字
        yield(cand)
      end
    else
      yield(cand)
    end
  end
end

local function init(env)
  -- 当此组件被载入时，打开反查库，并存入 `coredb` 中
  env.coredb = ReverseDb("build/core2020.reverse.bin")
end

return { init = init, func = filter }
