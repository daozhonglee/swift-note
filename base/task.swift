import Foundation

// 模拟一个异步函数
func someAsyncFunction(name: String, duration: UInt64) async -> String {
    print("任务 \(name) 开始")
    await Task.sleep(duration) // 模拟耗时操作
    print("任务 \(name) 完成")
    return "任务 \(name) 结果"
}

// 测试 Task 的所有功能
func testTaskFunctionality() async {
    print("开始测试 Task 功能")

    // 1. 测试基本任务
    let basicTask = Task {
        return await someAsyncFunction(name: "基本任务", duration: 1_000_000_000)
    }
    let basicResult = await basicTask.value
    print("基本任务结果: \(basicResult)")

    // 2. 测试任务取消
    let cancellableTask = Task {
        do {
            try Task.checkCancellation()
            return await someAsyncFunction(name: "可取消任务", duration: 2_000_000_000)
        } catch {
            return "任务被取消"
        }
    }
    cancellableTask.cancel() // 取消任务
    let cancellableResult = await cancellableTask.value
    print("可取消任务结果: \(cancellableResult)")

    // 3. 测试任务优先级
    let highPriorityTask = Task(priority: .high) {
        return await someAsyncFunction(name: "高优先级任务", duration: 1_000_000_000)
    }
    let lowPriorityTask = Task(priority: .low) {
        return await someAsyncFunction(name: "低优先级任务", duration: 1_000_000_000)
    }
    let highPriorityResult = await highPriorityTask.value
    let lowPriorityResult = await lowPriorityTask.value
    print("高优先级任务结果: \(highPriorityResult)")
    print("低优先级任务结果: \(lowPriorityResult)")

    // 4. 测试结构化并发
    func structuredConcurrency() async {
        Task {
            print("子任务 1 开始")
            await someAsyncFunction(name: "子任务 1", duration: 1_000_000_000)
            print("子任务 1 完成")
        }

        Task {
            print("子任务 2 开始")
            await someAsyncFunction(name: "子任务 2", duration: 2_000_000_000)
            print("子任务 2 完成")
        }
    }
    await structuredConcurrency()

    // 5. 测试任务组
    func taskGroupExample() async {
        await withTaskGroup(of: String.self) { group in
            for i in 1...3 {
                group.addTask {
                    return await someAsyncFunction(name: "任务组任务 \(i)", duration: UInt64(i) * 1_000_000_000)
                }
            }

            for await result in group {
                print("任务组结果: \(result)")
            }
        }
    }
    await taskGroupExample()

    print("Task 功能测试完成")
}

// 执行测试
Task {
    await testTaskFunctionality()
}