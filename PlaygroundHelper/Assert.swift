//
//  Assert.swift
//  PlaygroundsForTests
//
//  Created by Darren Clark on 2017-06-11.
//  Copyright © 2017 Darren Clark. All rights reserved.
//

import Foundation

public func Assert(_ condition: Bool, _ message: String) -> String {
    return condition == true ? "✅" : "❌"
}
