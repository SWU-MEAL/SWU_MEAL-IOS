//
//  MondayViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 9/30/23.
//

import UIKit

final class MondayViewController: UIViewController {
    
    // MARK: - Properties
    
    private let apiManager = APIManager()
    private let selectedDate = APIManager().calculateDate(forDayOfWeek: 1)
    
    private weak var weekdayDelegate: WeekdayViewProtocol?
    private var selectedButtonIndex = 0
    
    private lazy var lunchButtonSet: [UIButton] = [
        self.lunchButton1,
        self.lunchButton2,
        self.lunchButton3,
        self.lunchButton4,
    ]
    
    // MARK: - Views
    
    private lazy var customActivityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.color = .mainGrayColor
        indicator.isHidden = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var morningLabel: UILabel = {
        let label = UILabel()
        label.text = "🌞 아침식사"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var morningTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "7:30 ~ 9:00"
        label.textColor = UIColor(hex: "#606060")
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        return label
    }()

    private lazy var morningStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        stackView.distribution = .fill
        [
            morningLabel,
            morningTimeLabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private let morningTableView = WeekMorningTableView()
    
    private lazy var lunchLabel: UILabel = {
        let label = UILabel()
        label.text = "🍚 점심식사"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var lunchTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "11:30 ~ 13:30"
        label.textColor = UIColor(hex: "#606060")
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        return label
    }()
    
    private lazy var lunchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        stackView.distribution = .fill
        [
            lunchLabel,
            lunchTimeLabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var lunchView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 260.0).isActive = true
        
        return view
    }()
    
