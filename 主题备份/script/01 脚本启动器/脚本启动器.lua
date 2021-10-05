--[[中文输入法 （同文无障碍版）

脚本启动器2.0

作者： 风之漫舞

]]
require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.RectF"
import "android.graphics.drawable.StateListDrawable"

dofile(tostring(service.getLuaExtDir("script")).."/包/其它/主键盘.lua")
dofile(tostring(service.getLuaExtDir("script")).."/包/文件操作/递归查找文件.lua")


local 参数=(...)
local 脚本目录=tostring(service.getLuaExtDir("script")).."/"
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 纯脚本名=File(脚本路径).getName()
local 目录=string.sub(脚本路径,1,#脚本路径-#纯脚本名)
local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)
local 最近文件=目录.."最近文件.txt"
local 默认图标=目录.."lua.png"

local 组号=1--最近为1,全部为2
local number={
  {"最近",{}},
  {"全部",{}}
}



if File(最近文件).exists() then
  for c in io.lines(最近文件) do
    if File(脚本目录.."/"..c).exists() then
     number[1][2][#number[1][2]+1]=c
    end
  end
end


local function 更新最近文件(当前文件)
  local 脚本内容,脚本组="",{}
  脚本组[1]=当前文件
  if #number[1][2]==0 then
    io.open(最近文件,"w"):write(当前文件.."\n"):close() 
  end
  for i=1,#number[1][2] do
    if number[1][2][i]!=当前文件 then
      脚本组[#脚本组+1]=number[1][2][i]
    end--if
  end--for
  for i=1,20 do
    if #脚本组>=i then
      脚本内容=脚本内容..脚本组[i].."\n"
    end--if
  end--for
  io.open(最近文件,"w"):write(脚本内容):close() 
end




local fs=File(service.getLuaExtDir("script")).list({
   accept=function(dir, name)
      return  File(dir,name).isFile();
   end
})

local fs=luajava.astable(fs)
local 文件组,文件名组={},{}
for i=1,#fs do
  if string.sub(fs[i],-4)==".lua" then
   文件组[#文件组+1]=fs[i]
  end--if
end--for

local 文件组0=递归查找文件(File(目录.."脚本库/"),".lua$")
table.sort(文件组0)--数组排序


--取脚本相对路径
for i=1,#文件组0 do
 文件组[#文件组+1]=string.sub(文件组0[i],#脚本目录+1)
end

for i=1,#文件组 do
  number[2][2][i]=文件组[i]
end



local data={}
local item={LinearLayout,
  layout_width=-1,
  layout_height="88dp",
  padding="2dp",
  gravity=17,
  {CardView,
    radius="10dp",
    layout_height="88dp",
    CardElevation=0,
    layout_width=-1,
    --gravity=3|17,
    {ImageView;
      id="img";
      layout_width="wrap_content"; 
      layout_height="58dp"; 
      layout_gravity="center"; 
      adjustViewBounds="true"; 
      scaleType="fitXY";
      --layout_width="400dp";
      --layout_height="200dp";
    },
    {TextView,
    id="b",
    textColor=0xff232323,
    textSize="12dp"},
    {TextView,
      id="a",
      padding="8dp",
      --gravity=17,
      --gravity=3|17,
      layout_width=-1,
      BackgroundColor=0x49d3d7da,
      textColor=0xff232323,
      textSize="14dp"}}}
      
      
      
local adp=LuaAdapter(service,data,item)

--刷新列表
local function fresh(t)
  table.clear(data)
  if type(t)~="table" then
    local ts={}
    for a in utf8.gmatch(tostring(t),"%S")
      table.insert(ts,a)
    end
    t=ts
  end
  local i=0
  for _,v in ipairs(t) do
    i=i+1
    local 文件名=File(v).getName():sub(1,-5)
    local 图标=目录.."图标包/"..文件名..".png"
    if File(图标).exists()==false then 图标=脚本目录..v:sub(1,-5)..".png" end 
    if File(图标).exists()==false then 图标=目录.."图标包/lua.png" end 
    if File(图标).exists()==false then 图标=默认图标 end
    table.insert(data,{img=图标,b=tostring(i),a=文件名})
  end
  adp.notifyDataSetChanged()
end



local function Back() --生成功能键背景
  local bka=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0xffffffff)
    c.drawRoundRect(b,20,20,p) --圆角20
  end)
  local bkb=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0xffc4c9ca)
    c.drawRoundRect(b,20,20,p)
  end)

  local stb=StateListDrawable()
  stb.addState({-android.R.attr.state_pressed},bkb)
  stb.addState({android.R.attr.state_pressed},bka)
  return stb
