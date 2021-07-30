//
//  ViewController.swift
//  BusTicket
//
//  Created by Huseyn Valiyev on 27.07.2021.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    required init?(coder: NSCoder) {
            super.init(coder: coder)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 1
        setupMiddleButton()
    }
        
    func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 33, y: -20, width: 60, height: 60))
        middleButton.setBackgroundImage(UIImage(named: "home"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
            
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(middleButtonAction), for: .touchUpInside)
        self.view.layoutIfNeeded()
        }
    
    @objc func middleButtonAction(sender: UIButton) {
        self.selectedIndex = 1
    }
    
}

