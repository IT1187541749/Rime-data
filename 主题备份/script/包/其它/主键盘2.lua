function 主键盘(高度,宽度)--设置主键盘按键
 local 按键={}
 if 高度!=nil then 按键["height"]=高度 end
 if 宽度!=nil then 按键["width"]=宽度 end
 按键["click"]={label="返回", send="Eisu_toggle",select= "default_zd"}
 
 
 
 return 按键
end--function 主键盘

