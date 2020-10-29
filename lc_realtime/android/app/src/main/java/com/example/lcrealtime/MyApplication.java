package com.example.lcrealtime;
import cn.leancloud.AVLogger;
import cn.leancloud.AVOSCloud;
import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication{
    private static final String LC_App_Id = "2S3eFs2gbLVcDKBtXTM0e5KX-gzGzoHsz";
    private static final String LC_App_Key = "CY6NPCRRLpPGKLCe8372924N";
    private static final String LC_Server_Url = "https://ip-np10.iwxnews.com";

    @Override
    public void onCreate() {
        super.onCreate();
        AVOSCloud.setLogLevel(AVLogger.Level.DEBUG);
        AVOSCloud.initialize(this, LC_App_Id, LC_App_Key, LC_Server_Url);

    }
}
