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

function 应用信息(包名)
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


local 主题组=Config.get()
local 当前主题=主题组.getTheme()
当前主题=当前主题:sub(1,-7)




local 打字速度=service.getSpeed()
local 打字速度1=""
if 打字速度<=0 then 打字速度1="暂无统计信息" end
if 打字速度>0 then 打字速度1=打字速度.."/min" end

local 上屏文字="▂▂▂▂▂▂▂▂\n以上内容来自: \n📟"..应用名称.."\n🖍版本号: "..版本号.."\n🖊方案id: "..a.."\n🖋方案名称: "..tostring(b).."\n🎦当前主题: "..当前主题.."\n📠当前打字速度: "..打字速度1.."\n✒RIME版本号: "..d.."\n⌨OpenCC版本: "..e.."\n📄Trime版本: "..f.."\n📱设备型号: "..device_model.."\n🚪设备SDK版本: "..version_sdk.."\n🎴设备系统版本: "..version_release



task(300,function()
 service.addCompositions({上屏文字})
end)



