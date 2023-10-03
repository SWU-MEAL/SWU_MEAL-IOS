//
//  FriViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/3/23.
//

import UIKit

final class FriViewController: UIViewController {
    
    private let fridayView = WeekdayView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(fridayView)
        fridayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fridayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            fridayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fridayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fridayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
