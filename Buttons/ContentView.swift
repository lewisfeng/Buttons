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
  
  @State private var start = false
  
  @State private var timer: Timer?

  @State var selectedTimerStartDate: Date?
  @State var timerAStartDate: Date?
  @State var timerBStartDate: Date?
  @State var timerAPercentage: Int = 0
  @State var timerBPercentage: Int = 0
  @State var timerAPassedDur: TimeInterval = 0
  @State var timerBPassedDur: TimeInterval = 0
  @State var timerADur: Int = 60
  @State var timerBDur: Int = 90
  @State var percentage: Int = 0
  @State var count: Int = 0
  
  @State private var selecterTimerDur: Int = 0
  @State private var selecterTimer: Timer?
  
  var body: some View {
    NavigationView {
      VStack {
          // Your main content here

        NavigationLink(destination: DetailsView(timer: $timer, timerDur: $timerADur, btnText: $buttonAText, selectedTimerStartDate: $timerAStartDate, passedDur: $timerAPassedDur, percentage: $timerAPercentage)) {
            // Button or any other view that triggers the navigation
          Text(self.buttonAText)
            .frame(width: 200, height: 50, alignment: .center)
            .border(Color.black, width: 1.5)
            .foregroundColor(.black)
            .padding()
        }
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
              let timePassed = Int(Date().timeIntervalSince(d))
              timerBPercentage = (timePassed*100/timerBDur) >= 100 ? 100 : (timePassed*100/timerBDur)
              
              buttonBText = "Timer B   \(timerBPercentage)%"
            }
          })
        }
      }
    }
  }
}

/*struct ContentView: View {
  @State var buttonAText: String = "Timer A    0%"
  @State var buttonBText: String = "Timer B    0%"
  
  @State private var start = false
  
  @State private var timer: Timer?

  @State var selectedTimerStartDate: Date?
  @State var timerAStartDate: Date?
  @State var timerBStartDate: Date?
  @State var timerAPercentage: Int = 0
  @State var timerBPercentage: Int = 0
  @State var timerAPassedDur: TimeInterval = 0
  @State var timerBPassedDur: TimeInterval = 0
  @State var timerADur: Int = 60
  @State var timerBDur: Int = 90
  @State var percentage: Int = 0
  @State var count: Int = 0
  
  @State private var selecterTimerDur: Int = 0
  @State private var selecterTimer: Timer?
       
   var body: some View {

     NavigationStack {
       VStack() {
         Button(action: {
           start = true
           selectedTimerStartDate = timerAStartDate
           selecterTimerDur = timerADur
         }) {
         Text(self.buttonAText)
           .frame(width: 200, height: 50, alignment: .center)
           .border(Color.black, width: 1.5)
           .foregroundColor(.black)
           .padding()
         }
         Button(action: {
           start = true
           selectedTimerStartDate = timerBStartDate
           selecterTimerDur = timerBDur
         }) {
         Text(self.buttonBText)
           .frame(width: 200, height: 50, alignment: .center)
           .border(Color.black, width: 1.5)
           .foregroundColor(.black)
           .padding()
         }
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
               let timePassed = Int(Date().timeIntervalSince(d))
               timerBPercentage = (timePassed*100/timerBDur) >= 100 ? 100 : (timePassed*100/timerBDur)
    
               buttonBText = "Timer B   \(timerBPercentage)%"
             }
           })
         }

         
       }.navigationDestination(isPresented: $start) {
  
         if selectedTimerStartDate == timerAStartDate {

           DetailsView(timer: $selecterTimer, timerDur: $selecterTimerDur, btnText: $buttonAText, selectedTimerStartDate: $timerAStartDate, passedDur: $timerAPassedDur, percentage: $timerAPercentage)
         } else {
           
           
           
           DetailsView(timer: $selecterTimer, timerDur: $selecterTimerDur, btnText: $buttonBText, selectedTimerStartDate: $timerBStartDate, passedDur: $timerBPassedDur, percentage: $timerBPercentage)
         }
         
       }
     }
      
   }
}
 */

struct DetailsView: View {
  @Environment(\.presentationMode) var presentationMode

  @Binding var timer: Timer?
  @Binding var timerDur: Int
  @Binding var btnText: String
  @Binding var selectedTimerStartDate: Date?
  @Binding var passedDur: TimeInterval
  @State var dur: Int = 0
  @Binding var percentage: Int
  
  var body: some View {
    VStack {
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
          .padding()
      }
      Text("\(percentage)%")
        .font(.largeTitle)

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

