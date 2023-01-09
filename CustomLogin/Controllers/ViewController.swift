//
//  ViewController.swift
//  CustomLogin
//
//  Created by Admin on 08/01/23.
//

import UIKit
import AVKit


class ViewController: UIViewController {
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    override func viewWillAppear(_ animated: Bool) {
        //setup video for bckgrnd
       setUpView()
    }
    func setUpElements() {
        
        Utilities.styleFilledButton(loginButton)
        Utilities.styleHollowButton(signUpButton)
        
    }
    func setUpView() {
        
        //get the path of resources
        
        let bundlePath = Bundle.main.path(forResource: "logingbg", ofType: "mp4")
        guard bundlePath != nil else {
            return
        }
        //create url from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        //create vieo player item
        
        let item = AVPlayerItem(url: url)
        //create layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //adjust size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.width*4, height: self.view.frame.height)
        
//        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.width*4, height: self.view.frame.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        
    }

}

