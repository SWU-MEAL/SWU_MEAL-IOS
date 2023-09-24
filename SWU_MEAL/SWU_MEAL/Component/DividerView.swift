//
//  DividerView.swift
//  Fandoor
//
//  Created by 목정아 on 2023/09/11.
//

import UIKit

final class DividerView: UIView {
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(hex: "#F6F6F6")
        
        return separator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: topAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
