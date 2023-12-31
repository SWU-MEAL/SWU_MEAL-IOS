//
//  TodayBreakfastTableViewCell.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/25.
//

import UIKit

final class TodayTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    private let deviceManager = DeviceManager()
    static let identifier = "TodayBreakfastTableViewCell"
    
    // MARK: - Views

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "???"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(
            ofSize: deviceManager.calculateTodayDynamicFontSize(fontSize: 18.0)
        )
        
        return label
    }()

    func setup(content: String) {
        self.backgroundColor = .white
        self.setupLayout()
        self.contentLabel.text = content
    }
    
}

private extension TodayTableViewCell {
    
    func setupLayout() {
        addSubview(contentLabel)
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}