end

local function Icon(k,s) --获取k功能图标，没有返回s
  k=Key.presetKeys[k]
  return k and k.label or s
end

local function Bu_R(id) --生成功能键
  local Bu={LinearLayout,
    layout_height=-1,
    layout_width=-1,
    layout_weight=1,
    padding="2dp",
    {FrameLayout,
      layout_height=-1,
      layout_width=-1,
      Background=Back(),
      {TextView,
        gravity=17|48,
        layout_height=-1,
        layout_width=-1,
        layout_marginTop="2dp",
        textColor=0xff232323,
        textSize="10dp"},
      {TextView,
        gravity=17,
        layout_height=-1,
        layout_width=-1,
        textColor=0xff232323,
        textSize="18dp"}}}
  local msg=Bu[2][2] --上标签
  local label=Bu[2][3] --主标签
  
  
  if id<=#number then
    label.text=Icon(number[id][1],number[id][1])
    label.textSize="18dp" --默认符号⌫太小，字体大小改为22dp，后面同理
    Bu.onClick=function()
      组号=id
      if id==1 then
        if File(最近文件).exists() then
          local i=0
          number[1][2]={}
          for c in io.lines(最近文件) do
            i=i+1
            number[1][2][i]=c
           end
         end
       end
      fresh(number[id][2])
    end
    Bu.OnLongClickListener={onLongClick=function() return true end}
   elseif id==(#number+1) then
    label.text=Icon("Keyboard_default","返回")
    Bu.onClick=function()
      service.sendEvent("Keyboard_default")
    end
   elseif id==(#number+2) then
    label.text=Icon("编辑","编辑")
    Bu.onClick=function()
      service.editFile(脚本路径)--用内置编辑器打开文件
    end
    Bu.OnLongClickListener={onLongClick=function() return true end}
  end
  return Bu
end

local height="240dp" --键盘高度
pcall(function()
  --键盘自适应高度，旧版中文不支持，放pcall里防报错
  height=service.getLastKeyboardHeight()
end)

local ids,layout={},{LinearLayout,
  orientation=1,
  --键盘高度
  layout_height=height,
  layout_width=-1,
  --背景颜色
  BackgroundColor=0xffd7dddd,
  {TextView,
    layout_height="1dp",
    layout_width=-1,
    BackgroundColor=0xffdfdfdf},
  {LinearLayout,
    layout_height=-1,
    layout_width=-1,
    {LinearLayout,
      orientation=1,
      layout_width="60dp",
      layout_height=-1,
      layout_gravity=5|84,

      --Bu_R(1),

      },

    {LinearLayout,
      id="main",
      orientation=1,
      --右侧功能键宽度
      layout_width=-1,
      layout_height=-1,
      --layout_gravity=5|84,
      {GridView, --列表控件
        id="list",
        numColumns=2, --6列
        paddingLeft="2dp",
        paddingRight="2dp",
        layout_width=-1,
        layout_weight=1}},
}}

for i=1,#number+2 do
  table.insert(layout[3][2],Bu_R(i))
end

layout=loadlayout(layout,ids)



ids.list.Adapter=adp

ids.list.onItemClick=function(l,v,p)
  local s=number[组号][2][p+1]
  更新最近文件(s)
  Key.presetKeys.lua_script_l={label= "脚本", send="function", command=s, option="%1$s"}
  service.sendEvent("lua_script_l")
end

ids.list.onItemLongClick=function(l,v,p)
  --返回（真），否则长按也会触发点击事件
  return true
end



--初始显示第一项内容
if #number[1][2]>0 then
  组号=1
  fresh(number[1][2])
else
  组号=2
  fresh(number[2][2])
end

local Bus={LinearLayout,
  paddingLeft="2dp",
  layout_width=-1}


ids.main.addView(loadlayout(Bus))

if 键盘否 then
  键盘否=false
  return layout
end

service.setKeyboard(layout)






