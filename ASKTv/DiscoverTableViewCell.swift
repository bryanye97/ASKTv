//
//  DiscoverTableViewCell.swift
//  ASKTv
//
//  Created by Bryan Ye on 11/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit
import AVFoundation

class DiscoverTableViewCell: UITableViewCell {
    
    var videoAnswer: VideoAnswer?
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    
    @IBOutlet weak var videoImageView: UIImageView!
    
//    lazy var playButton: UIButton = {
//        let button = UIButton(type: UIButtonType.System)
//        button.setTitle("Play Video", forState: .Normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        let image = UIImage(named: "play")
//        button.tintColor = UIColor.whiteColor()
//        button.setImage(image, forState: .Normal)
//        
//        button.addTarget(self, action: #selector(handlePlay), forControlEvents: .TouchUpInside)
//        return button
//    }()
    
    func handlePlay() {
        print("Played video")
        guard let videoAnswer = videoAnswer else { return }
        let videoUrl = URL(string: videoAnswer.videoUrl)
        guard let url = videoUrl else { return }
        let player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.contentView.bounds
        self.contentView.layer.addSublayer(playerLayer)
        
        player.play()
    }
    @IBAction func playButtonTapped(_ sender: AnyObject) {
        handlePlay()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        videoImageView.layer.cornerRadius = 10
        
//        videoImageView.addSubview(playButton)
//        //x,y,w,h
//        playButton.centerXAnchor.constraintEqualToAnchor(videoImageView.centerXAnchor).active = true
//        playButton.centerYAnchor.constraintEqualToAnchor(videoImageView.centerYAnchor).active = true
//        playButton.widthAnchor.constraintEqualToConstant(50).active = true
//        playButton.heightAnchor.constraintEqualToConstant(50).active = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
