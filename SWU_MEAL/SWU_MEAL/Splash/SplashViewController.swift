//
//  SplashViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/10/23.
//

import UIKit
import AVKit
import AVFoundation

final class SplashViewController: UIViewController  {
    
    private let playerController = AVPlayerViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        playVideo()
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "SplashVideo.mp4", ofType:"mp4") else {
            debugPrint("splash.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.showsPlaybackControls = false
        playerController.player = player
        playerController.videoGravity = .resizeAspectFill
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Method , video is finished ")
        self.goNextScreen()
    }
    
    func goNextScreen() {
        let newViewController = TabBarController()
        let navigationController = UINavigationController(rootViewController: newViewController)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}
