//
//  FancyLoadingView.swift
//  marvels
//
//  Created by Tu Tran on 26/12/2023.
//

import Foundation
import SwiftUI

struct FancyLoadingView: View {
    enum Mode {
        case small
        case big
    }
    
    struct Config {
        let circleWidth: CGFloat
        let circleHeight: CGFloat
        let textSize: CGFloat
    }
    
    @State private var rotation: Double = 0
    private let config: Config
    
    init(mode: Mode = .small) {
        switch mode {
        case .small:
            config = Config(circleWidth: 25, circleHeight: 25, textSize: 20)
        case .big:
            config = Config(circleWidth: 50, circleHeight: 50, textSize: 40)
        }
    }
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.white, lineWidth: 5)
                .frame(width: config.circleWidth, height: config.circleHeight)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
            
            Text("Loading...")
                .font(.system(size: config.textSize)) // Use system font and adjust the size
                .foregroundColor(.cyan) // Change the text color to your preference
                .padding(.top, 20) // Adjust the top padding
                .padding(.horizontal, 40)
        }
        .onAppear {
            rotation = 360
        }
    }
}
