//
//  WorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by John Critchlow on 10/26/22.
//

import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var model = PushupModel()
    
    var totalCount: Int {
        model.pushupTallies.reduce(0) { runningTotal, pushupTally in
            return runningTotal + pushupTally.count
        }
    }
    
    var workoutReports: [PushupTally] {
        model.pushupTallies
    }
    
    func createNew(_ workoutReport: PushupTally) {
        model.append(workoutReport)
    }
    
    func removeWorkoutReport(at index: Int) {
        model.removePushupTally(at: index)
    }
}
