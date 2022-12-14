//
//  Reactive+LongPressed.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/14.
//

import RxSwift
import UIKit
import RxCocoa

extension Reactive where Base: UITableView {
    func listLongPress<T>(_ type: T.Type) -> ControlEvent<(UITableViewCell, T)> {
        let longPressGesture = UILongPressGestureRecognizer()
        base.addGestureRecognizer(longPressGesture)
        let event = longPressGesture.rx.event
            .filter { $0.state == .began }
            .map { [weak base] in
                base?.indexPathForRow(at: $0.location(in: base))
            }
            .withUnretained(base)
            .flatMap { (base, indexPath) -> Observable<(UITableViewCell, T)> in
                guard let indexPath = indexPath,
                      let cell = base.cellForRow(at: indexPath) else {
                    return Observable.empty()
                }
                
                return Observable.zip(Observable.just(cell),
                                      Observable.just(try base.rx.model(at: indexPath)))
            }
        
        return ControlEvent(events: event)
    }
}
