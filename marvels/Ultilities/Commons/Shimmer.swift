//
//  Shimmer.swift
//  marvels
//
//  Created by Tu Tran on 26/12/2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func shimmer(_ config: ShimmerConfig) -> some View {
        self
            .modifier(ShimmerEffectHelper(config: config))
    }
}


fileprivate struct ShimmerEffectHelper: ViewModifier {
    var config: ShimmerConfig
    @State private var moveTo: CGFloat = -1
    func body(content: Content) -> some View {
        content
            .hidden()
            .overlay {
                Rectangle()
                    .fill(config.tint)
                    .mask {
                        content
                    }
                    .overlay {
                        GeometryReader {
                            let size = $0.size
                            Rectangle()
                                .fill(config.highlight)
                                .mask {
                                    Rectangle()
                                        .fill(.linearGradient(colors: [
                                            .white.opacity(0),
                                            config.highlight.opacity(config.highlightOpacity),
                                            .white.opacity(0)
                                        ], startPoint: .top, endPoint: .bottom))
                                        .blur(radius: config.blur)
                                        .rotationEffect(.init(degrees: 0))
                                        .offset(x: size.width * moveTo)
                                }
                        }
                    }
                    .onAppear {
                        moveTo = 1
                    }
                    .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
            }
    }
}

struct ShimmerConfig {
    var tint: Color
    var highlight: Color
    var blur: CGFloat = 0
    var highlightOpacity: CGFloat = 1
    var speed: CGFloat = 1
    
}


#Preview {
    Rectangle()
        .shimmer(.init(tint: .gray.opacity(0.3), highlight: .white, blur: 5))
}
