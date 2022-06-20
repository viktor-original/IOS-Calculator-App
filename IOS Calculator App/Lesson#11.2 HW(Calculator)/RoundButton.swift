//
//  RoundButton.swift
//  Lesson#11.2 HW(Calculator)
//
//  Created by Viktor Krasilnikov on 27.04.22.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var roundButton: Bool = false {
        didSet{
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }


}
