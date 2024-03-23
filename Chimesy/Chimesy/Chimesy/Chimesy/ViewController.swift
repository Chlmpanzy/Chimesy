//
//  ViewController.swift
//  Chimesy
//
//  Created by Swift Admin on 2023-11-28.
// fundementals 435: segueys (for ui)
// scrubber

import UIKit
import SwiftUI
let darkGreen = UIColor(
    red: CGFloat(48) / 255.0,
    green: CGFloat(111) / 255.0,
    blue: CGFloat(29) / 255.0,
    alpha: 1.0
    )
class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var Grad: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let gradientView = gradientView {
            setupGradient(gradientView)
        }
    }
    func setupGradient(_ view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.red.cgColor, darkGreen.cgColor]  // Customize your gradient colors
        gradientLayer.locations = [0.0, 0.3]  // Customize the color distribution
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}




