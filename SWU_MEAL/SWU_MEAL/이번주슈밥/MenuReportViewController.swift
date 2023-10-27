//
//  MenuReportViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/28.
//

import UIKit

final class MenuReportViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F6F6F6")
        
        return view
    }()
    
    private lazy var xmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var dateView = WhiteView(frame: .zero, height: 52.0)
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.textColor = UIColor(hex: "#606060")
        label.font = .systemFont(ofSize: 15.54)
        
        return label
    }()
    
    private lazy var dateChooseButton: UIButton = {
        let button = UIButton()
        button.setTitle("2023.09.20(수)", for: .normal)
        button.setTitleColor(UIColor(hex: "#191919"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.54)
        
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.preferredDatePickerStyle = .automatic
        
        return datePicker
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 26.0
        [
            dateLabel,
            datePicker
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var dateMenu: UIMenu = {
        let morningMenu = UIAction(title: "아침식사") { action in
            self.timeChooseButton.setTitle("아침식사", for: .normal)
        }
        
        let launchMenu = UIAction(title: "점심식사") { action in
            self.timeChooseButton.setTitle("점심식사", for: .normal)
        }
        
        let dinnerMenu = UIAction(title: "저녁식사") { action in
            self.timeChooseButton.setTitle("저녁식사", for: .normal)
        }
        
        let menuElement: [UIAction] = [
            morningMenu,
            launchMenu,
            dinnerMenu
        ]
        
        return UIMenu(title: "", children: menuElement)
    }()
    
    private lazy var timeView = WhiteView(frame: .zero, height: 52.0)
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = UIColor(hex: "#606060")
        label.font = .systemFont(ofSize: 15.54)
        
        return label
    }()
    
    private lazy var timeChooseButton: UIButton = {
        let button = UIButton()
        button.setTitle("점심식사", for: .normal)
        button.setTitleColor(UIColor(hex: "#191919"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.54)
        button.showsMenuAsPrimaryAction = true
        button.menu = dateMenu
        
        return button
    }()
    
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 26.0
        [
            timeLabel,
            timeChooseButton
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private let textFieldView = WhiteView(frame: .zero, height: 364.0)
    
    private lazy var reportTextView: UITextView = {
        let textView = UITextView()
        textView.text = "메뉴 이름, 가격 등 잘못된 정보를 알려주세요."
        textView.textColor = UIColor(hex: "#BCBCBC")
        textView.font = .systemFont(ofSize: 15.54)
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var reportButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10.0
        button.setTitle("신고하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
        button.backgroundColor = .reportUnActiveColor
        button.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapReportButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupNavigation()
        self.setupLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private extension MenuReportViewController {
    
    func setupNavigation() {
        self.navigationItem.hidesBackButton = true
        
        let customBackButtonItem = UIBarButtonItem(customView: xmarkButton)
        self.navigationItem.leftBarButtonItem = customBackButtonItem
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 16.0, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        self.navigationItem.title = "메뉴 정보 신고"
    }
    
    func setupLayout() {
        
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        [
            dateView,
            dateStackView,
            timeView,
            timeStackView,
            textFieldView,
            reportTextView,
            reportButton
        ].forEach { view.addSubview($0) }
        
        dateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            dateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            dateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0)
        ])
        
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateStackView.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 16.0),
            dateStackView.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
        ])
        
        timeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 14.0),
            timeView.leadingAnchor.constraint(equalTo: dateView.leadingAnchor),
            timeView.trailingAnchor.constraint(equalTo: dateView.trailingAnchor)
        ])
        
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeStackView.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 16.0),
            timeStackView.centerYAnchor.constraint(equalTo: timeView.centerYAnchor)
        ])
        
        reportTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reportTextView.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 20.0),
            reportTextView.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 16.0),
            reportTextView.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -23.0),
            reportTextView.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -20.0)
        ])
        
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 14.0),
            textFieldView.leadingAnchor.constraint(equalTo: dateView.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: dateView.trailingAnchor),
            textFieldView.bottomAnchor.constraint(equalTo: reportButton.topAnchor, constant: -110.0)
        ])
        
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            reportButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),
            reportButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
        ])
    }
    
    @objc func didTapReportButton() {
        let alert = UIAlertController(title: "", message: "신고가 완료되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { action in
            switch action.style{
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            case .default:
                self.navigationController?.popViewController(animated: true)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITextViewDelegate

extension MenuReportViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == UIColor(hex: "#BCBCBC") else {return }
        textView.text = nil
        textView.textColor  = .black
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textWithoutWhitespace = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if textWithoutWhitespace.isEmpty {
            self.reportButton.isEnabled = false
            self.reportButton.backgroundColor = .reportUnActiveColor
        } else {
            self.reportButton.isEnabled = true
            self.reportButton.backgroundColor = .reportActiveColor
        }
    }
}
