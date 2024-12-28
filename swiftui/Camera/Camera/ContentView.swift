//
//  ContentView.swift
//  Camera
//
//  Created by shanquan on 2024/12/28.
//

import SwiftUI
import AVFoundation


struct CameraView: UIViewControllerRepresentable {
    // 用于处理照片捕获的委托
    var photoDelegate: PhotoCaptureDelegate

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()

        // 1. 配置会话质量为高
        captureSession.sessionPreset = .high

        // 2. 获取后置摄像头设备
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("无法访问后置摄像头")
            return viewController
        }

        do {
            // 3. 将摄像头设备包装为输入
            let input = try AVCaptureDeviceInput(device: camera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                print("摄像头输入已添加")
            }

            // 4. 添加照片输出
            let photoOutput = AVCapturePhotoOutput()
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
                print("照片输出已添加")
            }

            // 5. 设置预览图层
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = viewController.view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            viewController.view.layer.addSublayer(previewLayer)
            print("预览图层已设置")

            // 6. 启动捕获会话
            DispatchQueue.global(qos: .userInitiated).async {
                captureSession.startRunning()
                print("捕获会话已启动")
            }

            // 将 photoOutput 传递给委托
            photoDelegate.photoOutput = photoOutput
        } catch {
            print("摄像头设置失败: \(error)")
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    var photoOutput: AVCapturePhotoOutput?

    // 捕获照片
    func capturePhoto() {
        print("准备捕获照片")
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }

    // 处理捕获的照片
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("照片处理失败: \(error)")
            return
        }

        // 将照片数据转换为 UIImage
        if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) {
            print("照片已捕获")
            // 保存照片到相册
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            print("照片已保存到相册")
        }
    }
}

struct ContentView: View {
    @State private var photoDelegate = PhotoCaptureDelegate()

    var body: some View {
        VStack {
            // 相机预览
            CameraView(photoDelegate: photoDelegate)
                .frame(height: 500)
                .edgesIgnoringSafeArea(.top)

            // 拍照按钮
            Button(action: {
                photoDelegate.capturePhoto()
            }) {
                Text("拍照")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
