//
//  ButtonPadding.swift
//  Fandoor
//
//  Created by 목정아 on 2023/09/19.
//

import UIKit

class AutoAddPaddingButtton : UIButton {
    
    private var horizontalPadding: CGFloat = 0
    private var verticalPadding: CGFloat = 0
    
    init(hPadding: CGFloat, vPadding: CGFloat) {
        super.init(frame: CGRect.zero)
        
        self.horizontalPadding = hPadding
        self.verticalPadding = vPadding
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let baseSize = super.intrinsicContentSize
        let horizontalPadding: CGFloat = self.horizontalPadding
        let verticalPadding: CGFloat = self.verticalPadding
        return CGSize(
            width: baseSize.width + horizontalPadding,
            height: baseSize.height + verticalPadding)
    }
}

