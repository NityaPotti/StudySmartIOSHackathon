//
//  chooseMinutes.swift
//  SmartStudy
//
//  Created by Nitya Potti on 10/19/24.
//

import Foundation
import SwiftUI

struct chooseMinutes: View {
    @State private var minutes: String = "" // Handle minutes as a string for input
    @State private var tasks: String = ""
    @State private var showTimer = false // State to control navigation
    
    var body: some View {
        VStack {
            TextField("Enter how many minutes you would like to study", text: $minutes)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .foregroundColor(Color.pastelPurple)
                .padding()
                .border(Color.pastelPink)
            
            TextField("Enter the tasks you would like to complete during this timeframe. Please separate each task with a comma and space.", text: $tasks)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .foregroundColor(Color.pastelPurple)
                .padding()
                .border(Color.pastelPink)
            
            Button(action: {
                showTimer = true // Show the timer view when button is pressed
            }) {
                Text("Start Study")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.pastelPink)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding()
            .sheet(isPresented: $showTimer) {
                if let time = Double(minutes) {
                    timer(tasks: tasksToArray(tasks), timeLeft: time * 60, totalTime: time * 60) // Pass tasks array and time in seconds
                }
            }
        }
        .padding()
        .background(Color.pastelBackground) // Apply background color
    }
}


func tasksToArray(_ tasks: String) -> [Item] {
    let taskStrings = tasks.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        
        var taskList: [Item] = []
        for task in taskStrings {
            taskList.append(Item(id: UUID().uuidString, title: task, isDone: false))
        }
        
        return taskList
    
}

