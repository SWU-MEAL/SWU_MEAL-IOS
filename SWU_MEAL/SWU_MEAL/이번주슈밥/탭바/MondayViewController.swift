//
//  MondayViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 9/30/23.
//

import UIKit

final class MondayViewController: UIViewController {
    
    private let mondayView = WeekdayView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(mondayView)
        mondayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mondayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            mondayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mondayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mondayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
