import Foundation

// 测试主应用程序包
func testMainBundle() {
    let mainBundle = Bundle.main
    print("主应用程序包: \(mainBundle)")
}

// 测试获取资源文件的路径
func testResourcePath() {
    let mainBundle = Bundle.main
    if let path = mainBundle.path(forResource: "example", ofType: "txt") {
        print("资源文件路径: \(path)")
    } else {
        print("未找到资源文件")
    }
}

// 测试获取资源文件的 URL
func testResourceURL() {
    let mainBundle = Bundle.main
    if let url = mainBundle.url(forResource: "example", withExtension: "txt") {
        print("资源文件 URL: \(url)")
    } else {
        print("未找到资源文件")
    }
}

// 测试批量获取资源文件的 URL
func testResourceURLs() {
    let mainBundle = Bundle.main
    if let urls = mainBundle.urls(forResourcesWithExtension: "txt", subdirectory: nil) {
        if urls.isEmpty {
            print("未找到 .txt 文件")
        } else {
            for url in urls {
                print("找到文件: \(url.lastPathComponent)")
            }
        }
    } else {
        print("未找到 .txt 文件")
    }
}

// 测试获取 Info.plist 中的信息
func testInfoPlist() {
    let mainBundle = Bundle.main
    if let appName = mainBundle.object(forInfoDictionaryKey: "CFBundleName") as? String {
        print("应用程序名称: \(appName)")
    } else {
        print("未找到应用程序名称")
    }
}

// 测试获取本地化字符串
func testLocalizedString() {
    let mainBundle = Bundle.main
    let localizedString = mainBundle.localizedString(forKey: "Hello", value: "Default Hello", table: nil)
    print("本地化字符串: \(localizedString)")
}

// 测试获取框架包
func testFrameworkBundle() {
    let frameworkBundle = Bundle(for: NSString.self) // 以 Foundation 的 NSString 为例
    print("框架包: \(frameworkBundle)")
}

// 运行所有测试
func runBundleTests() {
    print("开始测试 Bundle 功能")
    testMainBundle()
    testResourcePath()
    testResourceURL()
    testResourceURLs()
    testInfoPlist()
    testLocalizedString()
    testFrameworkBundle()
    print("Bundle 功能测试完成")
}

// 执行测试
runBundleTests()