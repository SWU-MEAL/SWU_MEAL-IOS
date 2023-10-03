//
//  ThursViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/3/23.
//

import UIKit

final class ThursViewController: UIViewController {
    
    private let thursView = WeekdayView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(thursView)
        thursView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thursView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            thursView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thursView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            thursView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
