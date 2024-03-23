//
//  AddSong View.swift
//  Chimesy
//
//  Created by Swift Admin on 2024-01-16.
//

import UIKit
import SwiftUI

class AddSongViewController: YourViewController {
    @IBOutlet weak var addSongGrad: UIView!
    @IBOutlet weak var songName: UITextField!
    @IBOutlet weak var Length: UITextField!
    @IBOutlet weak var AddSong: UIButton!
    @IBOutlet weak var status: UILabel!
    
    
    override func viewDidLoad(){
        setupGradient(addSongGrad)
        status.isHidden = true
        songName.delegate = self
        Length.delegate = self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Dismiss the keyboard
        return true
    }

    
    @IBAction func chimeItIn(_ sender: Any) {
        if picked != true{
            showDocumentPicker()
        } else {
            var stat = newSong(name: songName.text!, songFile: convertedURL!, length: Int(Length.text!)!)
            if stat == false{
                status.text = "Something went wrong. Make sure Song name is unique!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.status.isHidden = true
                }
            } else {
                picked = false
            }
        }
    }
}
