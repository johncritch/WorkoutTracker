//
//  WorkoutRecordView.swift
//  WorkoutTracker
//
//  Created by John Critchlow on 10/26/22.
//

import SwiftUI

struct WorkoutRecordView: View {
    
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    @State private var editMode: EditMode = .inactive
    @State private var showAddWorkoutModal = false
    
    var body: some View {
        NavigationStack {
            Form {
                totalBody
                individualWorkoutsBody
            }
            .navigationTitle("Workout Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showAddWorkoutModal = true
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                ToolbarItem {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddWorkoutModal) {
                AddWorkoutView(workoutViewModel: workoutViewModel, showAddWorkoutViewModal: $showAddWorkoutModal)
            }
            .environment(\.editMode, $editMode)
        }
    }
    var individualWorkoutsBody: some View {
        Section(header: Text("Individual Workouts")) {
            let workoutReports = workoutViewModel.workoutReports
            
            if workoutReports.count > 0 {
                List {
                    ForEach(workoutViewModel.workoutReports) { workoutReport in
                        HStack {
                            Text("\(workoutReport.formattedDate)")
                                .fontWeight(.semibold)
                                .fontWeight(.semibold)
                            Spacer()
                            EditableText(text: "\(workoutReport.count)",
                                         isEditing: editMode.isEditing,
                                         textAlignment: .trailing
                            ) { updatedText in
                                if let count = Int(updatedText) {
                                    workoutViewModel.update(count, for: workoutReport)
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach {
                            workoutViewModel.removeWorkoutReport(at: $0)
                        }
                    }
                }
            } else {
                Button {
                    showAddWorkoutModal = true
                } label: {
                    Label("Add your first workout", systemImage: "plus.circle")
                }
            }
        }
    }
    
    var totalBody: some View {
        Section {
            HStack {
                Text("Grand total push-ups").fontWeight(.semibold)
                Spacer()
                Text("\(workoutViewModel.totalCount)")
            }
            HStack {
                Text("Pushups that count for Kyle")
                    .fontWeight(.semibold)
                Spacer()
                Text("\(workoutViewModel.pushupsThatCount)")
            }
        }
    }
}

struct WorkoutRecordView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRecordView()
            .environmentObject(WorkoutViewModel())
    }
}
