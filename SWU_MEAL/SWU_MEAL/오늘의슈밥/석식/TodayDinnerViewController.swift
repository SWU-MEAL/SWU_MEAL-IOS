//
//  TodayDinnerViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class TodayDinnerViewController: UIViewController {

    // MARK: - Views

    private lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        
        return view
    }()

    private let dinnerTableView = TodayDinnerTableView(frame: .zero)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F6F6F6")
        self.setupLayout()
    }
}

// MARK: - Extension

private extension TodayDinnerViewController {

    func setupLayout() {
        [
            menuView,
            dinnerTableView
        ].forEach { view.addSubview($0) }
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -72.0)
        ])
        
        dinnerTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dinnerTableView.centerYAnchor.constraint(equalTo: menuView.centerYAnchor),
            dinnerTableView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            dinnerTableView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
        ])
    }
}
