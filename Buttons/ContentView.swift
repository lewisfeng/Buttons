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
  
  @StateObject var viewModel_A = TimerViewModel(duration: 60)
  @StateObject var viewModel_B = TimerViewModel(duration: 90)
  @StateObject var viewModel_C = TimerViewModel(duration: 120)

  // task 2
  @State private var darknessLevel: Double = 0.0 // set initial darkness level, darkness = 1 - brightness?
  @State private var systemVolume: Float = 0.5 // set initial value, can be any value between 0.0 and 1.0
  
  var body: some View {
    NavigationView {
      VStack {
        
        Spacer()

        // timer A
        NavigationLink(destination: DetailsView(viewModel: viewModel_A)) {
          TimerTextView("Timer A", viewModel_A.percentage)
        }
        
        // timer B
        NavigationLink(destination: DetailsView(viewModel: viewModel_B)) {
          TimerTextView("Timer B", viewModel_B.percentage)
        }

        // timer C
        NavigationLink(destination: DetailsView(viewModel: viewModel_C)) {
          TimerTextView("Timer C", viewModel_C.percentage)
        }
        
        // added some spacers to move up the 3 timer buttons
        Spacer()
        Spacer()
        Spacer()
        
      }.onReceive(timer) { _ in
        calculate()
      }
    }
  }
  
  private func calculate() {
    viewModel_A.calculate()
    viewModel_B.calculate()
    viewModel_C.calculate()
    
    cancelTimer()
  }
  
  // once timer A,B,C percentage all reached 100% we need to cancel the timer
  private func cancelTimer() {
    if viewModel_A.percentage == 100 && 
       viewModel_B.percentage == 100 &&
       viewModel_C.percentage == 100 {
      
      timer.upstream.connect().cancel()
    }
  }
  
  // task 2 - When A timer greater than 20%, start matching the screen darkness level to timer A
  func updateScreenDarknessLevel(_ viewModel_A: TimerViewModel) {
    if viewModel_A.percentage > 20 {
      // FIXME: darkness = 1 - brightness?
      let darknessLevel = 1 - (Double(viewModel_A.percentage)/100.0 > 1 ? 1 : Double(viewModel_A.percentage)/100.0)
      UIScreen.main.brightness = darknessLevel
    }
  }

  // task 2 - Matching B timer with Volume, system volume percentage = Timer B in seconds / 90s. eg. Timer B runs from 0s to 45s, system volume percentage is from 0% to 50%.
  private func updateSystemVolumeLevel() {
    var volume = (Float(viewModel_B.percentage)/100.0) * Float(50)/Float(45)
    volume = volume > 1 ? 1 : volume
    MPVolumeView.setVolume(volume)
  }
}