    private lazy var lunchButton1: UIButton = {
        let button = UIButton()
        button.tag = 2001
        button.setTitleColor(.weekLunchActiveColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.setTitle("한식코너", for: .normal)
        
        return button
    }()
    
    private lazy var lunchButton2: UIButton = {
        let button = UIButton()
        button.tag = 2002
        button.setTitleColor(.weekLunchUnActiveColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.setTitle("일품코너", for: .normal)
        
        return button
    }()
    
    private lazy var lunchButton3: UIButton = {
        let button = UIButton()
        button.tag = 2003
        button.setTitleColor(.weekLunchUnActiveColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.setTitle("스낵코너", for: .normal)
        
        return button
    }()
    
    private lazy var lunchButton4: UIButton = {
        let button = UIButton()
        button.tag = 2004
        button.setTitleColor(.weekLunchUnActiveColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.setTitle("교직원", for: .normal)
        
        return button
    }()
    
    private lazy var lunchButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.heightAnchor.constraint(equalToConstant: 52.0).isActive = true
        [
            lunchButton1,
            lunchButton2,
            lunchButton3,
            lunchButton4
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var lunchLineView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1.28).isActive = true
        view.backgroundColor = UIColor(hex: "#DBDBDC").withAlphaComponent(0.5)
        
        return view
    }()
    
    private lazy var lunchIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#999999")
        view.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        view.widthAnchor.constraint(
            equalToConstant: UIScreen.main.bounds.size.width / 5.8
        ).isActive = true
        
        return view
    }()
    
    private let lunchTableView = WeekLunchTableView()
    
    private lazy var dinnerLabel: UILabel = {
        let label = UILabel()
        label.text = "🌙 저녁식사"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var dinnerTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "17:10 ~ 18:30"
        label.textColor = UIColor(hex: "#606060")
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        return label
    }()
    
    private lazy var dinnerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        stackView.distribution = .fill
        [
            dinnerLabel,
            dinnerTimeLabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private let dinnerTableView = WeekDinnerTableView()
    
//    private lazy var infoReportButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("메뉴 정보가 잘못되었나요?", for: .normal)
//        button.setTitleColor(UIColor(hex: "#606060"), for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .regular)
//        // button.addTarget(self, action: #selector(didTapInfoReport), for: .touchUpInside)
//
//        return button
//    }()
//    
    private lazy var b_emptyView: EmptyMealView = {
        let view = EmptyMealView()
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
        
        for button in lunchButtonSet {
            button.addTarget(self, action: #selector(didTapLunchButton(_ :)), for: .touchUpInside)
        }
        print(selectedDate)
        self.setupMorningServer(date: selectedDate)
        self.setupLunchServer(date: selectedDate, type: "샬롬", corner: "한식")
        self.setupDinnerServer(date: selectedDate)
    }
}

private extension MondayViewController {
    
    func setupLayout() {
        [
            morningStackView,
            morningTableView,
            lunchStackView,
            lunchView,
            lunchButtonStackView,
            lunchLineView,
            lunchIndicatorView,
            lunchTableView,
            dinnerStackView,
            dinnerTableView,
            // infoReportButton,
            b_emptyView,
            errorView,
            customActivityIndicatorView
        ].forEach { view.addSubview($0) }

        morningStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            morningStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90.0),
            morningStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0)
        ])
        
        morningTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            morningTableView.topAnchor.constraint(equalTo: morningStackView.bottomAnchor, constant: 15.0),
            morningTableView.leadingAnchor.constraint(equalTo: morningStackView.leadingAnchor),
            morningTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
        ])
        
        lunchStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lunchStackView.topAnchor.constraint(equalTo: morningTableView.bottomAnchor, constant: 36.0),
            lunchStackView.leadingAnchor.constraint(equalTo: morningStackView.leadingAnchor)
        ])
        
        lunchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lunchView.topAnchor.constraint(equalTo: lunchStackView.bottomAnchor, constant: 15.0),
            lunchView.leadingAnchor.constraint(equalTo: lunchStackView.leadingAnchor),
            lunchView.trailingAnchor.constraint(equalTo: morningTableView.trailingAnchor),
        ])
        
        lunchButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lunchButtonStackView.topAnchor.constraint(equalTo: lunchView.topAnchor),
            lunchButtonStackView.leadingAnchor.constraint(equalTo: lunchView.leadingAnchor),
            lunchButtonStackView.trailingAnchor.constraint(equalTo: lunchView.trailingAnchor)
        ])
        
        lunchLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lunchLineView.topAnchor.constraint(equalTo: lunchView.topAnchor, constant: 53.78),
            lunchLineView.leadingAnchor.constraint(equalTo: lunchView.leadingAnchor),
            lunchLineView.trailingAnchor.constraint(equalTo: lunchView.trailingAnchor)
        ])
        
        lunchIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lunchIndicatorView.leadingAnchor.constraint(equalTo: lunchLineView.leadingAnchor, constant: 8.0),
            lunchIndicatorView.centerYAnchor.constraint(equalTo: lunchLineView.centerYAnchor)
        ])
        
        lunchTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lunchTableView.topAnchor.constraint(equalTo: lunchLineView.bottomAnchor, constant: 17.0),
            lunchTableView.leadingAnchor.constraint(equalTo: lunchView.leadingAnchor),
            lunchTableView.trailingAnchor.constraint(equalTo: lunchView.trailingAnchor),
        ])

        dinnerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dinnerStackView.topAnchor.constraint(equalTo: lunchTableView.bottomAnchor, constant: 36.0),
            dinnerStackView.leadingAnchor.constraint(equalTo: morningStackView.leadingAnchor)
        ])
        
        dinnerTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dinnerTableView.topAnchor.constraint(equalTo: dinnerStackView.bottomAnchor, constant: 15.0),
            dinnerTableView.leadingAnchor.constraint(equalTo: dinnerStackView.leadingAnchor),
            dinnerTableView.trailingAnchor.constraint(equalTo: morningTableView.trailingAnchor),
        ])
        
