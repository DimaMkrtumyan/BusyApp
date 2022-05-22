//
//  Dictionary+Extension.swift
//  Busy
//
//  Created by Davit Muradyan on 28.12.21.
//

import Foundation
extension Dictionary {
    
    func passingQuery() -> String {
        var finalQueryForm = "?"
        for element in self {
            finalQueryForm.append("\(element.key)=\(element.value)&")
        }
        finalQueryForm.removeLast()
        return finalQueryForm
    }
}
