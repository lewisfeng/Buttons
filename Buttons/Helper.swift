//
//  Helper.swift
//  Buttons
//
//  Created by YI BIN FENG on 2023/12/12.
//

import MediaPlayer

class Helper {
  
  // task 2 - When A timer greater than 20%, start matching the screen darkness level to timer A
  static func updateScreenDarknessLevel(_ percentage: Int) {
    guard percentage > 20 else { return }
    
    // FIXME: darkness = 1 - brightness?
    let darknessLevel = 1 - (Double(percentage)/100.0 > 1 ? 1 : Double(percentage)/100.0)
    UIScreen.main.brightness = darknessLevel
  }
  
  // task 2 - Matching B timer with Volume, system volume percentage = Timer B in seconds / 90s. eg. Timer B runs from 0s to 45s, system volume percentage is from 0% to 50%.
  static func updateSystemVolumeLevel(_ percentage: Int) {
    guard percentage > 0 else { return }
    
    var volume = Float(percentage)/100.0
    volume = volume > 1 ? 1 : volume
    MPVolumeView.setVolume(volume)
  }
}


//Update system volume
extension MPVolumeView {
  static func setVolume(_ volume: Float) {
    let volumeView = MPVolumeView()
    let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
      slider?.value = volume
    }
  }
  
  static var volume: Float {
    do {
      try AVAudioSession.sharedInstance().setActive(true)
      return AVAudioSession.sharedInstance().outputVolume
    } catch {
      return 0
    }
  }
}
