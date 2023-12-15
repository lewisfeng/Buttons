//
//  TimerViewModelTests.swift
//  ButtonsTests
//
//  Created by YI BIN FENG on 2023/12/14.
//

import XCTest
@testable import Buttons

import MediaPlayer

class TimerViewModelTests: XCTestCase {
  func testTimerAPercentage() {
    
    let viewModel_A = TimerViewModel(duration: 60)
    
    // Timer A has a duration 60s from 0% to 100%
    
    // without pause
    // duration = 3s = 5%
    viewModel_A.date = Date() - 3
    viewModel_A.calculate()
    XCTAssertEqual(viewModel_A.percentage, 5)
    
    // duration = 30s = 50%
    viewModel_A.date = Date() - 30
    viewModel_A.calculate()
    XCTAssertEqual(viewModel_A.percentage, 50)
    
    // duration = 60s = 100%
    viewModel_A.date = Date() - 60
    viewModel_A.calculate()
    XCTAssertEqual(viewModel_A.percentage, 100)
    
    // duration > 60s = 100%
    viewModel_A.date = Date() - 100
    viewModel_A.calculate()
    XCTAssertEqual(viewModel_A.percentage, 100)

    // with pause
    viewModel_A.date = Date() - 1
    viewModel_A.runningTime = 2
    viewModel_A.calculate()
    XCTAssertEqual(viewModel_A.percentage, 5)
    
    viewModel_A.date = Date() - 15
    viewModel_A.runningTime = 15
    viewModel_A.calculate()
    XCTAssertEqual(viewModel_A.percentage, 50)
    
    viewModel_A.date = Date() - 35
    viewModel_A.runningTime = 25
    viewModel_A.calculate()
    XCTAssertEqual(viewModel_A.percentage, 100)
  }
  
  func testTimerBPercentage() {
    
    let viewModel_B = TimerViewModel(duration: 90)
    
    // Timer B has a duration 90s from 0% to 100%
    
    // without pause
    // duration = 9s = 10%
    viewModel_B.date = Date() - 9
    viewModel_B.calculate()
    XCTAssertEqual(viewModel_B.percentage, 10)
    
    // duration = 45s = 50%
    viewModel_B.date = Date() - 45
    viewModel_B.calculate()
    XCTAssertEqual(viewModel_B.percentage, 50)
    
    // duration = 90s = 100%
    viewModel_B.date = Date() - 90
    viewModel_B.calculate()
    XCTAssertEqual(viewModel_B.percentage, 100)
    
    // duration > 90s = 100%
    viewModel_B.date = Date() - 100
    viewModel_B.calculate()
    XCTAssertEqual(viewModel_B.percentage, 100)

    // with pause
    viewModel_B.date = Date() - 3
    viewModel_B.runningTime = 6
    viewModel_B.calculate()
    XCTAssertEqual(viewModel_B.percentage, 10)
    
    viewModel_B.date = Date() - 15
    viewModel_B.runningTime = 30
    viewModel_B.calculate()
    XCTAssertEqual(viewModel_B.percentage, 50)
    
    viewModel_B.date = Date() - 55
    viewModel_B.runningTime = 35
    viewModel_B.calculate()
    XCTAssertEqual(viewModel_B.percentage, 100)
  }
  
  func testTimerCPercentage() {
    
    let viewModel_C = TimerViewModel(duration: 120)
    
    // Timer C has a duration 120s from 0% to 100%
    
    // without pause
    // duration = 12s = 10%
    viewModel_C.date = Date() - 12
    viewModel_C.calculate()
    XCTAssertEqual(viewModel_C.percentage, 10)
    
    // duration = 60s = 50%
    viewModel_C.date = Date() - 60
    viewModel_C.calculate()
    XCTAssertEqual(viewModel_C.percentage, 50)
    
    // duration = 120s = 100%
    viewModel_C.date = Date() - 120
    viewModel_C.calculate()
    XCTAssertEqual(viewModel_C.percentage, 100)
    
    // duration > 120s = 100%
    viewModel_C.date = Date() - 121
    viewModel_C.calculate()
    XCTAssertEqual(viewModel_C.percentage, 100)

    // with pause
    viewModel_C.date = Date() - 3
    viewModel_C.runningTime = 9
    viewModel_C.calculate()
    XCTAssertEqual(viewModel_C.percentage, 10)
    
    viewModel_C.date = Date() - 15
    viewModel_C.runningTime = 45
    viewModel_C.calculate()
    XCTAssertEqual(viewModel_C.percentage, 50)
    
    viewModel_C.date = Date() - 85
    viewModel_C.runningTime = 35
    viewModel_C.calculate()
    XCTAssertEqual(viewModel_C.percentage, 100)
  }
  
  func testScreenDarknessLevel() {
    let viewModel_A = TimerViewModel(duration: 60)
    
    // When A timer greater than 20%, start matching the screen darkness level to timer A
    
    // less than or equal 20% screen darkness level should remain the same
    // duration = 3s = 5%
    viewModel_A.date = Date() - 3
    viewModel_A.calculate()
    Helper.updateScreenDarknessLevel(viewModel_A.percentage)
    let screenDarknessLevel_0 = UIScreen.main.brightness

    // duration = 12s = 20%
    viewModel_A.date = Date() - 12
    viewModel_A.calculate()
    Helper.updateScreenDarknessLevel(viewModel_A.percentage)
    let screenDarknessLevel_1 = UIScreen.main.brightness
    
//    print(screenDarknessLevel_0, screenDarknessLevel_1)
    
    XCTAssertEqual(screenDarknessLevel_0, screenDarknessLevel_1)
  }
  
  func testSystemVolumeLevel() {
    let contentView = ContentView()
    
    let viewModel_B = TimerViewModel(duration: 90)
    // Matching B timer with Volume, system volume percentage = Timer B in seconds / 90s. eg. Timer B runs from 0s to 45s, system volume percentage is from 0% to 50%.
    
    // duration = 9s = 10%
    viewModel_B.date = Date() - 9
    viewModel_B.calculate()
    Helper.updateSystemVolumeLevel(viewModel_B.percentage)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      XCTAssertEqual(viewModel_B.percentage, Int(MPVolumeView.volume * 100))
    }
    
    sleep(1)
    
    // duration = 45s = 50%
    viewModel_B.date = Date() - 45
    viewModel_B.calculate()
    Helper.updateSystemVolumeLevel(viewModel_B.percentage)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      XCTAssertEqual(viewModel_B.percentage, Int(MPVolumeView.volume * 100))
    }
    
    sleep(1)
    
    // duration = 90s = 100%
    viewModel_B.date = Date() - 90
    viewModel_B.calculate()
    Helper.updateSystemVolumeLevel(viewModel_B.percentage)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      XCTAssertEqual(viewModel_B.percentage, Int(MPVolumeView.volume * 100))
    }
  }
}

