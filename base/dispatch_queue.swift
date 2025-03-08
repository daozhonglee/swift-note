import Foundation

// MARK: - 基本队列示例

// 主队列（串行）示例

// 为什么在主队列示例中需要 RunLoop
// - 主队列的任务需要在主线程的 RunLoop 中执行
// - 如果没有 RunLoop，异步添加到主队列的任务可能没有机会执行
// - 在 UI 应用中，主线程的 RunLoop 是自动运行的
// - 在命令行程序中，需要手动运行 RunLoop 或使用其他队列
func mainQueueExample() {
    print("=== 主队列示例 ===")

    // 在主队列上异步执行任务
    DispatchQueue.main.async {
        print("主队列异步任务1")
    }

    DispatchQueue.main.async {
        print("主队列异步任务2")
    }
    // 使用 RunLoop 来确保主队列的任务能够执行
    RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
    Thread.sleep(forTimeInterval: 2)
}

// 全局队列（并发）示例
func globalQueueExample() {
    print("\n=== 全局队列示例 ===")

    // 使用不同优先级的全局队列
    let highQueue = DispatchQueue.global(qos: .userInteractive)  // 最高优先级
    let defaultQueue = DispatchQueue.global()  // 默认优先级
    let lowQueue = DispatchQueue.global(qos: .background)  // 最低优先级

    lowQueue.async {
        print("低优先级任务执行")
    }
    defaultQueue.async {
        print("默认优先级任务执行")
    }
    highQueue.async {
        print("高优先级任务执行")
    }

}

// MARK: - 自定义队列示例

// 串行队列示例
func serialQueueExample() {
    print("\n=== 串行队列示例 ===")

    // 创建一个串行队列
    let serialQueue = DispatchQueue(label: "com.example.serial")

    // 在串行队列上执行多个任务（按顺序执行）
    serialQueue.async {
        print("串行任务1开始")
        Thread.sleep(forTimeInterval: 1)
        print("串行任务1完成")
    }

    serialQueue.async {
        print("串行任务2开始")
        Thread.sleep(forTimeInterval: 1)
        print("串行任务2完成")
    }
}

// 并发队列示例
func concurrentQueueExample() {
    print("\n=== 并发队列示例 ===")

    // 创建一个并发队列
    let concurrentQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)

    // 在并发队列上执行多个任务（同时执行）
    concurrentQueue.async {
        print("并发任务1开始")
        Thread.sleep(forTimeInterval: 2)
        print("并发任务1完成")
    }

    concurrentQueue.async {
        print("并发任务2开始")
        Thread.sleep(forTimeInterval: 1)
        print("并发任务2完成")
    }
    Thread.sleep(forTimeInterval: 2)
}

// MARK: - 延迟执行示例

func delayExample() {
    print("\n=== 延迟执行示例 ===")
    print("开始延迟执行示例")

    // 延迟2秒执行
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("2秒后执行的任务")
    }

    // 延迟4秒执行
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        print("4秒后执行的任务")
    }
    RunLoop.main.run(until: Date(timeIntervalSinceNow: 10))
    Thread.sleep(forTimeInterval: 10)
}

// MARK: - DispatchGroup 示例

func dispatchGroupExample() {
    print("\n=== DispatchGroup 示例 ===")

    let group = DispatchGroup()
    let queue = DispatchQueue.global()

    // 添加多个异步任务到组
    queue.async(group: group) {
        print("任务1开始")
        Thread.sleep(forTimeInterval: 2)
        print("任务1完成")
    }

    queue.async(group: group) {
        print("任务2开始")
        Thread.sleep(forTimeInterval: 1)
        print("任务2完成")
    }

    // 当所有任务完成后通知
    group.notify(queue: .main) {
        print("所有任务都已完成")
    }
}

// MARK: - 信号量示例

func semaphoreExample() {
    print("\n=== 信号量示例 ===")

    // 创建一个信号量，允许2个并发访问
    let semaphore = DispatchSemaphore(value: 2)
    let queue = DispatchQueue.global()

    for i in 1...4 {
        queue.async {
            // 等待信号量
            semaphore.wait()

            print("任务\(i)开始执行")
            Thread.sleep(forTimeInterval: 2)
            print("任务\(i)完成执行")

            // 释放信号量
            semaphore.signal()
        }
    }
}

// MARK: - 栅栏函数示例

func barrierExample() {
    print("\n=== 栅栏函数示例 ===")

    let queue = DispatchQueue(label: "com.example.barrier", attributes: .concurrent)

    // 添加一些并发任务
    queue.async {
        print("任务1开始")
        Thread.sleep(forTimeInterval: 1)
        print("任务1完成")
    }

    queue.async {
        print("任务2开始")
        Thread.sleep(forTimeInterval: 2)
        print("任务2完成")
    }

    // 添加栅栏函数
    queue.async(flags: .barrier) {
        print("栅栏函数执行 - 等待前面的任务完成")
        Thread.sleep(forTimeInterval: 1)
        print("栅栏函数完成")
    }

    // 添加更多并发任务
    queue.async {
        print("任务3开始")
        Thread.sleep(forTimeInterval: 1)
        print("任务3完成")
    }

    queue.async {
        print("任务4开始")
        Thread.sleep(forTimeInterval: 2)
        print("任务4完成")
    }
}

// MARK: - 运行所有示例

// 主队列示例
// mainQueueExample()

// // 全局队列示例
// globalQueueExample()

// // 串行队列示例
// serialQueueExample()

// // 并发队列示例
// concurrentQueueExample()

// // 延迟执行示例
delayExample()

// // DispatchGroup 示例
// dispatchGroupExample()

// // 信号量示例
// semaphoreExample()

// // 栅栏函数示例
// barrierExample()

// // 为了让异步任务有足够时间执行
// Thread.sleep(forTimeInterval: 15)  // 等待15秒让所有示例完成
