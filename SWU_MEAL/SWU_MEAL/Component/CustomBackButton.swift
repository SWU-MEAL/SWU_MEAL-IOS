//
//  CustomBackButton.swift
//  Fandoor
//
//  Created by 목정아 on 2023/09/08.
//

import UIKit

protocol BackButtonProtocol: AnyObject {
    func didTapBackButton()
}

final class CustomBackButton: UIButton {
    
    private weak var delegate : BackButtonProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        setImage(UIImage(named: "Back")?
            .resize(to: CGSize(width: 31.0, height: 31.0)), for: .normal)
        addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()
    }
    
    func setDelegate(_ delegate: BackButtonProtocol?) {
        self.delegate = delegate
    }
}
