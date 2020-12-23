package com.example.lcrealtime;
import cn.leancloud.AVLogger;
import cn.leancloud.AVOSCloud;
import cn.leancloud.im.AVIMOptions;
import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication{
    private static final String LC_App_Id = "WmPQYaUUOkezEpt2RqgH1gyL-gzGzoHsz";
    private static final String LC_App_Key = "HN4kVNAdvov7iSiCaIypDYiB";
    private static final String LC_Server_Url = "https://wmpqyauu.lc-cn-n1-shared.com";

    @Override
    public void onCreate() {
        super.onCreate();
        AVIMOptions.getGlobalOptions().setUnreadNotificationEnabled(true);
        AVOSCloud.setLogLevel(AVLogger.Level.DEBUG);
        AVOSCloud.initialize(this, LC_App_Id, LC_App_Key, LC_Server_Url);
    }
}
