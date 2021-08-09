
function 到农历(年,月,日) 
    --天干名称
    local cTianGan = {"甲","乙","丙","丁","戊","己","庚","辛","壬","癸"}
    --地支名称
    local cDiZhi = {"子","丑","寅","卯","辰","巳","午", "未","申","酉","戌","亥"}
    --属相名称
    local cShuXiang = {"鼠","牛","虎","兔","龙","蛇", "马","羊","猴","鸡","狗","猪"}
    --农历日期名
    local cDayName =
    {
        "*","初一","初二","初三","初四","初五",
        "初六","初七","初八","初九","初十",
        "十一","十二","十三","十四","十五",
        "十六","十七","十八","十九","二十",
        "廿一","廿二","廿三","廿四","廿五",
        "廿六","廿七","廿八","廿九","三十"
    }
    --农历月份名
    local cMonName = {"*","正","二","三","四","五","六", "七","八","九","十","十一","腊"}

    --公历每月前面的天数
    local wMonthAdd = {0,31,59,90,120,151,181,212,243,273,304,334}
    -- 农历数据
    local wNongliData = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
    ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
    ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
    ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
    ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
    ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
    ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
    ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
    ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
    ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877}

    local wCurYear,wCurMonth,wCurDay;
    local nTheDate,nIsEnd,m,k,n,i,nBit;
    local szNongli, szNongliDay,szShuXiang;
    ---取当前公历年、月、日---
    wCurYear = tonumber(年);
    wCurMonth = tonumber(月);
    wCurDay = tonumber(日);
    ---计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)---
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth] - 38
    if (((wCurYear % 4) == 0) and (wCurMonth > 2)) then
        nTheDate = nTheDate + 1
    end
    
    --计算农历天干、地支、月、日---
    nIsEnd = 0;
    m = 0;
    while nIsEnd ~= 1 do
        if wNongliData[m+1] < 4095 then
            k = 11;
        else
            k = 12;
        end
        n = k;
        while n>=0 do
            --获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m+1];
            for i=1,n do
                nBit = math.floor(nBit/2);
            end
            nBit = nBit % 2;
            if nTheDate <= (29 + nBit) then
                nIsEnd = 1;
                break
            end
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        end
        if nIsEnd ~= 0 then
            break;
        end
        m = m + 1;
    end

    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if k == 12 then
        if wCurMonth == wNongliData[m+1] / 65536 + 1 then
            wCurMonth = 1 - wCurMonth;
        elseif wCurMonth > wNongliData[m+1] / 65536 + 1 then
            wCurMonth = wCurMonth - 1;
        end
    end
    wCurDay = math.floor(wCurDay)
    --print('农历', wCurYear, wCurMonth, wCurDay)
    --生成农历天干、地支、属相 ==> wNongli--
    szShuXiang = cShuXiang[(((wCurYear - 4) % 60) % 12) + 1]
    szShuXiang = cShuXiang[(((wCurYear - 4) % 60) % 12) + 1];
    szNongli = szShuXiang .. '(' .. cTianGan[(((wCurYear - 4) % 60) % 10)+1] .. cDiZhi[(((wCurYear - 4) % 60) % 12) + 1] .. ')年'
    --szNongli,"%s(%s%s)年",szShuXiang,cTianGan[((wCurYear - 4) % 60) % 10],cDiZhi[((wCurYear - 4) % 60) % 12]);

    --生成农历月、日 ==> wNongliDay--*/
    if wCurMonth < 1 then
        szNongliDay =  "闰" .. cMonName[(-1 * wCurMonth) + 1]
    else
        szNongliDay = cMonName[wCurMonth+1]
    end

    szNongliDay =  szNongliDay .. "月" .. cDayName[wCurDay+1]
    return szNongli .. szNongliDay
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
 内容=内容.."\n农历: "..到农历(os.date("%Y"),os.date("%m"),os.date("%d"))
 内容=内容.."\n时间: "..时间
 内容=内容.."\n星期: "..星期
 return 内容
end

task(300,function()
 service.addCompositions({格式化时间()})
end)

