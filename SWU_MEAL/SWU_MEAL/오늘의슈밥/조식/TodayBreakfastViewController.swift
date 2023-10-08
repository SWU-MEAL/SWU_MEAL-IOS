//
//  TodayBreakfastViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class TodayBreakfastViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        
        return view
    }()
    
    private let menuTableView = TodayBreakfastTableView(frame: .zero)
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F6F6F6")
        self.setupLayout()
    }
    
}

// MARK: - Extension

private extension TodayBreakfastViewController {
    
    func setupLayout() {
    
        [
            menuView,
            menuTableView
        ].forEach { view.addSubview($0) }
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -72.0)
        ])
        
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuTableView.centerYAnchor.constraint(equalTo: menuView.centerYAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
        ])
    }
    
}
