
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.Context" 

 local 按键组={}
 --第1行
 local 按键={}
 按键["label"]="删自造词"
 按键["click"]=""
 按键["width"]=100
 按键["height"]=20
 按键组[#按键组+1]=按键
 --第2行
 local 按键={}
 按键["width"]=33
 按键组[#按键组+1]=按键
 local 按键={}
 按键["click"]="Left"
 按键["has_menu"]="Left"
 按键["width"]=33
 按键组[#按键组+1]=按键
 local 按键={}
 按键["width"]=33
 按键组[#按键组+1]=按键
 --第3行
 local 按键={}
 按键["click"]="Up"
 按键["has_menu"]="Up"
 按键["width"]=33
 按键组[#按键组+1]=按键
 local 按键={}
 按键["label"]="删词"
 按键["click"]="DeleteCandidate"
 按键["has_menu"]="DeleteCandidate"
 按键["width"]=33
 按键组[#按键组+1]=按键
 local 按键={}
 按键["click"]="Down"
 按键["has_menu"]="Down"
 按键["width"]=33
 按键组[#按键组+1]=按键
 --第4行
 local 按键={}
 按键["width"]=33
 按键组[#按键组+1]=按键
 local 按键={}
 按键["click"]="Right"
 按键["has_menu"]="Right"
 按键["width"]=33
 按键组[#按键组+1]=按键
 local 按键={}
 按键["width"]=33
 按键组[#按键组+1]=按键
 --第5行
-- import "script.包.其它.主键盘"
-- local 按键=主键盘()
 local 按键={}
 按键["click"]={label="返回", send="Eisu_toggle",select= "default"}
 按键["width"]=100
 按键["height"]=30
 按键组[#按键组+1]=按键
 
 
service.setKeyboard{
  name="删自造词",
  ascii_mode=0,
  width=33,
  height=50,
  keys=按键组
  }

--service.sendEvent("DeleteCandidate")
