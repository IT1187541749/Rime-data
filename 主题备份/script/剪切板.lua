
local 版本号="3.5"

local 帮助内容=[[
</big><font color=red><b>帮助说明</b></font></big>

中文输入法脚本
自定义剪切板 3.5
原作者： 星乂尘 1416165041@qq.com
2020.09.04

--无障碍版专用脚本
--脚本名称: 自定义剪切板
--说明：中文输入法无障碍版原生剪切板优化版,基于 星乂尘_自定义剪切板3.1 修改
--增加搜索,优先首选,次选中内容
--增加长按快速发送选中内容到聊天软件,需在聊天软件中开启回车上屏
--版本号: 3.5
▂▂▂▂▂▂▂▂
日期: 2020年12月08日🗓️
农历: 鼠🐁庚子年十月廿四
时间: 18:26:19🕕
星期: 周二
--制作者: 风之漫舞
--首发qq群: Rime 同文斋(458845988)
--邮箱: bj19490007@163.com(不一定及时看到)

--使用说明
无

--脚本配置说明
<b>用法一</b>
①放到脚本启动器->脚本库目录 下任意位置及子文件夹中,脚本启动器自动显示该脚本
②主题方案挂载脚本启动器
③显示一个键盘界面,
单击上屏文字

--------------------
<b>用法二</b>
第①步 将 脚本文件解压放置 Android/rime/script 文件夹内

第②步 向主题方案中加入按键
以 XXX.trime.yaml主题方案为例
找到以下节点preset_keys,加入以下内容

preset_keys:
  jianqie_qie: {label: 剪切板, send: function, command: '剪切板.lua'}
  jianqie_qie1: {label: 🗒, send: function, command: '剪切板.lua'}
  jianqie_qie2: {label: 剪切板, send: function, command: '01 脚本启动器/脚本库/剪切板.lua'}

  lua_script_cv: {label: 剪切板, functional: false, send: function, command: "01 脚本启动器/脚本库/4 输入工具/剪切板(自定义).lua", option: "default"}
  lua_script_cv1: {label: 剪切板, functional: false, send: function, command: "01 脚本启动器/脚本库/4 输入工具/剪切板(自定义).lua", option: "cjbj"}
  lua_script_cv2: {label: 剪切板, functional: false, send: function, command: "01 脚本启动器/脚本库/4 输入工具/剪切板(自定义).lua", option: "number"}
向该主题方案任意键盘按键中加入上述按键既可(注意文件放置目录)

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
if 选中内容 =="" or 选中内容 ==nil then
  选中内容 = 上次上屏
end

if 参数=="" or 参数==选中内容 or 参数==nil or 参数:find("搜索")~=nil or 参数:find("分词")~=nil then
	键盘名="K_default" 
else
	键盘名="K_"..参数
end

local 文件=tostring(service.getLuaDir("")).."/clipboard.json"
local 短语板="../script/短语板.lua"
local 短语板记录文本=tostring(service.getLuaDir("")).."/script/短语板.txt"

local vibeFont=Typeface.DEFAULT
local 字体文件 = tostring(service.getLuaDir("")).."/fonts/牛码飞机手机5代超集宋体.ttf"
if File(字体文件).exists()==true then
  vibeFont=Typeface.createFromFile(字体文件)
end--if File(字体文件)

--检查文件存在否
if File(文件).exists()==false then
 print(文件.." 不存在,请先复制内容" )
 return
end


dofile_信息表=nil
dofile_信息表={}
local function 显示帮助(内容)
   dofile_信息表.上级脚本=脚本路径
   dofile_信息表.上级脚本所在目录=目录
   dofile_信息表.上级脚本相对路径=脚本相对路径
   dofile_信息表.纯脚本名=纯脚本名:sub(1,-5)
   dofile_信息表.内容=内容
   
   
   dofile(目录.."帮助模块.text")--导入模块

end



function 写入内容到文件指定行(路径,行数,内容)
  local a={}
  for v,s in io.lines(路径) do
	table.insert(a,v.."\n")
  end
  a[行数]=内容.."\n"
  io.open(tostring(路径),"w"):write(table.concat(a)):close()
end


local Clip,内容组={},service.getClipBoard()
for i=0,#内容组-1 do
  Clip[i+1]=内容组[i]
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
	c.drawRoundRect(b,15,15,p) --圆角15
  end)
  local bkb=LuaDrawable(function(c,p,d)
	local b=d.bounds
	b=RectF(b.left,b.top,b.right,b.bottom)
	p.setColor(0x49d3d7da)
	c.drawRoundRect(b,15,15,p)
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
		service.sendEvent("Tabuhpk")
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
	service.sendEvent("Keyboard_default")
	ta.text=Icon("Keyboard_default","返回")
	end
	ta.OnLongClickListener={onLongClick=function()
		service.sendEvent("undo")
		return true
	end}
	elseif id==5 then
	ta.text=Icon("清除","清除")
	ta.onClick=function()
	  io.open(文件,"w"):write("[\n]"):close()
	  task(300,function()  end)
	  local 输入法实例=Trime.getService()
	  输入法实例.loadClipboard()
	  print("数据已清除")
	  service.sendEvent("Keyboard_default")
	end
	ta.OnLongClickListener={onLongClick=function() return true end}
	elseif id==6 then
	ta.text="帮助"
	ta.onClick=function()
	  显示帮助(帮助内容)
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
--下面一条为打开剪切板,作用为:刷新剪切板内容(双击复制刷新)
		功能_脚本(脚本相对目录.."剪切板.lua","剪切板")
	end
	elseif id==9 then
	ta.text=Icon("剪切","剪切")
	ta.textSize="18dp"
	ta.onClick=function()
		功能_剪切()
--下面一条为打开剪切板,作用为:刷新剪切板内容(双击剪切刷新)
		功能_脚本(脚本相对目录.."剪切板.lua","剪切板")
	end
	elseif id==10 then
	ta.text=Icon("搜索","搜索")
	ta.textSize="18dp"
	ta.onClick=function()
	  if 预搜索内容 then
        Key.presetKeys.lua_script_l={label= "脚本", send="function", command=脚本相对路径, option="【【搜索】】"..预搜索内容}
      else
        Key.presetKeys.lua_script_l={label= "脚本", send="function", command=脚本相对路径, option=""}
      end
      service.sendEvent("lua_script_l")
	end
	elseif id==11 then
	ta.text=Icon("短语","短语板")
	ta.textSize="18dp"
	ta.onClick=function()
      功能_脚本(短语板,"短语板")
	end
	end
  return ta
end

local 默认高度=service.getLastKeyboardHeight()
if 默认高度<300 then 默认高度=300 end

local ids,layout={},{LinearLayout,
  orientation=1,
  --键盘高度
  layout_height=默认高度,
  layout_width=-1,
  --背景颜色
  --BackgroundColor=0xffd7dddd,
  {TextView,
	id="title",
	layout_height="30dp",
	layout_width=-1,
	text="•帮助说明",
	gravity="center",
	paddingLeft="2dp",
	paddingRight="2dp",
	BackgroundColor=0x49d3d7da
	},
	{LinearLayout,
	gravity="right",
	layout_height=-1,
	{LinearLayout,
	  id="main",
	  orientation=1,
	  --右侧功能键宽度
	  layout_weight=1,
	  layout_height=-1,
	  layout_gravity=8|3,
	  {GridView, --列表控件
		id="list",
		numColumns=1, --6列
		paddingLeft="2dp",
		paddingRight="2dp",
		layout_width=-1,
		layout_weight=1}},

   {LinearLayout,
	  orientation=1,
	  layout_weight=1,
	  layout_width="150dp",
	  layout_height=-1,
	  --layout_gravity=5|84,
	Bu_R(7),
	Bu_R(8),
	Bu_R(9),
	Bu_R(2),
	Bu_R(3),
	  },

	{LinearLayout,
	  orientation=1,
	  layout_weight=1,
	  layout_width="150dp",
	  layout_height=-1,
	  --layout_gravity=5|84,
	Bu_R(4),
	Bu_R(11),
	Bu_R(5),
	Bu_R(10),
	Bu_R(1),
	  },
}}


layout=loadlayout(layout,ids)

local data,item={},{LinearLayout,
  layout_width=-1,
  padding="4dp",
  gravity=3|17,
  {TextView,
	id="a",
	textColor=0xffff7744,--剪切板序号颜色
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
	textColor=0xfffcaf17,
	textSize="15dp"}}--剪贴内容颜色

local adp=LuaAdapter(service,data,item)
ids.list.Adapter=adp






if utf8.sub(参数,1,6)=="【【搜索】】" then
  local 搜索内容=utf8.sub(参数,7)
  print("匹配 "..搜索内容.." 中...")
    local 搜索内容组,n={},1
    for i=1,#Clip do
      local m=utf8.find(Clip[i],搜索内容)
      if m~=nil then
        搜索内容组[n]=Clip[i]
        n=n+1
      end
    end
    Clip=搜索内容组
		
		local function fresh()
		  table.clear(data)
		  
		  for i=1,#Clip do
			local v=Clip[i]
			local a,b,c=v:match("^%s*([^\n]+)(\n*[^\n]*)(\n*[^\n]*)")
			a=table.concat{utf8.sub(a,1,99),utf8.sub(b,1,99),utf8.sub(c,1,99)}
			local 内容=v
			--内容=内容:gsub("\n","<br>")
			内容=内容:gsub(".",{
			   ["<"]="&lt;",
			   [">"]="&gt;",
			  })
			内容=string.gsub(内容,"\n","<br>")
			内容="</big><font color=red><b>"..tostring(i)..".</b></font></big>"..内容
			
			table.insert(data,{b=Html.fromHtml(内容)})
			
		  end
		  adp.notifyDataSetChanged()
		end
		fresh()
		
		ids.list.onItemClick=function(l,v,p)
		  local s=Clip[p+1]
		  service.commitText(s)
		end
		
ids.list.onItemLongClick=function(l,v,p)
   dofile_信息表=nil
   dofile_信息表={}
   dofile_信息表.上级脚本=脚本路径
   dofile_信息表.上级脚本所在目录=目录
   dofile_信息表.上级脚本相对路径=脚本相对路径
   dofile_信息表.纯脚本名=纯脚本名:sub(1,-5)
   dofile_信息表.内容=Clip[p+1]
   
   dofile(目录.."分词工具.text")--导入模块
  
  return true
end
		
else--if 搜索内容~
		local Clip=service.getClipBoard()
		local function fresh()
		  table.clear(data)
		  for i=0,#Clip-1 do
			local v=Clip[i]
			local a,b,c=v:match("^%s*([^\n]+)(\n*[^\n]*)(\n*[^\n]*)")
		   a=table.concat{utf8.sub(a or "",1,99),utf8.sub(b or "",1,99),utf8.sub(c or "",1,99)}
			local 内容=v
			--内容=内容:gsub("\n","<br>")
			内容=内容:gsub(".",{
			   ["<"]="&lt;",
			   [">"]="&gt;",
			  })
			内容=string.gsub(内容,"\n","<br>")
			内容="</big><font color=red><b>"..tostring(i+1)..".</b></font></big>"..内容
			table.insert(data,{b=Html.fromHtml(内容)})
		  end
		  adp.notifyDataSetChanged()
		end
		fresh()
		
		ids.list.onItemClick=function(l,v,p)
		  local s=Clip[p]
		  service.commitText(s)
		  --置顶已上屏内容
		  if p>0 then
			Clip.remove(p)
			Clip.add(0,s)
			fresh()
		  end
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
		  .setTitle(string.format("%s.  预览/操作（%s）",p+1,utf8.len(str)))
		  .setView(loadlayout(lay))
		    .setButton("置顶",function()
			if p>0 then
			  Clip.remove(p)
			  Clip.add(0,str)
			  service.getSystemService(Context.CLIPBOARD_SERVICE).setText(str) 
			end
		  end)
		  
		  .setButton2("删除",function()
			Clip.remove(p)
		  end)
		  .setButton3("添加到短语",function()
		  local 内容=str:gsub("\n","\\n")
--下面一行内容为原始内容,好像没写完全,没生效,因此注释掉了.
--		  写入内容到文件指定行(输入法目录.."phrase.json",1,"[\n    \""..内容.."\"")
		  io.open(短语板记录文本,"a+"):write("\n"):close()
		  io.open(短语板记录文本,"a+"):write(内容):close()
		  print("短语添加成功",内容)
		  end)
		  .setOnDismissListener{onDismiss=function()
			  fresh()
		  end}
		  .show()
		  --返回（真），否则长按也会触发点击事件
		  return true
		end
end--if 搜索内容

local 标题=纯脚本名:sub(1,-5)
  标题=标题..版本号
  if 搜索内容~="" and 搜索内容~=nil then
    标题=标题.."(\""..搜索内容.."\" 相关共"..#Clip.."条)"
  else
    标题=标题.."(全部"..#Clip.."条)"
  end
  
  
ids.title.setText(标题)


service.setKeyboard(layout)

--视频路径
local path=目录.."mv.mp4"

--视频文件不存在则终止脚本
if os.type(path)~="file"
  return
end
pcall(function()
  local play=MediaPlayer()
  play.setDataSource(path)
  --循环播放
  play.setLooping(true)
  play.prepare()
  --音量设置为0
  play.setVolume(0,0)

  local video=loadlayout{SurfaceView,
	--添加背景色，避免看不清按键
	BackgroundColor=0xffffffff,
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
