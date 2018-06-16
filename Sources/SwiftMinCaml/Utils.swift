//
//  Utils.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/16.
//

extension Array where Element: Equatable {
    func containsOnly(_ element: Element) -> Bool {
        return self.contains { $0 != element }
    }
    
    func allTheSame() -> Bool {
        guard let first = self.first else {
            return true
        }
        return self.containsOnly(first)
    }
}
