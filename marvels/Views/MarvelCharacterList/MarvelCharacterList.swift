//
//  MarvelProductList.swift
//  marvels
//
//  Created by Tu Tran on 23/12/2023.
//

import SwiftUI

struct MarvelCharacterList: View {
    @StateObject var marvelModel = CharacterListViewModel()
    @State var isHiddenNav = false

    var body: some View {
        NavigationView {
            ScrollView {
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                    marvelModel.getCharacterList(isRefesh: true)
                }
                if marvelModel.characterList != nil {
                    MarvelCharacterGrid(characters: $marvelModel.characterList) { character, isDisplayed  in
                        marvelModel.updateDisplayedList(character, isDisplayed: isDisplayed)
                    }
                }
            }
            .accessibilityIdentifier("MarvelCharacterScrollView")
            .coordinateSpace(name: "pullToRefresh")
        }

        .navigationTitle("Marvel Heroes")
        .navigationBarHidden(isHiddenNav)
        .onAppear(perform: {
            isHiddenNav = false
        })
        .loadingOverlay(isLoading: marvelModel.isLoadingData)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .accessibilityIdentifier("MarvelCharacterNavigationViewId")
    }
}

#Preview {
    MarvelCharacterList()
}
