//
//  ViewController.swift
//  Videoke_Agora1
//
//  Created by Carter Rogers on 2/10/21.
//

import UIKit
import AgoraRtcKit

class ViewController: UIViewController {

    @IBOutlet weak var remoteView: UIView!
    @IBOutlet weak var localView: UIView!
    
    var agoraKit: AgoraRtcEngineKit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        initializeAgoraEngine()
        setupLocalVideo()
    }

    func initializeAgoraEngine() {
           agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "YourAPPID", delegate: self)
        }
    
    func setupLocalVideo() {
        agoraKit?.enableVideo()
        
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.view = localView
        videoCanvas.renderMode = .hidden
        
        agoraKit?.setupLocalVideo(videoCanvas)
        
    }
    func joinChannel(){
            agoraKit?.joinChannel(byToken: "YourToken", channelId: "YourChannelName", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
                print("Successfully joined channel \(channel)")
        })
    }
    
    func leaveChannel() {
            agoraKit?.leaveChannel(nil)
        localView.isHidden = true
        remoteView.isHidden = true
        }

    
    
    @IBAction func didTapHangUp(_ sender: Any) {
        leaveChannel()
    }
    
}

extension ViewController: AgoraRtcEngineDelegate {
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.uid = uid
            videoCanvas.renderMode = .hidden
            videoCanvas.view = remoteView
            // Sets the remote video view
            agoraKit?.setupRemoteVideo(videoCanvas)
        }
}
