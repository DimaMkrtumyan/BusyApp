//
//  String+Extension.swift
//  Busy
//
//  Created by Davit Muradyan on 21.02.22.
//

import Foundation

extension String {
    var spacesRemoved: String {
        return self.filter({$0 != " "})
    }
}
