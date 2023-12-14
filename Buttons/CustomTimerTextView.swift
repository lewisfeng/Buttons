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
