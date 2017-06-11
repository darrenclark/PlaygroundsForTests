//
//  DemoView.swift
//  PlaygroundsForTests
//
//  Created by Darren Clark on 2017-06-11.
//  Copyright © 2017 Darren Clark. All rights reserved.
//

import UIKit

class DemoView: UIView {
    let subview = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        subview.backgroundColor = .red
        addSubview(subview)
    }

    override func layoutSubviews() {
        subview.frame = bounds.insetBy(dx: 2.0, dy: 2.0)
    }
}
