package com.example.lcrealtime;
import cn.leancloud.LCInstallation;
import cn.leancloud.LCLogger;
import cn.leancloud.LCObject;
import cn.leancloud.LeanCloud;
import cn.leancloud.im.LCIMOptions;
import cn.leancloud.push.PushService;
import io.flutter.app.FlutterApplication;
import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;

public class MyApplication extends FlutterApplication{
    private static final String LC_App_Id = "JMBPc7y4SUPRDrOSHXjXVMN7-gzGzoHsz";
    private static final String LC_App_Key = "Wib2dECd48h1FzivFrH628ju";
    private static final String LC_Server_Url = "https://jmbpc7y4.lc-cn-n1-shared.com";

    @Override
    public void onCreate() {
        super.onCreate();
        LCIMOptions.getGlobalOptions().setUnreadNotificationEnabled(true);
        LeanCloud.setLogLevel(LCLogger.Level.DEBUG);
        LeanCloud.initialize(this, LC_App_Id, LC_App_Key, LC_Server_Url);
        LCInstallation.getCurrentInstallation().saveInBackground().subscribe(new Observer<LCObject>() {
            @Override
            public void onSubscribe(Disposable d) {
            }
            @Override
            public void onNext(LCObject LCObject) {
                // 关联 installationId 到用户表等操作。
                String installationId = LCInstallation.getCurrentInstallation().getInstallationId();
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
