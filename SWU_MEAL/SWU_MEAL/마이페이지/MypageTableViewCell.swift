//
//  MypageTableViewCell.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/26.
//

import UIKit

final class MypageTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MypageTableViewCell"

    // MARK: - Views

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.text = "???"

        return label
    }()

    func setup(model: MypageModel) {
        self.setupLayout()
        self.accessoryType = .disclosureIndicator
        self.title.text = model.title
    }
}

private extension MypageTableViewCell {

    func setupLayout() {
        [
            title,
        ].forEach { addSubview($0) }
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0)
        ])
        
    }

}
