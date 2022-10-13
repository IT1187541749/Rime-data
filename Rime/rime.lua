-- Usage:
--  engine:
--    ...
--    translators:
--      ...
--      - lua_translator@lua_function3
--      - lua_translator@lua_function4
--      ...
--    filters:
--      ...
--      - lua_filter@lua_function1
--      - lua_filter@lua_function2
--      ...

--- date/time translator
function date_translator(input, seg)
   if (input == "jjad") then
      -- Candidate(type, start, end, text, comment)
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "〔日期〕"))
   end
end

function time_translator(input, seg)
   if (input == "jfuj") then
      yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), "〔时间〕"))
   end
end

--- single_char
function single_char(input, env)
   b = env.engine.context:get_option("single_char")
   for cand in input:iter() do
      if (not b or utf8.len(cand.text) == 1 or cand.type == "qsj"or cand.type == "time"or cand.type == "date") then
         yield(cand)
      end
   end
end

--- time_date
function time_date(input, seg)
   date_translator(input, seg)
   time_translator(input, seg)
   week_translator(input, seg)
end


function week_translator(input, seg)
   if (input == "jjde") then
      if (os.date("%w") == "0") then
         weekstr = "日"
	  end
      if (os.date("%w") == "1") then
         weekstr = "一"
	  end	  
      if (os.date("%w") == "2") then
         weekstr = "二"
	  end	  
      if (os.date("%w") == "3") then
         weekstr = "三"
	  end	  
      if (os.date("%w") == "4") then
         weekstr = "四"
	  end
      if (os.date("%w") == "5") then
         weekstr = "五"
	  end
      if (os.date("%w") == "6") then
         weekstr = "六"
	  end
      yield(Candidate("qsj", seg.start, seg._end, os.date("%Y年%m月%d日").." ".."星期"..weekstr.." "..os.date("%H:%M:%S"), "〔星期〕"))
   end
end   



--#↓以下1条为字符集过滤
core2020 = require("core2020_filter")



--#↓以下1条为字符集提示
charset_comment_filter = require("charset_comment_filter")



--#↓以下1条为单字词组开关
dz_ci = require("dz_ci_filter")


