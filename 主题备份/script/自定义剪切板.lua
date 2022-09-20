
local 版本号="4.0"

local 帮助内容=[[
</big><font color=red><b>帮助说明</b></font></big>

中文输入法脚本
自定义剪切板 4.0
原作者： 星乂尘 1416165041@qq.com
2020.09.04

--无障碍版专用脚本
--脚本名称: 自定义剪切板
--说明：中文输入法无障碍版原生剪切板优化版,基于 星乂尘_自定义剪切板3.1 修改
--增加搜索,优先首选,选中内容
--版本号: 3.5
▂▂▂▂▂▂▂▂
日期: 2020年12月08日🗓️
农历: 鼠🐁庚子年十月廿四
时间: 18:26:19🕕
星期: 周二
--制作者: 风之漫舞
--首发qq群: Rime 同文斋(458845988)
--邮箱: bj19490007@163.com(不一定及时看到)

--本次更新: 2021.10.09
--By＠合欢∣hehuan.ys168.com
--增加生成二维码，增加语音播报，增加一键加词自动编码，增加推送到云端，增加从云端获取(点击剪切板标题获取)，增加分词
--优化搜索
--版本号: 4.0

--脚本配置说明
<b>用法一</b>
①放到脚本启动器->脚本库目录 下任意位置及子文件夹中,脚本启动器自动显示该脚本
②主题方案挂载脚本启动器
③显示一个键盘界面,
单击上屏文字

--------------------
<b>用法二</b>
第①步 将 脚本文件解压放置 Android/rime/script 文件夹内,
默认脚本路径为Android/rime/script/自定义剪切板/自定义剪切板.lua

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys,加入以下内容

preset_keys:
  lua_script_cvv: {label: 短语板, functional: false, send: function, command: "自定义剪切板/自定义剪切板.lua", option: "default"}
向该主题方案任意键盘按键中加入上述按键既可

]]




require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.RectF"
import "android.media.MediaPlayer"
import "android.graphics.drawable.StateListDrawable"
import "java.io.File"
import "android.text.Html"
import "android.os.*"
import "com.osfans.trime.*" --载入包
import "android.graphics.Typeface"
import "script.包.键盘操作.功能键"
import "android.content.Context" 
import "android.speech.tts.*"


local 参数=(...)

