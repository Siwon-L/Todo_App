//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import UIKit
import SnapKit

final class TodoListCell: UITableViewCell, CellIdentifiable {
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel, deadlineLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .systemGray2
        label.numberOfLines = 3
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(8)
        }
    }
}

extension TodoListCell {
    func setContent(item: ContentCellItem) {
        titleLabel.text = item.title
        bodyLabel.text = item.body
        deadlineLabel.text = item.deadlineAt
        deadlineLabel.textColor = item.isPast ? .systemRed : .label
    }
}
