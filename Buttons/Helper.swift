//
//  Helper.swift
//  Buttons
//
//  Created by YI BIN FENG on 2023/12/12.
//

import MediaPlayer

//Update system volume
extension MPVolumeView {
  static func setVolume(_ volume: Float) {
    let volumeView = MPVolumeView()
    let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
      slider?.value = volume
    }
  }
}
