//
//  DetailsView.swift
//  Buttons
//
//  Created by YI BIN FENG on 2023/12/12.
//

import SwiftUI

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
        TimerTextView("Start / Pause")
      }
      
      Spacer()
      
      Text("\(percentage)%")
        .font(.system(size: 30, weight: .bold))

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
            Text("Back").foregroundColor(.black)
          }
        }
      }
    }
  }
