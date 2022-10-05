//
//  CustomUISegmentControl.swift
//  CustomUIKit
//
//  Created by 이시원 on 2022/09/30.
//

import UIKit

import SnapKit

public final class CUISegmentControl: UISegmentedControl {
    private var completion: ((Int) -> Void)?
    public lazy var currentIndex: Int = selectedSegmentIndex {
        didSet {
            completion?(currentIndex)
            selectedSegmentIndex = currentIndex
            configureUI()
        }
    }
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        currentIndex = selectedSegmentIndex
        configureUI()
    }
    
    public func moveTo(_ xPoint: Double) {
        let point = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let width = point * 0.7
        let underlineFinalXPosition = point * CGFloat((Double(xPoint) + 0.5)) - width / 2
        self.underlineView.frame.origin.x = underlineFinalXPosition
    }
    
    public override init(items: [Any]?) {
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
    
    private func configureUI() {
        addSubview(underlineView)
        let point = UIScreen.main.bounds.width / CGFloat(self.numberOfSegments)
        let width = point * 0.7
        let height = 2.0
        let yPosition = self.bounds.size.height - height
        let xPosition = point * CGFloat((Double(self.selectedSegmentIndex) + 0.5)) - width / 2
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        
        UIView.animate(withDuration: 0.15) {
            self.underlineView.frame = frame
        }
    }
    
    public func setAction(_ action: @escaping (Int) -> Void) {
        completion = action
    }
    
    public func setUnderlineColor(_ color: UIColor) {
        underlineView.backgroundColor = color
    }
}
