//
//  TodayLunchViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class TodayLunchViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        
        return view
    }()
    
    private let button1 = TagButton(frame: .zero, title: "한식코너")
    private let button2 = TagButton(frame: .zero, title: "일품코너")
    private let button3 = TagButton(frame: .zero, title: "스낵코너")
    private let button4 = TagButton(frame: .zero, title: "교직원")
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4.0
        stackView.distribution = .fillEqually
        [
            button1,
            button2,
            button3,
            button4
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private let launchTableView = TodayLunchTableView(frame: .zero)
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F6F6F6")
        self.setupLayout()
        self.buttonFunction()
    }
}

// MARK: - Extension

private extension TodayLunchViewController {

    func setupLayout() {
        [
            buttonStackView,
            menuView,
            launchTableView
        ].forEach { view.addSubview($0) }

        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
        ])

        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 27.0),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -72.0)
        ])

        launchTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            launchTableView.centerYAnchor.constraint(equalTo: menuView.centerYAnchor),
            launchTableView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            launchTableView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
        ])
    }

    func buttonFunction() {
        self.button1.setDelegate(self)
        self.button2.setDelegate(self)
        self.button3.setDelegate(self)
        self.button4.setDelegate(self)

        self.button1.tag = 1001
        self.button2.tag = 1002
        self.button3.tag = 1003
        self.button4.tag = 1004
        
        self.button1.backgroundColor = .black
        self.button1.setTitleColor(.white, for: .normal)
        self.button1.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .semibold)
    }
}

extension TodayLunchViewController: TagButtonProtocol {
    func didTapTagButton(buttonTag: UIButton) {
        switch buttonTag.tag {
        case 1001:
            print("button1")
        case 1002:
            print("button2")
        case 1003:
            print("button3")
        case 1004:
            print("button4")
        default:
            print("ERROR")
        }
    }
}
