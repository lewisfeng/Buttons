//
//  ContentView.swift
//  Buttons
//
//  Created by YI BIN FENG on 2023/12/10.
//

import SwiftUI

struct ContentView: View {
  @State var buttonAText: String = "Timer A    0%"
  @State var buttonBText: String = "Timer B    0%"
  @State var buttonCText: String = "Timer C    0%"
  
  @State private var timer: Timer?
  
  @State var timerAStartDate: Date?
  @State var timerBStartDate: Date?
  @State var timerCStartDate: Date?
  @State var timerAPercentage: Int = 0
  @State var timerBPercentage: Int = 0
  @State var timerCPercentage: Int = 0
  @State var timerAPassedDur: TimeInterval = 0
  @State var timerBPassedDur: TimeInterval = 0
  @State var timerCPassedDur: TimeInterval = 0
  @State var timerADur: Int = 60
  @State var timerBDur: Int = 90
  @State var timerCDur: Int = 120
  
  @State private var selecterTimerDur: Int = 0
  @State private var selecterTimer: Timer?
  
  var body: some View {
    NavigationView {
      VStack {
        
        Spacer()
        
        NavigationLink(destination: DetailsView(timerDur: $timerADur, btnText: $buttonAText, selectedTimerStartDate: $timerAStartDate, passedDur: $timerAPassedDur, percentage: $timerAPercentage)) {
          // Button or any other view that triggers the navigation
          Text(self.buttonAText)
            .frame(width: 230, height: 50, alignment: .center)
            .border(Color.black, width: 1.5)
            .foregroundColor(.black)
            .padding(.bottom, 5)
        }
        
        NavigationLink(destination: DetailsView(timerDur: $timerBDur, btnText: $buttonBText, selectedTimerStartDate: $timerBStartDate, passedDur: $timerBPassedDur, percentage: $timerBPercentage)) {
          // Button or any other view that triggers the navigation
          Text(self.buttonBText)
            .frame(width: 230, height: 50, alignment: .center)
            .border(Color.black, width: 1.5)
            .foregroundColor(.black)
            .padding(.bottom, 5)
        }
        
        NavigationLink(destination: DetailsView(timerDur: $timerCDur, btnText: $buttonCText, selectedTimerStartDate: $timerCStartDate, passedDur: $timerCPassedDur, percentage: $timerCPercentage)) {
          // Button or any other view that triggers the navigation
          Text(self.buttonCText)
            .frame(width: 230, height: 50, alignment: .center)
            .border(Color.black, width: 1.5)
            .foregroundColor(.black)
            .padding(.bottom, 5)
        }
        
        
        Spacer()
        Spacer()
        Spacer()
        
      }.onAppear{
        if timer == nil {
          print("timer started")
          timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { t in
            
            if let d = timerAStartDate {
              let timePassed = Int(Date().timeIntervalSince(d) + timerAPassedDur)
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

  @Binding var timerDur: Int
  @Binding var btnText: String
  @Binding var selectedTimerStartDate: Date?
  @Binding var passedDur: TimeInterval
  @State var dur: Int = 0
  @Binding var percentage: Int
  
  var body: some View {
    VStack {
      Spacer()
      
      Button(action: {
        print("\nbutton clicked")
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
      
      }.onAppear{

        print("DetailsView")
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

