//
//  WeekdayView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/27.
//

import UIKit

final class WeekdayView: UIView {
    
    // MARK: - Views

    private lazy var morningLabel: UILabel = {
        let label = UILabel()
        label.text = "🌞 아침식사"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var morningTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "7:30-9:00"
        label.textColor = UIColor(hex: "#606060")
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        return label
    }()
    
    private lazy var morningView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 220.0).isActive = true
        
        return view
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
      super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
}
