import Foundation

// 测试 URL 的基本功能
func testURL() {
    print("开始测试 URL 功能")

    // 1. 测试创建 URL
    if let url = URL(string: "https://www.example.com/path/to/resource?query=123#fragment") {
        print("URL 创建成功: \(url)")
    } else {
        print("URL 创建失败")
    }

    // 2. 测试 URL 的各个部分
    if let url = URL(string: "https://www.example.com/path/to/resource?query=123#fragment") {
        print("Scheme: \(url.scheme ?? "无")") // https
        print("Host: \(url.host ?? "无")") // www.example.com
        print("Path: \(url.path)") // /path/to/resource
        print("Query: \(url.query ?? "无")") // query=123
        print("Fragment: \(url.fragment ?? "无")") // fragment
    }

    // 3. 测试 URL 的路径操作
    if let baseURL = URL(string: "https://www.example.com") {
        let newURL = baseURL.appendingPathComponent("newPath")
        print("追加路径后的 URL: \(newURL)") // https://www.example.com/newPath
    }

    // 4. 测试 URL 的查询参数
    if var components = URLComponents(string: "https://www.example.com/search") {
        components.queryItems = [URLQueryItem(name: "q", value: "swift")]
        if let finalURL = components.url {
            print("添加查询参数后的 URL: \(finalURL)") // https://www.example.com/search?q=swift
        }
    }

    // 5. 测试 URL 的文件路径
    if let fileURL = URL(string: "file:///Users/username/Documents/file.txt") {
        print("文件 URL: \(fileURL)")
        print("文件路径: \(fileURL.path)") // /Users/username/Documents/file.txt
        print("文件扩展名: \(fileURL.pathExtension)") // txt
        print("文件名: \(fileURL.lastPathComponent)") // file.txt
        print("去掉扩展名后的文件名: \(fileURL.deletingPathExtension().lastPathComponent)") // file
    }

    // 6. 测试 URL 的相对路径
    if let baseURL = URL(string: "https://www.example.com") {
        let relativeURL = URL(string: "relative/path", relativeTo: baseURL)
        print("相对路径 URL: \(relativeURL?.absoluteString ?? "无")") // https://www.example.com/relative/path
    }

    print("URL 功能测试完成")
}

// 测试本地 URL 的功能
func testLocalURL() {
    print("开始测试本地 URL 功能")

    // 1. 测试创建本地文件 URL
    let fileManager = FileManager.default
    let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent("testFile.txt")
    print("本地文件 URL: \(fileURL)")

    // 2. 测试 URL 的路径属性
    print("文件路径: \(fileURL.path)")
    print("文件扩展名: \(fileURL.pathExtension)")
    print("文件名: \(fileURL.lastPathComponent)")
    print("去掉扩展名后的文件名: \(fileURL.deletingPathExtension().lastPathComponent)")

    // 3. 测试 URL 的路径操作
    let subdirectoryURL = fileURL.deletingLastPathComponent().appendingPathComponent("Subdirectory")
    print("子目录 URL: \(subdirectoryURL)")

    // 4. 测试 URL 是否存在
    if fileManager.fileExists(atPath: fileURL.path) {
        print("文件已存在")
    } else {
        print("文件不存在")
    }

    // 5. 测试创建文件
    do {
        try "Hello, World!".write(to: fileURL, atomically: true, encoding: .utf8)
        print("文件创建成功")
    } catch {
        print("文件创建失败: \(error)")
    }

    // 6. 测试读取文件内容
    do {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        print("文件内容: \(content)")
    } catch {
        print("读取文件失败: \(error)")
    }

    // 7. 测试删除文件
    do {
        try fileManager.removeItem(at: fileURL)
        print("文件删除成功")
    } catch {
        print("文件删除失败: \(error)")
    }

    print("本地 URL 功能测试完成")
}

// 执行测试
testLocalURL()

// 执行测试
testURL()