
import Foundation

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
if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
    print("Documents directory path: \(documentsURL.path)")
}

// 获取缓存目录路径
if let cachesURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
    print("Caches directory path: \(cachesURL.path)")
}