local 输入法目录=tostring(service.getLuaExtDir("")).."/"
local 脚本目录=tostring(service.getLuaExtDir("script")).."/"
local 脚本路径=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径
local 纯脚本名=File(脚本路径).getName()
local 目录=string.sub(脚本路径,1,#脚本路径-#纯脚本名)
local 脚本相对路径=string.sub(脚本路径,#脚本目录+1)
local 脚本相对目录=string.sub(脚本相对路径,1,-#纯脚本名-1)

local 键盘名=""
local 选中内容 = service.getCurrentInputConnection().getSelectedText(0)--取编辑框选中内容,部分app内无效
local 上次上屏 = Rime.getCommitText() --己上屏文字

local 标题=纯脚本名:sub(1,-5)
	 标题=标题..版本号

if 选中内容 =="" or 选中内容 ==nil then
  选中内容 = 上次上屏
end

if 参数=="" or 参数==选中内容 or 参数==nil  or 参数:find("搜索")~=nil or 参数:find("分词")~=nil or 参数:find("帮助")~=nil then
	键盘名="K_default" 
else
	键盘名="K_"..参数
end

local 文件=tostring(service.getLuaDir("")).."/clipboard.json"

local vibeFont=Typeface.DEFAULT
local 字体文件 = tostring(service.getLuaDir("")).."/fonts/牛码飞机手机5代超集宋体.ttf"
if File(字体文件).exists()==true then
  vibeFont=Typeface.createFromFile(字体文件)
end--if File(字体文件)

--剪切板过滤，find("")里写正则
----[[
local 剪切板数组=service.getClipBoard()
for i=0,#剪切板数组-1 do
	if 剪切板数组[i]:find("龥")~=nil then
		print("自动过滤掉："..剪切板数组[i])
		剪切板数组.remove(i)
	end
end
--]]

local function 导入模块(模块,内容)
   dofile_信息表=nil
   dofile_信息表={}
   dofile_信息表.上级脚本=脚本路径
   dofile_信息表.上级脚本所在目录=目录
   dofile_信息表.上级脚本相对路径=脚本相对路径
   dofile_信息表.纯脚本名=纯脚本名:sub(1,-5)
   dofile_信息表.内容=内容
   dofile(目录..模块)--导入模块
end




  --搜索剪切板
local 预搜索内容=""
  local 选中内容=service.getCurrentInputConnection()
  if 选中内容!=nil then
    预搜索内容=选中内容.getSelectedText(0)
  end
  if Rime.RimeGetInput()~="" then
    预搜索内容=Rime.getComposingText()  --当前候选
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

local stb,state=StateListDrawable(),android.R.attr.state_pressed
  stb.addState({-state},bkb)
  stb.addState({state},bka)
  return stb
end

local function Icon(k,s) --获取k功能图标，没有则返回s
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
	ta.textSize="18dp"
	ta.onClick=function()
	  service.sendEvent("BackSpace")
	end
	ta.OnLongClickListener={onLongClick=function() return true end}
   elseif id==2 then
	ta.text="空格"
	ta.textSize="18dp"
	ta.onClick=function()
	  service.sendEvent("space")
	end
	ta.OnLongClickListener={onLongClick=function() 
		service.commitText("\t")
		return true
	end}
   elseif id==3 then
	ta.text=Icon("Return","⏎")
	ta.textSize="18dp"
	ta.onClick=function()
	  service.sendEvent("Return")
	end
	ta.OnLongClickListener={onLongClick=function() return true end}
   elseif id==4 then
	ta.text=Icon("返回","返回")
	ta.onClick=function()
	service.sendEvent(键盘名)
	ta.text=Icon(键盘名,"返回")
	end
	ta.OnLongClickListener={onLongClick=function()
		service.sendEvent("Keyboard_default")
		return true
	end}
	elseif id==5 then
	ta.text=Icon("清除","清除")
	ta.onClick=function()
	  io.open(文件,"w"):write("[\n]"):close()
	  local 输入法实例=Trime.getService()
	  输入法实例.loadClipboard()
	  print("数据已清除")
	  service.sendEvent("Keyboard_default")
	end
	ta.OnLongClickListener={onLongClick=function() return true end}
	elseif id==6 then
	ta.text="帮助"
	ta.onClick=function()
	  导入模块("帮助模块.text",帮助内容)
	end
	ta.OnLongClickListener={onLongClick=function() return true end}
	elseif id==7 then
	ta.text=Icon("全选","全选")
	ta.textSize="18dp"
	ta.onClick=function()
		功能_全选()
	end
	elseif id==8 then
	ta.text=Icon("复制","复制")
	ta.textSize="18dp"
	ta.onClick=function()
		功能_复制()
	end
	elseif id==9 then
	ta.text=Icon("剪切","剪切")
	ta.textSize="18dp"
	ta.onClick=function()
		功能_剪切()
	end
	elseif id==10 then
	ta.text=Icon("搜索","搜索")
	ta.textSize="18dp"
	ta.onClick=function()
	  if utf8.sub(参数,1,6)=="【【搜索】】" then 
        Key.presetKeys.lua_script_l={label= "脚本", send="function", command=脚本相对路径, option="搜索0"}
      elseif 预搜索内容 then
        Key.presetKeys.lua_script_l={label= "脚本", send="function", command=脚本相对路径, option="【【搜索】】"..预搜索内容}
      else
        Key.presetKeys.lua_script_l={label= "脚本", send="function", command=脚本相对路径, option="搜索0"}
      end
      service.sendEvent("lua_script_l")
	end
	elseif id==11 then
	ta.text=Icon("短语","短语板")
	ta.textSize="18dp"
	ta.onClick=function()
      功能_脚本(脚本相对目录.."自定义短语板.lua","剪切板")
	end
	end
  return ta
end

local 默认高度=service.getLastKeyboardHeight()
if 默认高度<300 then 默认高度=300 end

local ids,layout={},{FrameLayout,
    --键盘高度
    layout_height=默认高度,
    layout_width=-1,
    --背景颜色
    BackgroundColor=0xffd7dddd,
    {TextView,
        id="title",
        layout_height="20dp",
        layout_width=-1,
        text="•帮助说明",
        gravity="center",
        paddingLeft="2dp",
        paddingRight="2dp",
        --BackgroundColor=0x49d3d7da,
        },
    {LinearLayout,
        gravity="right",
        layout_height=-1,
        {ListView, --列表控件
            id="list",
            layout_marginTop="20dp", --和标题高度相等
            --DividerHeight=0,  --无间隔线
            layout_width=-1,
            layout_weight=1},

        {LinearLayout,
            layout_marginTop="20dp", --和标题高度相等
            orientation=1,
            layout_weight=1,
            layout_width="130dp",
            layout_height=-1,
            layout_gravity=5|84,
            Bu_R(7),
            Bu_R(8),
            Bu_R(9),
            Bu_R(2),
            Bu_R(3),
            },

        {LinearLayout,
            layout_marginTop="20dp", --和标题高度相等
            orientation=1,
            layout_weight=1,
            layout_width="130dp",
            layout_height=-1,
            layout_gravity=5|84,
            Bu_R(4),
            Bu_R(11),
            Bu_R(5),
            Bu_R(10),
            Bu_R(1),

            },
        }}

layout=loadlayout(layout,ids)

function rippleDrawable(color)
  import"android.content.res.ColorStateList"
  return activity.Resources.getDrawable(activity.obtainStyledAttributes({android.R.attr.selectableItemBackground--[[Borderless]]}).getResourceId(0,0)).setColor(ColorStateList(int[0].class{int{}},int{color or 0x20000000}))
end
function gradientDrawable(orientation,colors)
  import"android.graphics.drawable.GradientDrawable"
  return GradientDrawable(GradientDrawable.Orientation[orientation],colors)
end
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
	Typeface=vibeFont,
	textColor=0xff232323,
	textSize="15dp"}}

local adp=LuaAdapter(service,data,item)
ids.list.Adapter=adp

local function fresh(t)
	table.clear(data)
	for i=0,#t-1 do
		local v=t[i]
		local a,b,c=v:match("^%s*([^\n]+)(\n*[^\n]*)(\n*[^\n]*)")
		a=table.concat{utf8.sub(a,1,99),utf8.sub(b,1,99),utf8.sub(c,1,99)}
		local 内容=v
		内容=内容:gsub(".",{
			["<"]="&lt;",
			[">"]="&gt;",
		})
		内容=string.gsub(内容,"\n","<br>")
		内容="</big><font color=red><b>"..tostring(i+1)..".</b></font></big>"..内容
		table.insert(data,{b=Html.fromHtml(内容)})
	end
	adp.notifyDataSetChanged()
	标题=标题.."(全部"..#t.."条)"
end

local function fresh2(t)
	table.clear(data)
	for i=1,#t do
		local v=t[i]
		local a,b,c=v:match("^%s*([^\n]+)(\n*[^\n]*)(\n*[^\n]*)")
		a=table.concat{utf8.sub(a,1,99),utf8.sub(b,1,99),utf8.sub(c,1,99)}
		local 内容=v
		内容=内容:gsub(".",{
			["<"]="&lt;",
			[">"]="&gt;",
		})
		内容=string.gsub(内容,"\n","<br>")
		内容="</big><font color=red><b>"..tostring(i)..".</b></font></big>"..内容
		table.insert(data,{b=Html.fromHtml(内容)})
	end
	adp.notifyDataSetChanged()
	标题=标题.."(\""..预搜索内容.."\" 相关共"..#t.."条)"
end

local Clip=service.getClipBoard()
local 搜索内容组={}
if utf8.sub(参数,1,6)=="【【搜索】】" then
	local 内容组={}
	for i=0,#Clip-1 do
		内容组[i+1]=Clip[i]
	end
	local 搜索内容=utf8.sub(参数,7)
	--print("匹配 "..搜索内容.." 中...")
	local n=1
	for i=1,#内容组 do
		local m=utf8.find(内容组[i],搜索内容)
		if m~=nil then
			搜索内容组[n]=内容组[i]
			n=n+1
		end
	end
	fresh2(搜索内容组)
else
	fresh(Clip)
end
	ids.list.onItemClick=function(l,v,p)
		local s=Clip[p]
		if utf8.sub(参数,1,6)=="【【搜索】】" then
			s=搜索内容组[p+1]
			service.commitText(s)
			local n=1
			local 搜索内容组0={}
			for i=1,#搜索内容组 do
				if 搜索内容组[i]~=s then
					搜索内容组0[n+1]=搜索内容组[i]
					n=n+1
				end
			end
			搜索内容组0[1]=s
			搜索内容组=搜索内容组0
			fresh2(搜索内容组)
			Clip.add(0,s)
			for i=1,#Clip do--Clip从0开始，因为Clip[0]是刚刚添加的，因此不做处理
				if Clip[i]==s then
					Clip.remove(i)
				end
			end
		else
			--置顶已上屏内容
			Clip.remove(p)
			Clip.add(0,s)
			fresh(Clip)
			service.commitText(s)
		end--if utf8.sub(参数,1,6)=="【【搜索
	end--ids.list.onItemClick
	
	ids.list.onItemLongClick=function(l,v,p)
		local str=Clip[p]
		if utf8.sub(参数,1,6)=="【【搜索】】" then
			str=搜索内容组[p+1]
		end
		pop=PopupMenu(service,v)
		menu=pop.Menu
		menu.add("📑复制词条").onMenuItemClick=function(ae)
			if utf8.sub(参数,1,6)=="【【搜索】】" then
				local n=1
				local 搜索内容组0={}
				for i=1,#搜索内容组 do
					if 搜索内容组[i]~=str then
						搜索内容组0[n+1]=搜索内容组[i]
						n=n+1
					end
				end
				搜索内容组0[1]=str
				搜索内容组=搜索内容组0
				fresh2(搜索内容组)
				Clip.add(0,str)
				for i=1,#Clip do--Clip从0开始，因为Clip[0]是刚刚添加的，因此不做处理
					if Clip[i]==str then
					Clip.remove(i)
					end
				end
			else
				Clip.remove(p)
				Clip.add(0,str)
				fresh(Clip)
			end
		end
		menu.add("⚠删除词条").onMenuItemClick=function(ae)
			if utf8.sub(参数,1,6)=="【【搜索】】" then
				local n=1
				local 搜索内容组0={}
				for i=1,#搜索内容组 do
					if 搜索内容组[i]~=str then
						搜索内容组0[n]=搜索内容组[i]
						n=n+1
					end
				end
				搜索内容组=搜索内容组0
				fresh2(搜索内容组)

				for i=0,#Clip do
					if Clip[i]==str then
						Clip.remove(i)
					end
				end
			else
				Clip.remove(p)
				fresh(Clip)
			end
		end
		menu.add("✂分割词条").onMenuItemClick=function(ae)
			导入模块("分词工具.text",str)
		end
		menu.add("📤上传云端").onMenuItemClick=function(ae)
			导入模块("推送剪切板到云端.text",str)
		end
		menu.add("📝添加短语").onMenuItemClick=function(ae)
			print(str.."添加成功")
			local Phrase=service.getPhrase()
			Phrase.add(0,str)
			local Phrase_nr="[\n"
			for i=0,#Phrase-1 do
				Phrase0=Phrase[i]:gsub("\\","\\\\")
				Phrase0=Phrase0:gsub("/","\\/")
				Phrase0=Phrase0:gsub("\"","\\\"")
				Phrase0=Phrase0:gsub("\n","\\n")
				Phrase0=Phrase0:gsub("\t","\\t")
				Phrase_nr=Phrase_nr.."    \""..Phrase0.."\",\n"
			end
			Phrase_nr=Phrase_nr:sub(1,-3).."\n]"
			io.open(输入法目录.."phrase.json","w"):write(Phrase_nr):close()
		end
		menu.add("📋一键加词").onMenuItemClick=function(ae)
			导入模块("一键加词自动编码(定长).text",str)
		end
		menu.add("🗣语音播报").onMenuItemClick=function(ae)
			service.speak(str)--文本转声音
		end
		menu.add("📇生成二维码").onMenuItemClick=function(ae)
			导入模块("二维码制作.text",str)
		end
		pop.show()
		return true
	end


ids.title.setText(标题)
ids.title.onClick=function()
	导入模块("从云端获取剪切板.text","")
end

service.setKeyboard(layout)



--视频路径
local path=目录.."剪切板背景.mp4"
--视频文件不存在则终止脚本
if File(path).isFile()==false then
  return
end

pcall(function()
  local play=MediaPlayer()
  play.setDataSource(path)
  --循环播放
  play.setLooping(true)
  play.prepare()
  --音量设为0
  play.setVolume(0,0)

  local video=loadlayout{SurfaceView,
    --添加背景色，避免看不清按键
    --BackgroundColor=0x55ffffff,
    backgroundDrawable=gradientDrawable("TL_BR",{0x99FBE0B5,0x99E5EED9,0x99F3F5F8}),--背景色
    layout_width=-1,
    layout_height=-1}
  layout.addView(video,0) --把视频布局放到layout的第一个，也就是显示在最底层
  video.getHolder().addCallback({
    surfaceCreated=function(holder)
      play.start()
      play.setDisplay(holder)
    end,
    surfaceDestroyed=function()
      --界面关闭，释放播放器
      play.release()
  end})
end)


