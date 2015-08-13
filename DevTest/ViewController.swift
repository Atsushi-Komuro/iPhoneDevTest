//
//  ViewController.swift
//  sousa
//
//  Created by Misato Morino on 2015/08/13.
//  Copyright (c) 2015年 Atsushi Komuro. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    //セッション
    var CapSession : AVCaptureSession!
    //デバイス
    var CapDevice : AVCaptureDevice!
    //画像アウト
    var ImageOut : AVCaptureStillImageOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CapSession = AVCaptureSession()
        let devices = AVCaptureDevice.devices()
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                CapDevice = device as! AVCaptureDevice
            }
        }
        
        //VideoInputを取得、セッションに追加
        do{
            let videoInput = try AVCaptureDeviceInput(device: CapDevice)
            CapSession.addInput(videoInput)
        }catch{
            
        }
        
        //出力先を生成
        ImageOut = AVCaptureStillImageOutput()
        
        //セッションに追加
        CapSession.addOutput(ImageOut)
        
        //画像を表示するレイヤーを生成
        let videoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: CapSession!) as AVCaptureVideoPreviewLayer
        
        videoLayer.frame = self.view.bounds
        videoLayer.videoGravity = AVLayerVideoGravityResizeAspect
        
        // Viewに追加
        self.view.layer.addSublayer(videoLayer)
        
        //セッション開始
        CapSession.startRunning()
        
        
    }
}