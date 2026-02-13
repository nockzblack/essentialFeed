//
//  UiView+TestHelpers.swift
//  EssentialApp
//
//  Created by Fer Benavides Rodriguez on 09/02/26.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.main.run(until: Date())
    }
}
