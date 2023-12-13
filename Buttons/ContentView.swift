//
//  ContentView.swift
//  Buttons
//
//  Created by YI BIN FENG on 2023/12/10.
//

import SwiftUI

struct ContentView: View {
  // text that for each timer(button)
  @State var buttonAText: String = "Timer A    0%"
  @State var buttonBText: String = "Timer B    0%"
  @State var buttonCText: String = "Timer C    0%"
  
  // main logic
  // this is the only timer that runs as soon as app launches, it  checks every second to update UI, I have 3 date objects for timer A, B and C, once user tapps the start/pause button in details view for example timer A, I will check if the date(timerAStartDate) for timer A if its nil, if ture I will make the current date as timer A start date, if false I will re-set it to nil and save how much time timer A has been running in the past(timerAPassedDur), so if timer A gets re-started I will also add timerAPassedDur to get the total running time for timer A then use it to calculate the percentage of the timer A.
  @State private var timer: Timer?
  
  // start date for each timer
  @State var timerAStartDate: Date?
  @State var timerBStartDate: Date?
  @State var timerCStartDate: Date?
  
  // current percentage for each timer
  @State var timerAPercentage: Int = 0
  @State var timerBPercentage: Int = 0
  @State var timerCPercentage: Int = 0
  
  // after pause I save how much timer this timer has been running for each timer
  @State var timerAPassedDur: TimeInterval = 0
  @State var timerBPassedDur: TimeInterval = 0
  @State var timerCPassedDur: TimeInterval = 0
  
  @State var timerADur: Int = 60  // Timer A has a duration 60s from 0% to 100%
  @State var timerBDur: Int = 90  // Timer B has a duration 90s from 0% to 100%
  @State var timerCDur: Int = 120 // Timer C has a duration 120s from 0% to 100%
  
  var body: some View {
    NavigationView {
      VStack {
        
        Spacer()
        
        NavigationLink(destination: DetailsView(selectedTimerStartDate: $timerAStartDate, passedDur: $timerAPassedDur, percentage: $timerAPercentage)) {
          Text(buttonAText)
            .frame(width: 230, height: 50, alignment: .center)
            .border(Color.black, width: 1.5)
            .foregroundColor(.black)
            .padding(.bottom, 5)
        }
        
        NavigationLink(destination: DetailsView(selectedTimerStartDate: $timerBStartDate, passedDur: $timerBPassedDur, percentage: $timerBPercentage)) {
          Text(buttonBText)
            .frame(width: 230, height: 50, alignment: .center)
            .border(Color.black, width: 1.5)
            .foregroundColor(.black)
            .padding(.bottom, 5)
        }
        
        NavigationLink(destination: DetailsView(selectedTimerStartDate: $timerCStartDate, passedDur: $timerCPassedDur, percentage: $timerCPercentage)) {
          Text(buttonCText)
            .frame(width: 230, height: 50, alignment: .center)
            .border(Color.black, width: 1.5)
            .foregroundColor(.black)
            .padding(.bottom, 5)
        }
        
        // added some spacers to move up the 3 timer buttons
        Spacer()
        Spacer()
        Spacer()
        
      }.onAppear{
        // we only want to run the timer once
        if timer == nil {
          timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { t in
            
            if let d = timerAStartDate {
              // get the total running timer for the timer
              let timePassed = Int(Date().timeIntervalSince(d) + timerAPassedDur)
              // check the current percentage, if it's greater than or equal to 100 then just show 100
              timerAPercentage = (timePassed*100/timerADur) >= 100 ? 100 : (timePassed*100/timerADur)
              
              buttonAText = "Timer A   \(timerAPercentage)%"
            }
            
            if let d = timerBStartDate {
              let timePassed = Int(Date().timeIntervalSince(d) + timerBPassedDur)
              timerBPercentage = (timePassed*100/timerBDur) >= 100 ? 100 : (timePassed*100/timerBDur)
              
              buttonBText = "Timer B   \(timerBPercentage)%"
            }
            
            if let d = timerCStartDate {
              let timePassed = Int(Date().timeIntervalSince(d) + timerCPassedDur)
              timerCPercentage = (timePassed*100/timerCDur) >= 100 ? 100 : (timePassed*100/timerCDur)
              
              buttonCText = "Timer C   \(timerCPercentage)%"
            }
          })
        }
      }
    }
  }
}

struct DetailsView: View {
  @Environment(\.presentationMode) var presentationMode

  @Binding var selectedTimerStartDate: Date?
  @Binding var passedDur: TimeInterval
  @Binding var percentage: Int
  
  var body: some View {
    VStack {
      Spacer()
      
      Button(action: {
        if selectedTimerStartDate == nil {
          selectedTimerStartDate = Date()
        } else {
          passedDur += Date().timeIntervalSince(selectedTimerStartDate!)
          selectedTimerStartDate = nil
        }
      }) {
        Text("Start / Pause")
          .frame(width: 200, height: 50, alignment: .center)
          .border(Color.black, width: 1.5)
          .foregroundColor(.black)
          .padding(.bottom, 55)
      }
      
      Text("\(percentage)%")
        .font(.largeTitle)

      Spacer()
      Spacer()
      Spacer()
      Spacer()
      Spacer()
      Spacer()
      
      }
      // hide default back button
      .navigationBarBackButtonHidden(true)
      // add a toolbar item because we need to hide the arrow icon
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }) {
            Label("Back", image: "").foregroundColor(.black)
          }
        }
      }
    }
  }

