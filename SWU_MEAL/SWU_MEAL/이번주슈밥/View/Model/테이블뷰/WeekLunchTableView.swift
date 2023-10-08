//
//  WeekLunchTableView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 9/29/23.
//

import UIKit

final class WeekLunchTableView: UITableView {
    
    // MARK: - Properties

    private let cellHeight: CGFloat = 32.0
    private let footerHeight: CGFloat = 26.0
    
    private let todayMeal: [TodayMealModel] = [
        TodayMealModel(content: "중식풍쇠고기볶음밥"),
        TodayMealModel(content: "얼큰콩나물국"),
        TodayMealModel(content: "탕수육&후르츠S"),
        TodayMealModel(content: "볶음짬뽕"),
        TodayMealModel(content: "단무지부추무침"),
        TodayMealModel(content: "그린샐러드")
    ]
    
    var l_itemsArray: [String]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
                print("WeekLunchTableView Data : \(self?.l_itemsArray ?? [])")
            }
        }
    }
    
    var l_itemsCount: Int = 1 {
        didSet {
           
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.dataSource = self
        self.isScrollEnabled = false
        self.backgroundColor = .white
        self.separatorStyle = .none
        self.layer.cornerRadius = 10.0
        self.rowHeight = cellHeight
        self.heightAnchor.constraint(
            equalToConstant: (cellHeight * CGFloat(6.5)) + footerHeight
        ).isActive = true
        self.register(
            WeekTableViewCell.self,
            forCellReuseIdentifier: WeekTableViewCell.identifier
        )
        let emptyHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: footerHeight))
        self.tableFooterView = emptyHeaderView
    }
    
}

extension WeekLunchTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return l_itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeekTableViewCell.identifier,
            for: indexPath
        ) as? WeekTableViewCell else { return UITableViewCell() }
        
        if let item = l_itemsArray?[indexPath.row] {
            let model = TodayMealModel(content: item)
            cell.setup(model: model)
        }
        cell.selectionStyle = .none
        
        return cell
    }
}
