




require "import"
import "android.content.ComponentName"
import "android.content.Intent"
import "android.os.Build"
import "android.content.IntentFilter"
import "com.osfans.trime.*" --载入包
import "android.view.KeyEvent"

local intent = Intent();
intent.setComponent(ComponentName("com.example.input", "com.example.softwaretest.HWService"));
intent.putExtra("height", int(1120));
intent.putExtra("back_color", int(0xff888888));
intent.putExtra("text_color", int(0xff000000));
intent.putExtra("candidate_text_color", int(0xff000000));

if (Build.VERSION.SDK_INT >= 26) --Build.VERSION_CODES.O
  service.startForegroundService(intent);
 else
  service.startService(intent);
end


filter = IntentFilter();
filter.addAction("com.osfans.trime.commit");

service.registerReceiver(filter)

function onReceive(c,i)
  local 上屏内容=i.getStringExtra("text")
  if 上屏内容=="keycode:KEYCODE_FORWARD_DEL" then
    service.onKey(KeyEvent.KEYCODE_DEL, 0)--模拟删除键
  else
    service.commitText(上屏内容)
  end
end

print("手写模块启动中...")
