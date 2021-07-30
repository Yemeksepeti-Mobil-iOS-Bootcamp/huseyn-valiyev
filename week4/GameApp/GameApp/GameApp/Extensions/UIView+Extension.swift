//
//  UIView+Extension.swift
//  GameApp
//
//  Created by Huseyn Valiyev on 20.07.2021.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
