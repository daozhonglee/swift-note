
import Foundation

func testFileManager() {
    let fileManager = FileManager.default
    // fileManager 是 FileManager 的实例，FileManager 用于管理文件和目录。

    // urls(for:in:) 是 FileManager 的一个方法，用来查找指定的系统目录。
    // .documentDirectory：表示“文档”目录，也就是 Documents 文件夹。在 iOS 应用中，这个目录是专门用来存储用户可以访问的文档文件的。
    // .userDomainMask：表示在用户的主目录下查找文件夹，通常就是应用的沙盒区域（例如 ~/Documents）。
    // 该方法返回一个包含 URL 的数组，因为可能存在多个匹配的路径（但通常在 iOS 上，Documents 目录只有一个）。

    // .first：
    // 调用了 first 属性，意在从返回的 URL 数组中获取第一个 URL（通常也是唯一的一个）。
    // 通过使用 first，可以直接得到 Documents 目录的 URL（如果存在），以避免直接操作数组的繁琐性。
    // 获取应用的文档目录路径
    // 获取应用程序的文档目录
    let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    print("文档目录路径: \(documentsDirectory.path)")

    if let appSupportDirectory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
        print("应用程序支持目录路径: \(appSupportDirectory.path)")
    }
    if let desktopDirectory = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first {
        print("桌面目录路径: \(desktopDirectory.path)")
    }
    
    // 创建一个测试目录
    let testDirectory = documentsDirectory.appendingPathComponent("TestDirectory")
    print("测试目录路径: \(testDirectory.path)")
    
    // 创建一个测试文件
    let testFile = testDirectory.appendingPathComponent("testFile.txt")
    print("测试文件路径: \(testFile.path)")
    
    let testContent = "This is a test file."
    print("测试文件内容: \(testContent)")
    
    // 1. 创建目录
    print("\n=== 步骤 1: 创建目录 ===")
    do {
        // withIntermediateDirectories: Bool 类型，指示是否创建中间目录。如果设置为 true，则会在路径中缺失的任何中间目录也一并创建。
        try fileManager.createDirectory(at: testDirectory, withIntermediateDirectories: true, attributes: nil)
        print("✅ 目录创建成功: \(testDirectory.path)")
    } catch {
        print("❌ 创建目录失败: \(error.localizedDescription)")
        return
    }
    
    // 2. 创建文件并写入内容
    print("\n=== 步骤 2: 创建文件并写入内容 ===")
    do {
        try testContent.write(to: testFile, atomically: true, encoding: .utf8)
        print("✅ 文件创建成功: \(testFile.path)")
        print("✅ 文件内容已写入: \(testContent)")
    } catch {
        print("❌ 创建文件失败: \(error.localizedDescription)")
        return
    }
    
    // 3. 读取文件内容
    print("\n=== 步骤 3: 读取文件内容 ===")
    do {
        let content = try String(contentsOf: testFile, encoding: .utf8)
        print("✅ 文件内容读取成功: \(content)")
    } catch {
        print("❌ 读取文件内容失败: \(error.localizedDescription)")
        return
    }
    
    // 4. 检查文件是否存在
    print("\n=== 步骤 4: 检查文件是否存在 ===")
    if fileManager.fileExists(atPath: testFile.path) {
        print("✅ 文件存在: \(testFile.path)")
    } else {
        print("❌ 文件不存在: \(testFile.path)")
    }
    
    // 5. 删除文件
    print("\n=== 步骤 5: 删除文件 ===")
    do {
        try fileManager.removeItem(at: testFile)
        print("✅ 文件删除成功: \(testFile.path)")
    } catch {
        print("❌ 删除文件失败: \(error.localizedDescription)")
        return
    }
    
    // 6. 检查文件是否仍然存在
    print("\n=== 步骤 6: 检查文件是否仍然存在 ===")
    if fileManager.fileExists(atPath: testFile.path) {
        print("❌ 文件仍然存在: \(testFile.path)")
    } else {
        print("✅ 文件已成功删除: \(testFile.path)")
    }
    
    // 7. 删除目录
    print("\n=== 步骤 7: 删除目录 ===")
    do {
        try fileManager.removeItem(at: testDirectory)
        print("✅ 目录删除成功: \(testDirectory.path)")
    } catch {
        print("❌ 删除目录失败: \(error.localizedDescription)")
        return
    }
    
    // 8. 检查目录是否仍然存在
    print("\n=== 步骤 8: 检查目录是否仍然存在 ===")
    if fileManager.fileExists(atPath: testDirectory.path) {
        print("❌ 目录仍然存在: \(testDirectory.path)")
    } else {
        print("✅ 目录已成功删除: \(testDirectory.path)")
    }
}

// 调用测试函数
testFileManager()