//
//  WhiteView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/28.
//

import UIKit

final class WhiteView: UIView {
    
    init(frame: CGRect, height: CGFloat) {
        super.init(frame: frame)
        
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.layer.cornerRadius = 10.0
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
