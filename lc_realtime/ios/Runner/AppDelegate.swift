import Flutter
import LeanCloud

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        do {
            LCApplication.logLevel = .all
            try LCApplication.default.set(
                id: "JMBPc7y4SUPRDrOSHXjXVMN7-gzGzoHsz",
                key: "Wib2dECd48h1FzivFrH628ju",
                serverURL: "https://jmbpc7y4.lc-cn-n1-shared.com")
            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        } catch {
            fatalError("\(error)")
        }
    }
}
