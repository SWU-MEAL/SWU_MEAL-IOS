//
//  ThuesViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/3/23.
//

import UIKit

final class ThuesViewController: UIViewController {
    
    private let thuesView = WeekdayView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(thuesView)
        thuesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thuesView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            thuesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thuesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            thuesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
