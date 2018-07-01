//
//  Util.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/07/01.
//

import Foundation

extension Dictionary {
    func adding(key: Key, value: Value) -> Dictionary<Key, Value> {
        var d = self
        d[key] = value
        return d
    }
}
