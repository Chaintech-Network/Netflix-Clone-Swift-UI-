//
//  Extensions.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 30/12/23.
//

import Foundation
import UIKit
import SwiftUI
import AVKit

extension String {
    func capitalizesFirst() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

extension CMTime {
    func toTimeString() -> String {
        let roundedSeconds = seconds.rounded()
        let hours: Int = Int(roundedSeconds / 3600)
        let min: Int = Int(roundedSeconds.truncatingRemainder(dividingBy: 3600) / 60)
        let sec: Int = Int(roundedSeconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, min , sec)
        }
        return String(format: "%02d:%02d", min , sec)
    }
    
}

extension View {
    func rect() -> CGRect {
        return UIScreen.main.bounds
    }
}

func isiPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}
