//
//  MarvelCharacterGrid.swift
//  marvels
//
//  Created by Tu Tran on 28/12/2023.
//

import SwiftUI

// MarvelCharacterGrid.swift

struct MarvelCharacterGrid: View {
    @Binding var characters: [MarvelCharacter]?
    @Binding var isHiddenNav: Bool
    var onCharacterSelected: (MarvelCharacter, Bool) -> Void

    let columns = [
        GridItem(.fixed(ScreenConstants.cardWidth)),
        GridItem(.fixed(ScreenConstants.cardWidth))
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(characters ?? [], id: \.id) { item in
                NavigationLink(
                    destination: MarvelCharacterDetailWrapper(characterId: item.id)
                        .navigationBarTitle(item.name.unwrapped())
                        .onAppear(perform: {
                            isHiddenNav = true
                        })
                        .onDisappear(perform: {
                            isHiddenNav = false
                        })
                ) {
                    VStack {
                        AsyncImage(url: URL(string: item.thumbnail.safelyUnwrapped.path.unwrapped() + "." + item.thumbnail.safelyUnwrapped.extension.unwrapped())) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .croppedToSize(CGSize(width: ScreenConstants.cardWidth, height: ScreenConstants.cardWidth))
                                    .scaledToFit()
                            default:
                                Rectangle()
                                    .frame(width: ScreenConstants.cardWidth, height: 200, alignment: .center)
                                    .shimmer(.init(tint: .gray.opacity(0.3), highlight: .white, blur: 5))
                            }
                        }
                        .cornerRadius(16)

                        Text("\(item.name.unwrapped())")
                            .frame(height: 56, alignment: .top)
                    }
                }
                .onAppear { onCharacterSelected(item, true) }
                .onDisappear {onCharacterSelected(item, false)}
                .tag(item.id)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden()
                .accessibilityIdentifier("\(String(describing: item.id))")
            }
        }
        .accessibilityIdentifier("MarvelCharacterGridView")
    }
}
