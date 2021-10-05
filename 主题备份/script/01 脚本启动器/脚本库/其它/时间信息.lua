

import "android.icu.text.DateFormat"
import "android.icu.text.SimpleDateFormat"
import "android.icu.util.Calendar"
import "android.icu.util.ULocale"
import "java.lang.StringBuffer"
import "java.text.FieldPosition"

function 今日农历()
  local locale="zh_CN@calendar=chinese"
  local option=""
  local ul = ULocale(locale);
  local cc = Calendar.getInstance(ul);
  local df;
  if (#(option)==0)
    df = DateFormat.getDateInstance(DateFormat.LONG, ul);
   else
    df = SimpleDateFormat(option, ul);
  end
  s = df.format(cc, StringBuffer(256), FieldPosition(0)).toString();
  return s
end


function 干支生肖查询(年份,返回类型)
	if 返回类型==nil then 返回类型=0 end
	local a, b, c=0
	local x,y,z,内容=""
	--天干名称
    local 天干 = {"甲","乙","丙","丁","戊","己","庚","辛","壬","癸"}
    --地支名称
    local 地支 = {"子","丑","寅","卯","辰","巳","午", "未","申","酉","戌","亥"}
    --属相名称
    local 属相 = {"鼠🐁","牛🐂","虎🐅","兔🐇","龙🐉","蛇🐍", "马🐎","羊🐐","猴🐒","鸡🐓","狗🐕","猪🐖"}
    
	a = 年份 % 10 + 7
    if(a > 10) then a = a - 10 end
    b = 年份 % 12 + 9
    c = b
    if(b > 12) then
     b = b - 12
     c = b
    end
 if 返回类型==0 then 内容=天干[a]..地支[b].."("..属相[c]..")" end
 if 返回类型==1 then 内容=天干[a] end
 if 返回类型==2 then 内容=地支[b] end
 if 返回类型==3 then 内容=属相[c] end
 
 return 内容
end





function 格式化时间()
 local 日期=tostring(os.date("%Y年%m月%d日"))
 local 时间03=os.date("%H:%M:%S")
 local 时间01=tonumber(os.date("%H"))
 if 时间01==0 then 时间01=12 end --排除0点的状况
 if 时间01>12 then 时间01=时间01-12 end
 local 时间02=tonumber(os.date("%M"))
 local 时间=""
 local 时间标识01={"🕐","🕑","🕒","🕓","🕔","🕕","🕖","🕗","🕘","🕙","🕚","🕛"}
 local 时间标识02={"🕜","🕝","🕞","🕟","🕠","🕡","🕢","🕣","🕤","🕥","🕦","🕧"}
 时间=时间03..时间标识01[时间01]
 if 时间02>30 then 时间=时间03..时间标识02[时间01] end
 
 local 星期01=os.date("%w")
 local 星期=""
 if 星期01=="0" then 星期="周日" end
 if 星期01=="1" then 星期="周一" end
 if 星期01=="2" then 星期="周二" end
 if 星期01=="3" then 星期="周三" end
 if 星期01=="4" then 星期="周四" end
 if 星期01=="5" then 星期="周五" end
 if 星期01=="6" then 星期="周六" end
 local 内容="▂▂▂▂▂▂▂▂\n"
 内容=内容.."日期: "..日期.."🗓️"
 --if 今日黄历!="" then 内容=内容..今日黄历 end
 内容=内容.."\n农历: "..干支生肖查询(tonumber(os.date("%Y")),3)..今日农历():sub(5)
 内容=内容.."\n时间: "..时间
 内容=内容.."\n星期: "..星期
 task(200,function()
  service.addCompositions({内容})
 end)

end

格式化时间()
