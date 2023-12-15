//
//  CustomTimerTextView.swift
//  Buttons
//
//  Created by YI BIN FENG on 2023/12/13.
//

import SwiftUI

struct TimerTextView: View {
  private let timer: String, percentage: Int?

  init(_ timer: String, _ percentage: Int? = nil) {
    self.timer = timer
    self.percentage = percentage
  }

  var body: some View {
    HStack {
      Text(timer)
      .frame(width: 230, height: 50, alignment: .center)
      .border(Color.black, width: 1.5)
      if let p = percentage {
        Text("\(p)%")
        .padding(.leading, -75)
      }
    }.padding(.bottom, 5)
     .foregroundColor(.black)
     .font(.system(size: 13, weight: .medium))
  }
}

class TimerViewModel: ObservableObject {
  @Published var date: Date? // start date
  @Published var runningTime: TimeInterval = 0 // the total running time before pause
  // - Timer A has a duration 60s from 0% to 100%
  // - Timer B has a duration 90s from 0% to 100%
  // - Timer C has a duration 120s from 0% to 100%
  @Published private(set) var duration: Int = 0
  
  @Published var percentage: Int = 0
  
  init(duration: Int) { // init with default value
    self.duration = duration
  }
  
  func check() { // when user tap Start/Pause button
    if date == nil {
      date = Date()
    } else {
      runningTime = Date().timeIntervalSince(date!)
      date = nil
    }
  }
  
  func calculate() { // calculate percentage
    guard let d = date else { return }
    // get the total running timer for the timer
    let totalRunningTime = Int(Date().timeIntervalSince(d) + runningTime)
    // check the current percentage, if it's greater than or equal to 100 then just show 100
    percentage = (totalRunningTime*100/duration) >= 100 ? 100 : (totalRunningTime*100/duration)
  }
}
