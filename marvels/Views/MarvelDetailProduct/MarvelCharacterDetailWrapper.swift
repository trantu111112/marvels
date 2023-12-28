//
//  MarvelDetailProductWrapper.swift
//  marvels
//
//  Created by Tu Tran on 24/12/2023.
//

import Foundation
import UIKit
import SwiftUI

struct MarvelCharacterDetailWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    var characterId: Int?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MarvelCharacterDetailWrapper>) -> UIViewController {
        let viewController = MarvelCharacterDetailViewController<MarvelResponse>()
        let viewmodel = CharacterDetailViewModel<MarvelResponse>()
        viewmodel.characterId = characterId
        //        viewmodel.delegate = AnyGenericDelegate(viewController)
        viewController.characterDetailModel = viewmodel

        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<MarvelCharacterDetailWrapper>) {
    }
    
}
