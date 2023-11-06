//
//  TagButton.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/25.
//

import UIKit

protocol TagButtonProtocol: AnyObject {
    func didTapTagButton(buttonTag: UIButton)
}

final class TagButton: UIButton {
    
    private var title: String = "???"
    private weak var tagDelegate: TagButtonProtocol?

    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.title = title
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        self.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        self.layer.borderWidth = 1.2
        self.layer.cornerRadius = 16.0
        
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        self.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        self.setTitleColor(UIColor(hex: "#B3B3B3"), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 13.0)
        self.titleLabel?.numberOfLines = 0
        self.setTitle(title, for: .normal)
        self.addTarget(self, action: #selector(didTapTagButton), for: .touchUpInside)
    }

    func setDelegate(_ delegate: TagButtonProtocol?) {
        self.tagDelegate = delegate
      }
    
    @objc func didTapTagButton(buttonTag: UIButton) {
        self.tagDelegate?.didTapTagButton(buttonTag: self)
    }
}
