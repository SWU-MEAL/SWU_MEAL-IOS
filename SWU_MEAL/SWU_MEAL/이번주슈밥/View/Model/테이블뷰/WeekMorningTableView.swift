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
    
    var b_itemsArray: [String]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
//                print("WeekmorningTableView Data : \(self?.b_itemsArray ?? [])")
            }
        }
    }
    
    var b_itemsCount: Int = 1 {
        didSet {
            DispatchQueue.main.async {
                self.heightAnchor.constraint(
                    equalToConstant: self.cellHeight * CGFloat(self.b_itemsCount) + (self.headerHeight * 2)
                ).isActive = true
            }
        }
    }

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
        return b_itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WeekTableViewCell.identifier,
            for: indexPath
        ) as? WeekTableViewCell else { return UITableViewCell() }
        
        if let item = b_itemsArray?[indexPath.row] {
            let model = TodayMealModel(content: item)
            cell.setup(model: model)
        }
        cell.selectionStyle = .none
        
        return cell
    }
}
