//
//  ContentView.swift
//  Buttons
//
//  Created by YI BIN FENG on 2023/12/10.
//

import SwiftUI
import MediaPlayer
import AVFoundation

struct ContentView: View {
  // task 1
  // main logic
  // this is the only timer that runs as soon as app launches, it  checks every second to update UI, I have 3 date objects for timer A, B and C, once user tapps the start/pause button in details view for example timer A, I will check if the date(timerAStartDate) for timer A if its nil, if ture I will make the current date as timer A start date, if false I will re-set it to nil and save how much time timer A has been running in the past(timerAPassedDur), so if timer A gets re-started I will also add timerAPassedDur to get the total running time for timer A then use it to calculate the percentage of the timer A.
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  // start date for each timer
  @State private var timerAStartDate: Date?
  @State private var timerBStartDate: Date?
  @State private var timerCStartDate: Date?
  
  // current percentage for each timer
  @State private var timerAPercentage: Int = 0
  @State private var timerBPercentage: Int = 0
  @State private var timerCPercentage: Int = 0
  
  // after pause I save how much timer this timer has been running for each timer
  @State private var timerAPassedDur: TimeInterval = 0
  @State private var timerBPassedDur: TimeInterval = 0
  @State private var timerCPassedDur: TimeInterval = 0
  
  private let timerADur: Int = 60  // Timer A has a duration 60s from 0% to 100%
  private let timerBDur: Int = 90  // Timer B has a duration 90s from 0% to 100%
  private let timerCDur: Int = 120 // Timer C has a duration 120s from 0% to 100%
  
  // task 2
  @State private var darknessLevel: Double = 0.0 // set initial darkness level, darkness = 1 - brightness?
  @State private var systemVolume: Float = 0.5 // set initial value, can be any value between 0.0 and 1.0
  
  var body: some View {
    NavigationView {
      VStack {
        
        Spacer()

        // timer A
        NavigationLink(destination: DetailsView(selectedTimerStartDate: $timerAStartDate, passedDur: $timerAPassedDur, percentage: $timerAPercentage)) {
          TimerTextView("Timer A", timerAPercentage)
        }
        
        // timer B
        NavigationLink(destination: DetailsView(selectedTimerStartDate: $timerBStartDate, passedDur: $timerBPassedDur, percentage: $timerBPercentage)) {
          TimerTextView("Timer B", timerBPercentage)
        }
        
        NavigationLink(destination: DetailsView(selectedTimerStartDate: $timerCStartDate, passedDur: $timerCPassedDur, percentage: $timerCPercentage)) {
          TimerTextView("Timer C", timerCPercentage)
        }
        
        // added some spacers to move up the 3 timer buttons
        Spacer()
        Spacer()
        Spacer()
        
      }.onReceive(timer) { _ in
        // check timer A
        if let d = timerAStartDate {
          // get the total running timer for the timer
          let totalRunningTime = Int(Date().timeIntervalSince(d) + timerAPassedDur)
          // check the current percentage, if it's greater than or equal to 100 then just show 100
          timerAPercentage = (totalRunningTime*100/timerADur) >= 100 ? 100 : (totalRunningTime*100/timerADur)

          // task 2: screen darkness level
          updateScreenDarknessLevel()
        }
        
        // check timer B
        if let d = timerBStartDate {
          let totalRunningTime = Int(Date().timeIntervalSince(d) + timerBPassedDur)
          timerBPercentage = (totalRunningTime*100/timerBDur) >= 100 ? 100 : (totalRunningTime*100/timerBDur)

          // task 2: system volume
          updateSystemVolumeLevel()
        }
        
        // check timer C
        if let d = timerCStartDate {
          let totalRunningTime = Int(Date().timeIntervalSince(d) + timerCPassedDur)
          timerCPercentage = (totalRunningTime*100/timerCDur) >= 100 ? 100 : (totalRunningTime*100/timerCDur)
        }
        
        cancelTimer()
      }
    }
  }
  
  // once timer A,B,C percentage all reached 100% we need to cancel the timer
  private func cancelTimer() {
    if timerAPercentage == 100, timerBPercentage == 100 && timerCPercentage == 100 {
      timer.upstream.connect().cancel()
    }
  }
  
  // task 2 - When A timer greater than 20%, start matching the screen darkness level to timer A
  private func updateScreenDarknessLevel() {
    if timerAPercentage > 20 {
      // FIXME: darkness = 1 - brightness?
      let darknessLevel = 1 - (Double(timerAPercentage)/100.0 > 1 ? 1 : Double(timerAPercentage)/100.0)
      UIScreen.main.brightness = darknessLevel
    }
  }

  // task 2 - Matching B timer with Volume, system volume percentage = Timer B in seconds / 90s. eg. Timer B runs from 0s to 45s, system volume percentage is from 0% to 50%.
  private func updateSystemVolumeLevel() {
    var volume = (Float(timerBPercentage)/100.0) * Float(50)/Float(45)
    volume = volume > 1 ? 1 : volume
    MPVolumeView.setVolume(volume)
  }
}