//        infoReportButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            infoReportButton.topAnchor.constraint(equalTo: dinnerTableView.bottomAnchor, constant: 32.0),
//            infoReportButton.centerXAnchor.constraint(equalTo: dinnerTableView.centerXAnchor),
//        ])
        
        b_emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            b_emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            b_emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            b_emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            b_emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
    // MARK: - Func

    func setupIndiator(senderX: CGFloat) {
        self.lunchIndicatorView.frame.origin.x = senderX
        self.customActivityIndicatorView.setNeedsLayout()
    }
    
    func showIndicator() {
        self.customActivityIndicatorView.startAnimating()
        self.customActivityIndicatorView.isHidden = false
    }
    
    func hideIndicator() {
        self.customActivityIndicatorView.stopAnimating()
        self.customActivityIndicatorView.isHidden = true
    }

     func showEmptyView() {
        self.b_emptyView.isHidden = false
     }

    func hideEmptyView() {
        self.b_emptyView.isHidden = true
    }
    
    func showErrorView() {
        self.errorView.isHidden = false
    }
    
    func hideErrorView() {
        self.errorView.isHidden = true
    }
    
    // MARK: - @objc

    @objc func didTapInfoReport() {
        print("WeekdayView didTapInfoReport")
        self.weekdayDelegate?.didTapInfoReport()
    }
    
    @objc func didTapLunchButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            for button in self.lunchButtonStackView.arrangedSubviews as! [UIButton] {
                if button != sender {
                    button.setTitleColor(.weekLunchUnActiveColor, for: .normal)
                } else {
                    button.setTitleColor(.weekLunchActiveColor, for: .normal)
                }
            }
            self.view.layoutIfNeeded()
            self.lunchIndicatorView.frame.origin.x = sender.frame.origin.x + 32.0
        }
        
        if let corner = sender.titleLabel?.text {
            switch corner {
            case "한식코너":
                setupLunchServer(date: selectedDate, type: "샬롬", corner: "한식")
            case "일품코너":
                setupLunchServer(date: selectedDate, type: "샬롬", corner: "일품")
            case "스낵코너":
                setupLunchServer(date: selectedDate, type: "샬롬", corner: "스낵")
            case "교직원":
                setupLunchServer(date: selectedDate, type: "교직원", corner: "")
            default:
                print("nil")
            }
        }
    }

    // MARK: - Helper

    /// 이번주 슈밥 - 조식 API
    private func setupMorningServer(date: String) {
        
        self.showIndicator()
        
        apiManager.weekdayMealGetData(date: date, time: "조식") { [weak self] result in

            self?.hideIndicator()
            
            switch result {
            case .success(let weekMealModel):
                if let menuList = self?.apiManager.getMenuListForDate(
                    date: date,
                    time: "조식",
                    weekMealModel: weekMealModel
                ) {
                    self?.hideErrorView()
                    self?.hideEmptyView()
                    self?.hideIndicator()
                    
                    self?.morningTableView.b_itemsArray = menuList.flatMap { $0.items }
                    self?.morningTableView.b_itemsCount = menuList.map { $0.items.count }.reduce(0, +)
                } else {
                    print("아침 메뉴 리스트를 찾을 수 없습니다.")
                    self?.showEmptyView()
                }
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
                self?.showErrorView()
            }
        }
    }

    /// 이번주 슈밥 - 중식 API
    private func setupLunchServer(date: String, type: String, corner: String) {
        apiManager.weekdayMealGetData(date: date, time: "중식") { [weak self] result in
            switch result {
            case .success(let weekMealModel):
                if let menuList = self?.apiManager.getLunchMenuListForDate(
                    date: date,
                    time: "중식",
                    type: type,
                    corner: corner,
                    weekMealModel: weekMealModel
                ) {
                    self?.lunchTableView.itemsArray = menuList.flatMap { $0.items }
                    self?.lunchTableView.itemsCount = menuList.map { $0.items.count }.reduce(0, +)
                } else {
                    print("중식 메뉴 리스트를 찾을 수 없습니다.")
                }
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
            }
        }
    }

    /// 이번주 슈밥 - 석식 API
    private func setupDinnerServer(date: String) {
        apiManager.weekdayMealGetData(date: date, time: "석식") { [weak self] result in
            switch result {
            case .success(let weekMealModel):
                if let menuList = self?.apiManager.getMenuListForDate(
                    date: date,
                    time: "석식",
                    weekMealModel: weekMealModel
                ) {
                    self?.dinnerTableView.itemsArray = menuList.flatMap { $0.items }
                    self?.dinnerTableView.itemsCount = menuList.map { $0.items.count }.reduce(0, +)
                } else {
                    print("저녁 메뉴 리스트를 찾을 수 없습니다.")
                }
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
            }
        }
    }
}
