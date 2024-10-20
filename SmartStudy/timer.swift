import SwiftUI

struct timer: View {
    @State var tasks: [Item]
    
    @State var timeLeft: TimeInterval
    @State var totalTime: TimeInterval
    @State var isTimerRunning = true
    @State var showErrorMessage = false
    @State var timerClock = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    @Environment(\.scenePhase) var scenePhase // Detect app lifecycle changes

    var body: some View {
        VStack {
            
            List {
                ForEach(Array(tasks.enumerated()), id: \.element.id) { index, item in
                                    HStack {
                                        Text(item.title)
                                            .foregroundColor(Color.pastelPurple)
                                        Spacer()
                                        Button {
                                            tasks[index].isDone.toggle() // Toggle isDone state
                                        } label: {
                                            Image(systemName: item.isDone ? "checkmark.circle.fill" : "checkmark.circle")
                                        }
                                    }
                                }
            }
                
                    
                
            

            ZStack {
                if showErrorMessage {
                    Text("Hey! You exited the app while you were supposed to be studying...")
                        .foregroundColor(.red)
                        .font(.headline)
                        .padding()
                    
                } else {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 250, height: 250)
                        .overlay(Circle().stroke(Color.pastelPink, lineWidth: 25)) // Outer circle

                    Circle()
                        .fill(Color.clear)
                        .frame(width: 250, height: 250)
                        .overlay(
                            Circle().trim(from: 0.0, to: progress())
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 25,
                                        lineCap: .round,
                                        lineJoin: .round
                                    )
                                )
                                .foregroundColor(
                                    completed() ? Color.pastelPurple : Color.white
                                ).animation(.easeInOut(duration: 0.2))
                        )

                    Text("\(formatTime(time: timeLeft))")
                        .bold()
                        .font(.system(size: 60))
                        .foregroundColor(Color.pastelPurple) // Pastel Purple text
                        .onReceive(timerClock) { _ in
                            if isTimerRunning {
                                if timeLeft > 0 {
                                    timeLeft -= 0.1
                                } else {
                                    isTimerRunning = false
                                }
                            }
                        }
                }
            }
        }
        .padding()
        .background(Color.pastelBackground) // Pastel background color
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background || newPhase == .inactive {
                // If the app goes to background or becomes inactive (user switches apps), stop the timer
                isTimerRunning = false
                showErrorMessage = true
            }
        }
    }

    func formatTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%.2d:%.2d", minutes, seconds)
    }
    
    func progress() -> CGFloat {
            return CGFloat(totalTime - timeLeft) / CGFloat(totalTime)
        }
    
    func completed() -> Bool {
        return timeLeft <= 0
    }
}
extension Color {
    static let pastelPink = Color(red: 255/255, green: 182/255, blue: 193/255)
    static let pastelPurple = Color(red: 219/255, green: 112/255, blue: 247/255)
    static let pastelBackground = Color(red: 250/255, green: 240/255, blue: 245/255)
}
