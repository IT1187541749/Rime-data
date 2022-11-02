require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.RectF"
import "android.graphics.drawable.StateListDrawable"

--[[
调用方式：
trime.yaml

_Keyboard_jisuan: {label: 计算, send: function, command: '计算.lua'}
--]]

local function Back() --生成功能键背景
  local bka=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0xffec5f67)
    c.drawRoundRect(b,10,10,p) --圆角20
  end)
  local bkb=LuaDrawable(function(c,p,d)
    local b=d.bounds
    b=RectF(b.left,b.top,b.right,b.bottom)
    p.setColor(0xffc4c9ca)
    c.drawRoundRect(b,10,10,p)
  end)

  local stb=StateListDrawable()
  stb.addState({-android.R.attr.state_pressed},bkb)
  stb.addState({android.R.attr.state_pressed},bka)
  return stb
end

local height = "240dp"
local fontsize = "17dp"
pcall(function()
  --键盘自适应高度，旧版中文不支持，放pcall里防报错
  height=service.getLastKeyboardHeight()
end)
local idss,layout={},{
  LinearLayout,
  layout_width=-1,
  layout_height=height,
  orientation=1,
  BackgroundColor=0xffd7dddd,
{
  LinearLayout,
  layout_width="fill",
  layout_weight=1,
  orientation="horizontal",
  background="#ffffffff",
  {
    TextView,
    id="jisuan",
    layout_weight=1,
    layout_height="fill",
    gravity="left|center",
    textSize=fontsize,
  },
  {
    Button,
    layout_width="87dp",
    layout_height="wrap",
    layout_margin="2dp",
    Background=Back(),
    textSize=fontsize,
    text="返回",
    onClick=function()
      service.sendEvent("Keyboard_default")
    end,
   },
},
  {
    LinearLayout,
    orientation="horizontal",
  --  background="#FF000000",
    layout_weight=1,
    layout_width="fill",
    {
      Button,
      id="jc",
      layout_height="wrap",
      layout_weight=1,
      text="c",
      layout_margin="2dp",
      textSize=fontsize,
     Background=Back(),
    },
    {
      Button,
      id="jsc",
      layout_height="wrap",
      layout_weight=1,
      text="←",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="jbfb",
      layout_height="wrap",
      layout_weight=1,
      text="()",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="jcu",
      layout_height="wrap",
      layout_weight=1,
      text="÷",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
  },
 {
    LinearLayout,
    orientation="horizontal",
  --  background="#FF000000",
    layout_weight=1,
    layout_width="fill",
    {
      Button,
      id="j7",
      layout_height="wrap",
      layout_weight=1,
      text="7",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
      
    },
    {
      Button,
      id="j8",
      layout_height="wrap",
      layout_weight=1,
      text="8",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="j9",
      layout_height="wrap",
      layout_weight=1,
      text="9",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="jceng",
      layout_height="wrap",
      layout_weight=1,
      text="×",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
  },
 {
    LinearLayout,
    orientation="horizontal",
   -- background="#FF000000",
    layout_weight=1,
    layout_width="fill",
    {
      Button,
      id="j4",
      layout_height="wrap",
      layout_weight=1,
      text="4",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="j5",
      layout_height="wrap",
      layout_weight=1,
      text="5",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="j6",
      layout_height="wrap",
      layout_weight=1,
      text="6",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="jjian",
      layout_height="wrap",
      layout_weight=1,
      text="-",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
  },
 {
    LinearLayout,
    orientation="horizontal",
   -- background="#FF000000",
    layout_weight=1,
    layout_width="fill",
    {
      Button,
      id="j1",
      layout_height="wrap",
      layout_weight=1,
      text="1",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="j2",
      layout_height="wrap",
      layout_weight=1,
      text="2",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="j3",
      layout_height="wrap",
      layout_weight=1,
      text="3",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="jjia",
      layout_height="wrap",
      layout_weight=1,
      text="+",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
  },
 {
    LinearLayout,
    orientation="horizontal",
 --   background="#FF000000",
    layout_weight=1,
    layout_width="fill",
    {
      Button,
      id="j00",
      layout_height="wrap",
      layout_weight=1,
      text="00",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="j0",
      layout_height="wrap",
      layout_weight=1,
      text="0",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="jd",
      layout_height="wrap",
      layout_weight=1,
      text=".",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
    {
      Button,
      id="jdeng",
      layout_height="wrap",
      layout_weight=1,
      text="＝",
      layout_margin="2dp",
      textSize=fontsize,
      Background=Back(),
    },
  },
}

layout=loadlayout(layout,idss)

local ids=[idss.jc,idss.jsc,idss.jbfb,idss.jcu,idss.j7,idss.j8,idss.j9,idss.jceng,idss.j4,idss.j5,idss.j6,idss.jjian,idss.j1,idss.j2,idss.j3,idss.jjia,idss.j00,idss.j0,idss.jd,idss.jdeng]


function init(idd)
  for i,n in pairs(idd) do
  n.onClick=function(v)
  local butstr = v.Text
  if(butstr=="c")
    idss.jisuan.Text=""
  elseif(butstr == "←")
  local str2 = utf8.len(idss.jisuan.Text)
   if(str2!=0)
  local str3 = utf8.sub(idss.jisuan.Text,1,str2-1)
  idss.jisuan.Text=str3
   end
  elseif(butstr == "()")
  
  local jis = idss.jisuan.Text
  if(utf8.find(jis,".+%d$")!=nil)
    idss.jisuan.Text=idss.jisuan.Text..")"
    else
    idss.jisuan.Text=idss.jisuan.Text.."("
    end
  
  elseif(butstr == "＝")
  
    local jisuanstr = idss.jisuan.Text
    gongsi = idss.jisuan.Text
    if(string.find(jisuanstr,"×")!=nil)
      jisuanstr = string.gsub(jisuanstr,"×","*")
      end
    if(string.find(jisuanstr,"÷")!=nil)
      jisuanstr = string.gsub(jisuanstr,"÷","/")
    end
  
function jj()
jieguostr = loadstring("return "..jisuanstr)()
 end

local a,b =pcall(jj)

if(a)
 idss.jisuan.Text=tostring(jieguostr)
 else
 idss.jisuan.Text="错误"
end
 
  else
  idss.jisuan.Text=idss.jisuan.Text..butstr
  end
  end
    end
    
idss.jisuan.onClick=function(v)

local s = v.Text
if(s ~= "" and s ~= nil)
service.commitText(s)
end
end

idss.jisuan.onLongClick=function(v)
local s = v.Text
if(s ~= "" and s ~= nil)
service.commitText(gongsi.."="..s)
end
return true
end


end



init(ids)

service.setKeyboard(layout)

