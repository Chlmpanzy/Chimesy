//
//  Mainview.swift
//  Chimesy
//
//  Created by Swift Admin on 2024-01-15.
//

import UIKit
import SwiftUI
var pausing = true
class Mainview: YourViewController {
    let audioPlayer = YourAudioPlayerClass()
    @IBOutlet weak var mainGrad: UIView!
    @IBOutlet weak var song1: UIButton!
    @IBOutlet weak var options: UIImageView!
    @IBOutlet weak var optionblock: UIImageView!
    @IBOutlet weak var fadeBackground: UIImageView!
    @IBOutlet weak var addSong: UIButton!
    @IBOutlet weak var Sleep: UIButton!
    @IBOutlet weak var songPlaying: UIButton!
    @IBOutlet weak var song6: UIButton!
    @IBOutlet weak var song5: UIButton!
    @IBOutlet weak var song4: UIButton!
    @IBOutlet weak var song3: UIButton!
    @IBOutlet weak var song2: UIButton!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var pause: UIImageView!
    
    @objc func optionsTapped() {
        optionsclicked()
        options.isHidden = true
    }
    @objc func fadeBackgroundTapped() {
        optionsback()
    }
    @objc func pauseTapped(){
        print("paused")
        audioPlayer.resumeOrPause(pausing)
    }
    override func viewWillAppear(_ animated: Bool) {
        setupGradient(mainGrad)
        optionsback()
        song1.setTitle("Placeholder", for: .normal)
        song1.setTitle(allSongs.first?.key, for: .normal)
        song2.setTitle("Placeholder", for: .normal)
        song3.setTitle("Placeholder", for: .normal)
        song4.setTitle("Placeholder", for: .normal)
        song5.setTitle("Placeholder", for: .normal)
        song6.setTitle("SONG NAME", for: .normal)
        
        
    }
    
    override func viewDidLoad() {
        
        setupGradient(mainGrad)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(optionsTapped))
        options.addGestureRecognizer(tapGesture)
        options.isUserInteractionEnabled = true
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(fadeBackgroundTapped))
        fadeBackground.addGestureRecognizer(tapGesture1)
        fadeBackground.isUserInteractionEnabled = true
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(pauseTapped))
        pause.addGestureRecognizer(tapGesture2)
        pause.isUserInteractionEnabled = true
        
    }

    
    @IBAction func song1Clicked(_ sender: Any) {
        if let songName = song1.titleLabel?.text, let song = allSongs[songName] {
            audioPlayer.playsingle(url: song.songFile!)
            song6.setTitle(allSongs.first?.key, for: .normal)
            song1.setTitle("Never", for: .normal)
            song2.setTitle("Gonna", for: .normal)
            song3.setTitle("Give", for: .normal)
            song4.setTitle("You", for: .normal)
            song5.setTitle("Up", for: .normal)
        } else {
            statLabel.isHidden = false
            statLabel.text = "You dont have any Songs"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.statLabel.isHidden = true
            }
        }
    }
    
    func optionsclicked(){
        statLabel.isHidden = true
        optionblock.isHidden = false
        Sleep.isHidden = false
        addSong.isHidden = false
        options.isHidden = true
        fadeBackground.isHidden = false
        fadeBackground.isUserInteractionEnabled = true
    }
    func optionsback(){
        statLabel.isHidden = true
        addSong.isHidden = true
        Sleep.isHidden = true
        optionblock.isHidden = true
        options.isHidden = false
        fadeBackground.isHidden = true
        fadeBackground.isUserInteractionEnabled = false
    }
}
