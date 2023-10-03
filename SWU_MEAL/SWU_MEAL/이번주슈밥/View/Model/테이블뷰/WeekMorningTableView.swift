//
//  WeekMorningTableView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 9/29/23.
//

import UIKit

final class WeekMorningTableView: UITableView {

    // MARK: - Properties

    private let cellHeight: CGFloat = 32.0
    private let headerHeight: CGFloat = 26.0

    private let todayMeal: [TodayMealModel] = [
        TodayMealModel(content: "미니밥"),
        TodayMealModel(content: "잔치국수"),
        TodayMealModel(content: "메밀전병"),
        TodayMealModel(content: "비엔나케찹조림"),
        TodayMealModel(content: "그린샐러드"),
        TodayMealModel(content: "오징어무생채"),
        TodayMealModel(content: "배추김치"),
    ]

    // MARK: - init

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        self.backgroundColor = .white
        self.isScrollEnabled = false
        self.separatorStyle = .none
        self.layer.cornerRadius = 10.0
        self.rowHeight = cellHeight
        self.heightAnchor.constraint(
            equalToConstant: cellHeight * CGFloat(todayMeal.count) + (headerHeight * 2)
        ).isActive = true
        self.dataSource = self
        
        self.register(
            WeekTableViewCell.self,
            forCellReuseIdentifier: WeekTableViewCell.identifier
        )
        
        let emptyHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: headerHeight))
        self.tableHeaderView = emptyHeaderView
        self.tableFooterView = emptyHeaderView
    }
    
}

extension WeekMorningTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayMeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeekTableViewCell.identifier,
            for: indexPath
        ) as? WeekTableViewCell else { return UITableViewCell() }
        
        let model = todayMeal[indexPath.row]
        cell.setup(model: model)
        cell.selectionStyle = .none
        
        return cell
    }
}
