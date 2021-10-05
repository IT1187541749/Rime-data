

function 调用程序打开文件(path)
  import "android.webkit.MimeTypeMap"
  import "android.content.Intent"
  import "android.net.Uri"
  import "java.io.File"
  FileName=tostring(File(path).Name)
  ExtensionName=FileName:match("%.(.+)")
  Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  if Mime then 
    intent = Intent(); 
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
    intent.setAction(Intent.ACTION_VIEW); 
    intent.setDataAndType(Uri.fromFile(File(path)), Mime); 
    service.startActivity(intent);
  else
    Toastc("找不到可以用来打开此文件的程序")
  end
end


