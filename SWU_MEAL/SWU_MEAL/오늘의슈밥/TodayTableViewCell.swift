//
//  TodayBreakfastTableViewCell.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/25.
//

import UIKit

final class TodayTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    static let identifier = "TodayBreakfastTableViewCell"
    
    // MARK: - Views

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "???"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18.0)
        
        return label
    }()

    
    func setup(model: TodayMealModel) {
        self.backgroundColor = .white
        self.setupLayout()
        
        contentLabel.text = model.content
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
