//
//  Player2ViewController.swift
//  Samespace_iOS_Assignment
//
//  Created by Prasenjeet Pandagale on 09/04/24.
//

import UIKit
import AVFoundation

class Player2ViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var songSlider: UISlider!
    @IBOutlet var playPauseButton: UIButton!
    var player: AVPlayer?
    var song: Song?
    var currentIndex : Int?
    var playerTimeObserver: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = song?.name
        artistLabel.text = song?.artist
        if let song = song {
            playSong(with: song.url)
        } else {
            print("Error: Invalid song data")
        }
        // Setup song slider
        songSlider.minimumValue = 0
        songSlider.value = 0
        songSlider.addTarget(self, action: #selector(songSliderValueChanged(_:)), for: .valueChanged)
               
        // Add time observer to update slider value
        addPeriodicTimeObserver()

    }
    
    func addPeriodicTimeObserver() {
    // Add time observer to periodically update slider value
        playerTimeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 10), queue: DispatchQueue.main) { [weak self] time in
                guard let player = self?.player else { return }
        let currentTime = Float(CMTimeGetSeconds(time))
        let duration = Float(CMTimeGetSeconds(player.currentItem?.duration ?? CMTime.zero))
                
    // Update slider value
        self?.songSlider.value = currentTime / duration
    }
}
    
    func removePeriodicTimeObserver() {
            // Remove time observer
            if let player = player, let playerTimeObserver = playerTimeObserver {
                player.removeTimeObserver(playerTimeObserver)
                self.playerTimeObserver = nil
            }
        }
    func playSong(with url: String) {
        guard let url = URL(string: url) else {
            print("Error: Invalid URL string")
            return
        }
        player = AVPlayer(url: url)
        player?.play()
        
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        playPauseButton.bounds.size = CGSize(width: 80.0, height: 80.0)
        if let player = player {
            if player.rate == 0 {  // Player is currently paused
                print("Resuming song")
                player.play()
                playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            } else {  // Player is currently playing
                print("Pausing song")
                player.pause()
                playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            }
        } else {
            print("Error: Player is nil")
        }
    }
    
    @IBAction func backWardButtonTapped(_ sender: Any) {
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
    }
    
    @IBAction func songSliderValueChanged(_ sender: UISlider){
        guard let player = player else { return }
        let newTime = Double(sender.value) * CMTimeGetSeconds(player.currentItem?.duration ?? CMTime.zero)
        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1))
    }
}
