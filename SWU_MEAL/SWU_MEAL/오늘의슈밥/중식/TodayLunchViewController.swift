//
//  TodayLunchViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class TodayLunchViewController: UIViewController {
    
    // MARK: - Properties

    private let apiManager = APIManager()
    private let todayDate: String = APIManager().calculateTodayDate()
    
    // MARK: - Views
    
    private lazy var  customActivityIndicatorView: CustomActivityIndicatorView = {
        let indicator = CustomActivityIndicatorView()
        indicator.isHidden = true
        
        return indicator
    }()
    
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
    
    private var buttonBundle: [TagButton] = []
    
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
    
    private lazy var emptyView: EmptyTodayMealView = {
        let view = EmptyTodayMealView()
        view.isHidden = true
        
        return view
    }()

    private lazy var errorView: ServerErrorMealView = {
        let view = ServerErrorMealView()
        view.isHidden = true
        
        return view
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F6F6F6")
        self.setupLayout()
        self.buttonFunction()
        self.setupLunchServer(date: todayDate, type: "샬롬", corner: "한식")
        buttonBundle = [
            button1, 
            button2,
            button3,
            button4
        ]
    }
    
}

// MARK: - Extension

private extension TodayLunchViewController {

    func setupLayout() {
        [
            buttonStackView,
            menuView,
            launchTableView,
            emptyView,
            errorView,
            customActivityIndicatorView
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
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        customActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customActivityIndicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            customActivityIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customActivityIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customActivityIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
    func checkButtonTag(tag: Int) {
        for button in buttonBundle {
            if button.tag == tag {
                button.backgroundColor = .black
                button.setTitleColor(.white, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .semibold)
            } else {
                button.setTitleColor(UIColor(hex: "#B3B3B3"), for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .regular)
                button.backgroundColor = UIColor(hex: "#F6F6F6")
            }
        }
        
        switch tag {
        case 1001:
            self.setupLunchServer(date: todayDate, type: "샬롬", corner: "한식")
        case 1002:
            self.setupLunchServer(date: todayDate, type: "샬롬", corner: "일품")
        case 1003:
            self.setupLunchServer(date: todayDate, type: "샬롬", corner: "스낵")
        case 1004:
            self.setupLunchServer(date: todayDate, type: "교직원", corner: "")
        default:
            print("default")
        }
    }
    
    // MARK: - Func
    
    func showIndicator() {
        self.customActivityIndicatorView.startAnimating()
        self.customActivityIndicatorView.isHidden = false
    }
    
    func hideIndicator() {
        self.customActivityIndicatorView.stopAnimating()
        self.customActivityIndicatorView.isHidden = true
    }

     func showEmptyView() {
        self.emptyView.isHidden = false
     }

    func hideEmptyView() {
        self.emptyView.isHidden = true
    }
    
    func showErrorView() {
        self.errorView.isHidden = false
    }
    
    func hideErrorView() {
        self.errorView.isHidden = true
    }
    
    // MARK: - Helper

    /// 이번주 슈밥 - 중식 API
    private func setupLunchServer(date: String, type: String, corner: String) {
        self.showIndicator()
        apiManager.weekdayMealGetData(date: date, time: "중식") { [weak self] result in
            self?.hideIndicator()
            switch result {
            case .success(let weekMealModel):
                if let menuList = self?.apiManager.getLunchMenuListForDate(
                    date: date,
                    time: "중식",
                    type: type,
                    corner: corner,
                    weekMealModel: weekMealModel
                ) {
                    self?.hideErrorView()
                    self?.hideEmptyView()
                    self?.hideIndicator()
                    
                    self?.launchTableView.itemsArray = menuList.flatMap { $0.items }
                    self?.launchTableView.itemsCount = menuList.map { $0.items.count }.reduce(0, +)
                } else {
                    print("중식 메뉴 리스트를 찾을 수 없습니다.")
                    self?.showEmptyView()
                }
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
                self?.showErrorView()
            }
        }
    }
}

extension TodayLunchViewController: TagButtonProtocol {
    func didTapTagButton(buttonTag: UIButton) {
        self.checkButtonTag(tag: buttonTag.tag)
    }
}
