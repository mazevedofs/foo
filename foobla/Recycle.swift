//
//  Recycle.swift
//  foobla
//
//  Created by Marina Azevedo on 16/08/19.
//  Copyright © 2019 Marina Azevedo. All rights reserved.
//

import UIKit

public protocol ReusableView: class {
    static var reuseIdentifier: String { get }
}
extension ReusableView where Self: UIView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }
private struct AssociatedObjectKey {
    static var registeredCells = "registeredCells"
}
extension UITableView {
    private var registeredCells: Set<String> {
        get {
            if objc_getAssociatedObject(self, &AssociatedObjectKey.registeredCells) as? Set<String> == nil {
                self.registeredCells = Set<String>()
            }
            return (objc_getAssociatedObject(self, &AssociatedObjectKey.registeredCells) as? Set<String>)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedObjectKey.registeredCells, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    private func register<T: UITableViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        if bundle.path(forResource: T.reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: T.reuseIdentifier, bundle: bundle)
            register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    private func register<T: UITableViewHeaderFooterView>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        if bundle.path(forResource: T.reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: T.reuseIdentifier, bundle: bundle)
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    public func recycle<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
        if self.registeredCells.contains(T.reuseIdentifier) == false {
            self.registeredCells.insert(T.reuseIdentifier)
            self.register(T.self)
        }
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error dequeuing cell with reuse identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    public func recycle<T: UITableViewCell>() -> T {
        if self.registeredCells.contains(T.reuseIdentifier) == false {
            self.registeredCells.insert(T.reuseIdentifier)
            self.register(T.self)
        }
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Error dequeuing cell with reuse identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    public func recycle<T: UITableViewHeaderFooterView>() -> T {
        if self.registeredCells.contains(T.reuseIdentifier) == false {
            self.registeredCells.insert(T.reuseIdentifier)
            self.register(T.self)
        }
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Error dequeuing cell with reuse identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

