import AVFoundation
import Foundation

// 创建一个本地测试视频文件
func createTestVideoFile() async throws -> URL {
    let fileManager = FileManager.default
    let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let videoURL = documentsDirectory.appendingPathComponent("test_video.mp4")
    
    // 如果文件不存在，创建一个简单的测试视频文件
    if !fileManager.fileExists(atPath: videoURL.path) {
        print("正在创建测试视频文件...")
        // 这里可以添加创建测试视频文件的逻辑
        // 暂时创建一个空文件作为示例
        try Data().write(to: videoURL)
    }
    
    return videoURL
}

// 异步加载资源的属性
func testAVAssetProperties() async {
    // 需要加载的属性
    let keysToLoad = ["tracks", "duration", "commonMetadata", "availableMetadataFormats"]
    
    do {
        // 使用 Task 和 async/await 处理异步加载
        try await asset.load(.init(keysToLoad))
        
        // 检查每个属性的加载状态
        for key in keysToLoad {
            var error: NSError?
            let status = asset.statusOfValue(forKey: key, error: &error)
            
            switch status {
            case .loaded:
                print("属性 \(key) 加载成功")
                switch key {
                case "tracks":
                    await testTracks(asset: asset)
                case "duration":
                    await testDuration(asset: asset)
                case "commonMetadata":
                    await testCommonMetadata(asset: asset)
                case "availableMetadataFormats":
                    await testAvailableMetadataFormats(asset: asset)
                default:
                    break
                }
            case .failed:
                print("属性 \(key) 加载失败: \(error?.localizedDescription ?? "未知错误")")
                if let error = error {
                    print("错误详情: \(error)")
                }
            case .cancelled:
                print("属性 \(key) 加载取消")
            default:
                print("属性 \(key) 未加载")
            }
        }
    } catch {
        print("加载属性失败: \(error)")
    }
}

// 测试轨道信息
func testTracks(asset: AVAsset) async {
    print("\n轨道信息:")
    for track in try? await asset.loadTracks() ?? [] {
        print("轨道类型: \(track.mediaType.rawValue)")
        print("轨道 ID: \(track.trackID)")
        print("轨道时长: \(CMTimeGetSeconds(track.timeRange.duration)) 秒")
        print("轨道自然大小: \(track.naturalSize)")
        print("轨道帧率: \(track.nominalFrameRate)")
        print("-----")
    }
}

// 测试资源时长
func testDuration(asset: AVAsset) async {
    if let duration = try? await asset.load(.duration) {
        print("\n资源时长: \(CMTimeGetSeconds(duration)) 秒")
    }
}

// 测试常用元数据
func testCommonMetadata(asset: AVAsset) async {
    print("\n常用元数据:")
    if let metadata = try? await asset.load(.commonMetadata) {
        for metadataItem in metadata {
            print("元数据标识符: \(metadataItem.identifier?.rawValue ?? "未知")")
            print("元数据值: \(metadataItem.value ?? "无")")
            print("-----")
        }
    }
}

// 测试支持的元数据格式
func testAvailableMetadataFormats(asset: AVAsset) async {
    print("\n支持的元数据格式:")
    if let formats = try? await asset.load(.availableMetadataFormats) {
        for format in formats {
            print(format)
        }
    }
}

// 主函数
func main() async throws {
    do {
        let videoURL = try await createTestVideoFile()
        let asset = AVAsset(url: videoURL)
        await testAVAssetProperties()
    } catch {
        print("发生错误: \(error)")
    }
}

// 运行测试
Task {
    do {
        try await main()
        exit(0)
    } catch {
        print("程序执行失败: \(error)")
        exit(1)
    }
}