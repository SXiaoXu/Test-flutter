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
                id: "WmPQYaUUOkezEpt2RqgH1gyL-gzGzoHsz",
                key: "HN4kVNAdvov7iSiCaIypDYiB",
                serverURL: "https://wmpqyauu.lc-cn-n1-shared.com")
            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        } catch {
            fatalError("\(error)")
        }
    }
}
