//
//  WednsViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/3/23.
//

import UIKit

final class WednsViewController: UIViewController {
    
    private let wednView = WeekdayView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(wednView)
        wednView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wednView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            wednView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wednView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wednView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
