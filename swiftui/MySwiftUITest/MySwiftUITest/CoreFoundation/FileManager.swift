//
//  FileManager.swift
//  MySwiftUITest
//
//  Created by zhihu on 27/12/2024.
//
//展示了如何在 SwiftUI 中结合使用 FileManager 和视图模型来实现基本的文件操作。通过这种方式，用户可以方便地管理本地存储的文本数据。

//功能说明
//  创建和保存文件：用户可以在 TextEditor 中输入文本，并通过点击“Save”按钮将其保存到本地文档目录中的 example.txt 文件。
//  加载文件：点击“Load”按钮可以从文件中读取内容并显示在文本编辑器中。
//  删除文件：点击“Delete”按钮会删除该文件并更新显示内容。
import SwiftUI

struct FileManagerView: View {
    @StateObject private var viewModel = FileManagerViewModel()

    var body: some View {
        VStack(spacing: 20) {
            TextEditor(text: $viewModel.fileContent)
                .border(Color.gray, width: 1)
                .padding()

            Button("Save") {
                viewModel.saveFile(content: viewModel.fileContent)
            }

            Button("Load") {
                viewModel.loadFile()
            }

            Button("Delete") {
                viewModel.deleteFile()
            }
        }
        .padding()
        .navigationTitle("File Manager")
    }
}

class FileManagerViewModel: ObservableObject {
    @Published var fileContent: String = ""
    private let fileName = "example.txt"

    // 获取文档目录路径
    private var fileURL: URL {
        //FileManager.default 获取系统的文件管理器实例
        //  urls(for: .documentDirectory, in: .userDomainMask) 获取应用的文档目录路径
        // .documentDirectory 指定要访问的是文档目录
        // .userDomainMask 表示在用户的 home 目录下搜索
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //.first! 获取返回的 URL 数组中的第一个 URL（因为文档目录只有一个，所以可以强制解包）
        //.appendingPathComponent(fileName) 在文档目录的 URL 后面添加文件名
            .first!.appendingPathComponent(fileName)
    }

    // 初始化时读取文件内容
    init() {
        loadFile()
    }

    // 写入文件内容
    func saveFile(content: String) {
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            loadFile()  // 更新内容
        } catch {
            print("Error saving file: \(error)")
        }
    }

    // 读取文件内容
    func loadFile() {
        do {
            fileContent = try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            fileContent = "No content found."
        }
    }

    // 删除文件
    func deleteFile() {
        do {
            try FileManager.default.removeItem(at: fileURL)
            fileContent = "No content found."
        } catch {
            print("Error deleting file: \(error)")
        }
    }
}

#Preview {
    FileManagerView()
}
