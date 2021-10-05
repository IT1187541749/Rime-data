--[[中文输入法 脚本
【自定义剪切板 3.1】

作者： 星乂尘 1416165041@qq.com
放置目录： /rime/script

2020.09.04
]]
require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.RectF"
import "android.graphics.drawable.StateListDrawable"
import "java.io.File"

import "android.os.*"
import "com.osfans.trime.*" --载入包

参数=(...)
--print(参数)

local 键盘名=""
if 参数=="1" or 参数=="" or 参数==nil then
  键盘名="Keyboard_default" 
else
  键盘名="Keyboard_"..参数
end

local 文件=tostring(service.getLuaDir("")).."/clipboard.json"

--检查文件存在否
if File(文件).exists()==false then
 print(文件.." 不存在,请先复制内容" )
 return
end


local function Back() --生成功能键背景
  local bka=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0x49ffffff)
    c.drawRoundRect(b,20,20,p) --圆角20
  end)
  local bkb=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0x49d3d7da)
    c.drawRoundRect(b,20,20,p)
  end)

  local stb=StateListDrawable()
  stb.addState({-android.R.attr.state_pressed},bkb)
  stb.addState({android.R.attr.state_pressed},bka)
  return stb
end

local function Icon(k,s) --获取功能键图标
  k=Key.presetKeys[k]
  return k and k.label or s
end

local function Bu_R(id) --生成功能键
  local ta={TextView,
    gravity=17,
    Background=Back(),
    layout_height=-1,
    layout_width=-1,
    layout_weight=1,
    layout_margin="1dp",
    layout_marginTop="2dp",
    layout_marginBottom="2dp",
    textColor=0xff232323,
    textSize="18dp"}

  if id==1 then
    ta.text=Icon("BackSpace","⌫")
    ta.textSize="22dp"
    ta.onClick=function()
      service.sendEvent("BackSpace")
    end
    ta.OnLongClickListener={onLongClick=function() return true end}
   elseif id==2 then
    ta.text=Icon("space","␣")
    ta.textSize="25dp"
    ta.onClick=function()
      service.sendEvent("space")
    end
    ta.OnLongClickListener={onLongClick=function() return true end}
   elseif id==3 then
    ta.text=Icon("Return","⏎")
    ta.onClick=function()
      service.sendEvent("Return")
    end
    ta.OnLongClickListener={onLongClick=function() return true end}
   elseif id==4 then
    ta.text=Icon(键盘名,"返回")
    ta.onClick=function()
      dofile(tostring(service.getLuaExtDir("script")).."/包/其它/主键盘.lua")
      local 按键=主键盘()
      Key.presetKeys.lua_Keyboard=按键["click"]
      service.sendEvent("lua_Keyboard")
    end
    ta.OnLongClickListener={onLongClick=function()
        service.sendEvent("undo")
        return true
    end}
    elseif id==5 then
    ta.text=Icon("清除全部","清除全部")
    ta.onClick=function()
      io.open(文件,"w"):write("[\n]"):close()
      task(300,function()  end)
      local 输入法实例=Trime.getService()
      输入法实例.loadClipboard()
      print("数据已清除")
      service.sendEvent("Keyboard_default")
    end
    ta.OnLongClickListener={onLongClick=function() return true end}
  end
  return ta
end

local ids,layout={},{FrameLayout,
  --键盘高度
  layout_height=service.getLastKeyboardHeight(),
  layout_width=-1,
  --背景颜色，默认透明
  BackgroundColor=0x88ffffff,
  {ListView,
    id="list",
    layout_width=-1},
  {LinearLayout,
    orientation=1,
    --右侧功能键宽度
    layout_width="70dp",
    layout_height=-1,
    layout_gravity=5|84,
    Bu_R(1),
    Bu_R(5),
    Bu_R(2),
    Bu_R(3),
    Bu_R(4)
    }}
layout=loadlayout(layout,ids)

local data,item={},{LinearLayout,
  layout_width=-1,
  padding="4dp",
  gravity=3|17,
  {TextView,
    id="a",
    textColor=0xff232323,
    textSize="10dp"},
  {TextView,
    id="b",
    gravity=3|17,
    paddingLeft="4dp",
    --最大显示行数
    MaxLines=3,
    --最小高度
    MinHeight="30dp",
    textColor=0xff232323,
    textSize="15dp"}}
local adp=LuaAdapter(service,data,item)
ids.list.Adapter=adp

local Clip=service.getClipBoard()
local function fresh()
  table.clear(data)
  for i=0,#Clip-1 do
    local v=Clip[i]
    local a,b,c=v:match("^%s*([^\n]+)(\n*[^\n]*)(\n*[^\n]*)")
    a=table.concat{utf8.sub(a,1,99),utf8.sub(b,1,99),utf8.sub(c,1,99)}
    table.insert(data,{a=tostring(i+1),b=a})
  end
  adp.notifyDataSetChanged()
end
fresh()

ids.list.onItemClick=function(l,v,p)
  local s=Clip[p]
  service.commitText(s)
  --置顶已上屏内容
  --[[
  if p>0 then
    Clip.remove(p)
    Clip.add(0,s)
    fresh()
  end
  --]]
end

ids.list.onItemLongClick=function(l,v,p)
  local str=Clip[p]
  local lay={TextView,
    padding="16dp",
    MaxLines=20,
    textIsSelectable=true,
    text=utf8.sub(str,1,3000)..(utf8.len(str)>3000 and "\n..." or ""),
    textColor=0xff232323,
    textSize="15dp"}
  LuaDialog(service)
  .setTitle(string.format("%s  预览/操作",p+1))
  .setView(loadlayout(lay))
  .setButton("置顶",function()
    if p>0 then
      Clip.remove(p)
      Clip.add(0,str)
      fresh()
    end
  end)
  .setButton2("删除",function()
    Clip.remove(p)
    fresh()
  end)
  .setButton3("清空",function()
    Clip.clear()
    service.sendEvent("Keyboard_default")
    local pa=service.LuaDir.."/clipboard.json"
    io.open(pa,"w"):write("[]"):close()
  end)
  .show()

  --返回（真），否则长按也会触发点击事件
  return true
end

service.setKeyboard(layout)

