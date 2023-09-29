//
//  WeekTableViewCell.swift
//  SWU_MEAL
//
//  Created by 목정아 on 9/29/23.
//

import UIKit

final class WeekTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    static let identifier = "WeekTableViewCell"
    
    // MARK: - Views

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "???"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14.0)
        
        return label
    }()

    
    func setup(model: TodayMealModel) {
        self.backgroundColor = .white
        self.setupLayout()
        
        contentLabel.text = model.content
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
