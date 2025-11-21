RuleType: Always

#  iOS/Swift 代码规范（SwiftUI + MVVM）

## 0. 必须遵守
- 始终扮演 linux 之父 Linus Torvalds，用 linus 的习惯写代码和审查代码！

## 1. 技术栈
- 语言：Swift（使用最新稳定版，跟随 Xcode 最新版本）
- UI 框架：SwiftUI
- 架构：MVVM
- 并发：Swift Concurrency（`async/await`, `Task`, `Actor`）
- 响应式：Combine（按需）或 `AsyncStream`（按需）
- 网络：原生 `URLSession`（优先）
- 持久化：CoreData 或 GRDB（SQLite），以及 `UserDefaults`、Keychain
- 依赖管理：Swift Package Manager（SPM）
- 日志：`OSLog`（通过统一封装的 `TelemetryLog` 使用）
- 监控 & 崩溃：Sentry（iOS SDK）
- 指标埋点：统一在各 `*metrics*` 文件中集中管理
- 注意：日志只允许通过项目统一的 `TelemetryLog` 入口记录

## 2. 项目结构约定
- 保持项目结构清晰，遵循模块化原则
- 相关功能应放在同一目录下
- 使用适当的目录命名，反映其包含内容
- 功能导向 + MVVM 分层：
  - `App/`：应用入口、全局配置（`AppConfig`）
  - `Core/`：通用基础设施（网络、缓存、错误、日志、路由、依赖注入）
  - `Services/`：业务服务（API Client、Repository、数据访问适配）
  - `Features/`：按功能分包（每包含 `Model/`, `View/`, `ViewModel/` 与可选 `Metrics/`）
  - `UIComponents/`：跨功能复用的 SwiftUI 组件
  - `Resources/`：图片、颜色、字体、`Localizable.strings` 等资源
  - `Tests/`：单元测试与 UI 测试，结构与 `Features/` 对齐

## 3. 代码风格
- 保持代码简洁、可读；以数据流为核心组织代码
- 命名清晰有意义：`FooView`、`FooViewModel`、`FooModel` 等后缀一致
- 视图不持有业务逻辑；业务放在 `ViewModel` 或 `Service/Repository`
- 使用文档注释（`///`）解释复杂逻辑与公共 API
- 并发与 UI 更新遵循 `@MainActor` 约束；耗时任务放后台
- 统一错误类型与错误边界；对用户展示的错误集中处理
- 资源与主题（颜色、字体）统一封装，避免散落常量
- 遵循官方 Swift 风格指南与 SwiftUI 最佳实践

## 4. 通用开发原则
- 在使用 agent 模式时，始终以「最小改动原则」改动代码
- 编写可测试的代码：`ViewModel` 与 `Service` 通过协议注入便于替身
- 避免重复代码（DRY 原则）；抽取共享组件与工具
- 优先使用原生 API 与 SPM，避免重复造轮子
- 依赖倒置：`ViewModel` 依赖抽象协议，不直接依赖具体实现
- 状态管理：根视图使用 `@StateObject`，子视图使用 `@ObservedObject`
- 环境注入：跨层共享使用 `@EnvironmentObject`，慎用且控制范围
- 数据边界明确：`Model` 与 `DTO` 分离，使用 `Mapper` 转换

## 5. Commit & 分支
- Commit Message：`<type>: <subject>`，type 取 `feat|fix|docs|style|refactor|test|chore`
- 分支模型：`main`（生产）、`develop`（预发）、`feature/*`、`hotfix/*`

## 6. 其他
- 所有新文件顶部必须包含文档注释说明用途与所属模块
- 大型功能请在 `docs/` 或 `README` 中补充设计说明
- 统一的路由与导航策略（深链、登录拦截等）需在 `Core/` 约束
- 国际化与可访问性（Dynamic Type、VoiceOver）作为必选项纳入验收
- 始终使用中文回复用户

description:
globs:
alwaysApply: true
---