//
//  UnderLineSegmentedControl.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/20.
//

import UIKit

final class UnderLineSegmentedControl: UISegmentedControl {
    private var completion: ((Int, Int) -> Void)?
    private lazy var currentIndex: Int = selectedSegmentIndex {
        didSet {
            if currentIndex != oldValue {
                completion?(oldValue, currentIndex)
            }
        }
    }
    
    private lazy var underlineView: UIView = {
        let point = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let width = point * 0.7
        let height = 2.0
        let xPosition = point * CGFloat((Double(self.selectedSegmentIndex) + 0.5)) - width / 2
        let yPosition = self.bounds.size.height - height
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = .systemBlue
        addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let point = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let width = point * 0.7
        let underlineFinalXPosition = point * CGFloat((Double(self.selectedSegmentIndex) + 0.5)) - width / 2
        currentIndex = selectedSegmentIndex
        UIView.animate(withDuration: 0.1) {
            self.underlineView.frame.origin.x = underlineFinalXPosition
        }
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 0
        removeBackgroundAndDivider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        backgroundColor = .clear
        selectedSegmentTintColor = .clear
        setBackgroundImage(image, for: .normal, barMetrics: .default)
        setDividerImage(
            image,
            forLeftSegmentState: .normal,
            rightSegmentState: .normal,
            barMetrics: .default
        )
    }
    
    func setAction(_ action: @escaping (Int, Int) -> Void) {
        completion = action
    }
    
    func setUnderlineColor(_ color: UIColor) {
        underlineView.backgroundColor = color
    }
}
