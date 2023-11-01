//
//  WeekTableViewCell.swift
//  SWU_MEAL
//
//  Created by 목정아 on 9/29/23.
//

import UIKit

final class WeekTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    private let deviceManager = DeviceManager()
    static let identifier = "WeekTableViewCell"
    
    // MARK: - Views

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "???"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(
            ofSize: deviceManager.calculateWeekDynamicFontSize(fontSize: 14.0)
        )
        
        return label
    }()

    
    func setup(content: String) {
        self.backgroundColor = .white
        self.setupLayout()
        self.contentLabel.text = content
    }
    
}

private extension WeekTableViewCell {
    
    func setupLayout() {
        addSubview(contentLabel)
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
