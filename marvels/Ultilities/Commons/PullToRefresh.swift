//
//  PullToRefresh.swift
//  marvels
//
//  Created by Tu Tran on 27/12/2023.
//

import SwiftUI

struct PullToRefresh: View {
    
    var coordinateSpaceName: String
    var onRefresh: ()->Void
    
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    FancyLoadingView()
                        .frame(width: ScreenConstants.screenWidth, height: 100)
                        .background(Color.gray.opacity(0.5))
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}
