//: Playground - noun: a place where people can play

import UIKit
@testable import AppUI
import PlaygroundHelper

// EDIT: ./edit AppUI/DemoView.swift AppUI.playground


test("view is configured properly") {
    let demoView = DemoView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

    Assert(demoView.subview.backgroundColor == UIColor.red, "is a red dot")
}
