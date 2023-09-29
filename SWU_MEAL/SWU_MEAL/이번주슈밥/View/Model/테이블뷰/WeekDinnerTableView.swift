//
//  WeekDinnerTableView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 9/29/23.
//

import UIKit

final class WeekDinnerTableView: UITableView {
    
    private let cellHeight: CGFloat = 32.0
    private let headerHeight: CGFloat = 26.0
    
    private let todayMeal: [TodayMealModel] = [
        TodayMealModel(content: "잡곡밥"),
        TodayMealModel(content: "된장샤브샤브국"),
        TodayMealModel(content: "돈육김치조림"),
        TodayMealModel(content: "옥수수맛살달걀찜"),
        TodayMealModel(content: "치커리사과초무침"),
        TodayMealModel(content: "그린샐러드"),
        TodayMealModel(content: "깍두기"),
    ]
    
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
            equalToConstant: cellHeight * CGFloat(todayMeal.count) + (headerHeight * 2)
        ).isActive = true
        
        self.register(
            WeekTableViewCell.self,
            forCellReuseIdentifier: WeekTableViewCell.identifier
        )
        
        let emptyHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: headerHeight))
        self.tableHeaderView = emptyHeaderView
        self.tableFooterView = emptyHeaderView
    }
    
}

extension WeekDinnerTableView: UITableViewDataSource {
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
