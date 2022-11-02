//
//  PushupTally.swift
//  WorkoutTracker
//
//  Created by John Critchlow on 11/2/22.
//

import Foundation

struct PushupTally: Identifiable, Codable {
    var id = UUID()
    var count: Int
    var date: Date
}

extension PushupTally {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
}

