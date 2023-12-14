//
//  DetailsView.swift
//  Buttons
//
//  Created by YI BIN FENG on 2023/12/12.
//

import SwiftUI

struct DetailsView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var viewModel: TimerViewModel
  
  var body: some View {
    VStack {
      Spacer()
      
      Button(action: {
        viewModel.check()
      }) {
        TimerTextView("Start / Pause")
      }
      
      Spacer()
      
      Text("\(viewModel.percentage)%")
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
