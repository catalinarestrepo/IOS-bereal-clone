//
//  DateFormatter.swift
//  Bereal-clone
//
//  Created by Khiem Tran Le on 3/26/23.
//

import Foundation

extension DateFormatter {
    static var postFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
}
