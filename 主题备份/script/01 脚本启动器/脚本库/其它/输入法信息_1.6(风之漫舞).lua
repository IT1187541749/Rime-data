--[[
--无障碍版专用脚本
--脚本名称: 输入法信息
--用途：上屏输入法相关信息，
--版本号: 1.5
▂▂▂▂▂▂▂▂
日期: 2020年09月05日🗓️
农历: 鼠🐁庚子年七月十八
时间: 19:54:41🕢
星期: 周六
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)


]]

require "import"
import "java.io.*"
import "yaml"

local function 应用信息(包名)
  import "android.content.pm.PackageManager"
  local pm = service.getPackageManager();
  local 图标 = pm.getApplicationInfo(tostring(包名),0)
  local 图标 = 图标.loadIcon(pm);
  local pkg = service.getPackageManager().getPackageInfo(包名, 0); 
  local 应用名称 = pkg.applicationInfo.loadLabel(service.getPackageManager())
  local 版本号 = service.getPackageManager().getPackageInfo(包名, 0).versionName
  local 最后更新时间 = service.getPackageManager().getPackageInfo(包名, 0).lastUpdateTime
  local cal = Calendar.getInstance();
  cal.setTimeInMillis(最后更新时间); 
  local 最后更新时间 = cal.getTime().toLocaleString()
  return 包名,版本号,最后更新时间,图标,应用名称
end


import "com.osfans.trime.*"
local a=Rime.getSchemaId() --方案id
local b=Rime.getSchemaName() --方案名称
local c=Rime.get_version() --RIME版本号
local d=Rime.get_librime_version() --RIME版本完整信息
local e=Rime.get_opencc_version() --OpenCC版本
local f=Rime.get_trime_version() --Trime版本
local g=Rime.get_shared_data_dir() --共享文件夹路径
local h=Rime.get_user_data_dir() --用户文件夹路径
local i=Rime.get_sync_dir() --同步文件夹路径
local j=Rime.get_user_id() --同步文件夹id路径

local device_model = Build.MODEL --设备型号 
local version_sdk = Build.VERSION.SDK --设备SDK版本 
local version_release = Build.VERSION.RELEASE --设备的系统版本

local app=service.getPackageName()  --本应用包名

local 包名,版本号,最后更新时间,图标,应用名称=应用信息(service.getPackageName())


参数=(...)
--print(参数)

local 输入法目录=tostring(service.getLuaExtDir("")).."/"
local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径

local 脚本相对路径=string.sub(脚本名,#脚本目录+1)
local 纯脚本名=File(脚本名).getName()
local 当前脚本目录=string.sub(脚本名,1,#脚本名-#纯脚本名)


local 主题组=Config.get()
local 当前主题0=主题组.getTheme()
local 主题文件=输入法目录..当前主题0..".yaml"
local yaml组 = yaml.load(io.readall(主题文件))

local 当前主题=yaml组["name"]


--print(dump(yaml组))

local 打字速度=service.getSpeed()
local 打字速度1=""
if 打字速度<=0 then 打字速度1="暂无统计信息" end
if 打字速度>0 then 打字速度1=打字速度.."/min" end
if 打字速度>0 and 打字速度<=20 then 打字速度1=打字速度1.."(你的打字速度像步行🏃一样,请再接再厉)" end
if 打字速度>20 and 打字速度<=40 then 打字速度1=打字速度1.."(你的打字速度像自行车🚲一样,请继续努力)" end
if 打字速度>40 and 打字速度<=120 then 打字速度1=打字速度1.."(你的打字速度像洗车🚕一样,不错不错)" end
if 打字速度>500 and 打字速度<=1000 then 打字速度1=打字速度1.."(你的打字速度像飞机✈一样,点赞👍👍👍)" end
if 打字速度>1000 then 打字速度1=打字速度1.."(你的打字速度像火箭🚀一样,👏👏👏)" end


--步行0-20，自行车20-40，汽车40-120，高铁120-500，飞机500-1000，火箭1000+
--🐌🐢🐜🏃‍♂🚲🏍🚗🚆🛩

local 上屏文字="▂▂▂▂▂▂▂▂\n以上内容来自: \n📟"..应用名称.."\n🖍版本号: "..版本号.."\n🖊方案id: "..a.."\n🖋方案名称: "..tostring(b).."\n🎦当前主题: "..当前主题.."\n📠当前打字速度: "..打字速度1.."\n✒RIME版本号: "..d.."\n⌨OpenCC版本: "..e.."\n📄Trime版本: "..f.."\n📱设备型号: "..device_model.."\n🚪设备SDK版本: "..version_sdk.."\n🎴设备系统版本: "..version_release



task(300,function()
 service.addCompositions({上屏文字})
end)



