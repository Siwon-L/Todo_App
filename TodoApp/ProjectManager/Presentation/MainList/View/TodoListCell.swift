//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import UIKit
import SnapKit

final class TodoListCell: UITableViewCell, CellIdentifiable {
    private let backgrandView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
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
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 30
    }
    
    private func configureLayout() {
        backgroundColor = .clear
        self.addSubview(backgrandView)
        backgrandView.addSubview(labelStackView)
        
        backgrandView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
        
        labelStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
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
