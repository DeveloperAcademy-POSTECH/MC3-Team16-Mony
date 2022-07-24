//
//  Encodable+Extension.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/20.
//

import Foundation

extension Encodable {
    var dictionary: [String:Any]? {
        guard let data = try? JSONEncoder().encode(self) else {return nil}
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap{ $0 as? [String:Any]}
    }
}
