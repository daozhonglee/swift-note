import Foundation

// 基本定时器示例：3秒后执行一次
func basicTimerExample() {
    print("开始基本定时器示例")
    var timer: Timer?
    timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
        print("3秒后执行一次的定时器触发了！")
        timer?.invalidate()
        timer = nil
    }
    RunLoop.current.run(until: Date(timeIntervalSinceNow: 4))
}

// 重复执行的定时器示例：每2秒执行一次，执行5次后停止
func repeatingTimerExample() {
    print("开始重复定时器示例")
    var timer: Timer?
    var count = 0
    timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { t in
        count += 1
        print("重复定时器第\(count)次触发")
        
        if count >= 5 {
            print("已执行5次，停止定时器")
            t.invalidate()
            timer = nil
        }
    }
    RunLoop.current.run(until: Date(timeIntervalSinceNow: 12))
}

// Swift 闭包方式的定时器示例
func swiftTimerExample() {
    print("开始 Swift 定时器示例")
    var timer: Timer?
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
        print("Swift 定时器触发")
    }
    
    // 5秒后停止定时器
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        timer?.invalidate()
        timer = nil
        print("Swift 定时器已停止")
    }
    RunLoop.current.run(until: Date(timeIntervalSinceNow: 6))
}

// 暂停和恢复定时器示例
func pauseResumeExample() {
    print("开始暂停和恢复定时器示例")
    // 创建一个定时器，但不自动添加到 RunLoop
    let timer = Timer(timeInterval: 1.0, repeats: true) { _ in
        print("每秒执行一次")
    }
    
    // 手动将定时器添加到当前 RunLoop
    RunLoop.current.add(timer, forMode: .common)
    
    // 5秒后暂停定时器
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        print("暂停定时器")
        timer.fireDate = .distantFuture // 暂停定时器
        
        // 3秒后恢复定时器
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("恢复定时器")
            timer.fireDate = .now // 恢复定时器
            
            // 再过5秒后停止定时器
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                timer.invalidate()
                print("暂停和恢复定时器示例已完成")
            }
        }
    }
    RunLoop.current.run(until: Date(timeIntervalSinceNow: 14))
}

// 按序执行所有示例
print("=== 测试基本定时器 ===\n")
basicTimerExample()

print("\n=== 测试重复定时器 ===\n")
repeatingTimerExample()

print("\n=== 测试 Swift 定时器 ===\n")
swiftTimerExample()

print("\n=== 测试暂停和恢复定时器 ===\n")
pauseResumeExample()