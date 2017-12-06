//
//  ShadowView.swift
//  BreakPoint
//
//  Created by Jacob Ahlberg on 2017-11-28.
//  Copyright © 2017 Jacob Ahlberg. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {

    func setupView() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }

}
