//
//  Image+Extensions.swift
//  marvels
//
//  Created by Tu Tran on 25/12/2023.
//

import Foundation
import UIKit
import SwiftUI

extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            self.image = placeholder
            return
        }

        self.image = placeholder
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Error loading image from URL: \(url), error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self?.image = image
                }
            }
        }.resume()
    }
}

extension Image {
    func croppedToSize(_ size: CGSize) -> some View {
        GeometryReader { geometry in
            self
                .resizable()
                .scaledToFill()
                .frame(width: min(geometry.size.width, size.width), height: min(geometry.size.height, size.height))
                .clipped()
        }
    }
}
