//
//  ContentView.swift
//  VideoRecod
//
//  Created by shanquan on 2024/12/29.
//
import SwiftUI
import AVFoundation
import Photos

struct CameraView: UIViewControllerRepresentable {
    // 用于处理视频录制的委托
    var videoDelegate: VideoRecordingDelegate

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

        // 3. 获取麦克风设备
        guard let microphone = AVCaptureDevice.default(for: .audio) else {
            print("无法访问麦克风")
            return viewController
        }

        do {
            // 4. 将摄像头设备包装为输入
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            if captureSession.canAddInput(cameraInput) {
                captureSession.addInput(cameraInput)
                print("摄像头输入已添加")
            }

            // 5. 将麦克风设备包装为输入
            let microphoneInput = try AVCaptureDeviceInput(device: microphone)
            if captureSession.canAddInput(microphoneInput) {
                captureSession.addInput(microphoneInput)
                print("麦克风输入已添加")
            }

            // 6. 添加视频输出
            let movieOutput = AVCaptureMovieFileOutput()
            if captureSession.canAddOutput(movieOutput) {
                captureSession.addOutput(movieOutput)
                print("视频输出已添加")
            }

            // 7. 设置预览图层
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = viewController.view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            viewController.view.layer.addSublayer(previewLayer)
            print("预览图层已设置")

            // 8. 启动捕获会话
            DispatchQueue.global(qos: .userInitiated).async {
                captureSession.startRunning()
                print("捕获会话已启动")
            }

            // 将 movieOutput 传递给委托
            videoDelegate.movieOutput = movieOutput
        } catch {
            print("摄像头设置失败: \(error)")
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

class VideoRecordingDelegate: NSObject, AVCaptureFileOutputRecordingDelegate {
    var movieOutput: AVCaptureMovieFileOutput?

    // 开始录制视频
    func startRecording() {
        print("准备开始录制视频")
        let outputPath = NSTemporaryDirectory() + "\(UUID().uuidString).mov" // 使用 UUID 生成唯一文件名
        let outputURL = URL(fileURLWithPath: outputPath)
        movieOutput?.startRecording(to: outputURL, recordingDelegate: self)
    }

    // 停止录制视频
    func stopRecording() {
        print("停止录制视频")
        movieOutput?.stopRecording()
    }

    // 处理录制完成的视频
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("视频录制失败: \(error)")
            return
        }

        print("视频录制完成，保存到: \(outputFileURL)")
        // 保存视频到相册
        saveVideoToPhotoLibrary(url: outputFileURL)
    }

    // 保存视频到相册
    private func saveVideoToPhotoLibrary(url: URL) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                }) { success, error in
                    if success {
                        print("视频已保存到相册")
                    } else if let error = error {
                        print("保存视频失败: \(error)")
                    }
                }
            } else {
                print("未授予相册写入权限")
            }
        }
    }
}

struct ContentView: View {
    @State private var videoDelegate = VideoRecordingDelegate()
    @State private var isRecording = false

    var body: some View {
        VStack {
            // 相机预览
            CameraView(videoDelegate: videoDelegate)
                .frame(height: 500)
                .edgesIgnoringSafeArea(.top)

            // 录制按钮
            Button(action: {
                if isRecording {
                    videoDelegate.stopRecording()
                } else {
                    videoDelegate.startRecording()
                }
                isRecording.toggle()
            }) {
                Text(isRecording ? "停止录制" : "开始录制")
                    .font(.title)
                    .padding()
                    .background(isRecording ? Color.red : Color.blue)
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
