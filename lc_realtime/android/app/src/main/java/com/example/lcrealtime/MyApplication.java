package com.example.lcrealtime;
import cn.leancloud.AVInstallation;
import cn.leancloud.AVLogger;
import cn.leancloud.AVOSCloud;
import cn.leancloud.AVObject;
import cn.leancloud.im.AVIMOptions;
import cn.leancloud.push.PushService;
import io.flutter.app.FlutterApplication;
import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;

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
        AVInstallation.getCurrentInstallation().saveInBackground().subscribe(new Observer<AVObject>() {
            @Override
            public void onSubscribe(Disposable d) {
            }
            @Override
            public void onNext(AVObject avObject) {
                // 关联 installationId 到用户表等操作。
                String installationId = AVInstallation.getCurrentInstallation().getInstallationId();
                System.out.println("保存成功：" + installationId );
            }
            @Override
            public void onError(Throwable e) {
                System.out.println("保存失败，错误信息：" + e.getMessage());
            }
            @Override
            public void onComplete() {
            }
        });
        PushService.setDefaultPushCallback(this, MainActivity.class);
        PushService.setDefaultChannelId(this, "channelId");
    }
}
