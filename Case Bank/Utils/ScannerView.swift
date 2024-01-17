//
//  ScannerView.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import Foundation
import UIKit
import AVFoundation

class ScannerView: NSObject {
    
    private var xPosition: CGFloat = 0
    private var yPosition: CGFloat = 0
    private var boxHeight: CGFloat = 0
    private var boxWidth: CGFloat = 0
    
    private var captureSession: AVCaptureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    private let metadataOutput = AVCaptureMetadataOutput()
    
    var onError: ((Error) -> Void)?
    var onSuccess: ((String) -> Void)?
    
    override init() {
        super.init()
    }
    
    init(x: CGFloat, y: CGFloat, height: CGFloat, width: CGFloat, bounds: CGRect) {
        super.init()
        self.xPosition = x
        self.yPosition = y
        self.boxWidth = width
        self.boxHeight = height
        setupCaptureLayer(bounds: bounds)
    }
    
    
    private func setupCaptureLayer(bounds: CGRect) {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            onError?("failed configuration: AVCaptureDeviceInput".customError())
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            onError?("failed configuration: AVCaptureSession".customError())
            return
        }

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            
            onError?("failed configuration: AVCaptureMetadataOutput".customError())
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = bounds
        previewLayer.videoGravity = .resizeAspectFill
    }
    
}

extension ScannerView {
    func start() {
        if captureSession.isRunning == false {
            
            if boxWidth > 0 && boxHeight > 0 {
                metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: CGRect(x: xPosition, y: yPosition, width: boxWidth, height: boxHeight))
            }
            
            captureSession.commitConfiguration()
            captureSession.startRunning()
        }
    }
    
    func stop() {
        if captureSession.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer{
        return previewLayer
    }
}

extension ScannerView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            onSuccess?(stringValue)
        } else {
            onError?("gagal memperoleh hasil scan".customError())
        }
    }
    
}
