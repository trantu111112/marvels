//
//  LoadingView.swift
//  marvels
//
//  Created by Tu Tran on 26/12/2023.
//

import SwiftUI
import UIKit

// extension for SwiftUI View
extension View {
    func loadingOverlay(isLoading: Bool, text: String = "Loading...") -> some View {
        ZStack {
            self
            if isLoading {
                VStack {
                    FancyLoadingView(mode: .big)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
            }
        }
    }
}

// extension for UIkit UIView
extension UIView {
    func startShimmering() {
        backgroundColor = .systemGray2
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.gray.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)

        let animation = CABasicAnimation(keyPath: "position.x")
        animation.byValue = self.bounds.size.width * 2
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.repeatCount = .infinity

        gradient.add(animation, forKey: "shimmerAnimation")

        self.layer.mask = gradient
    }

    func stopShimmering() {
        backgroundColor = .clear
        self.layer.mask = nil
    }
}
