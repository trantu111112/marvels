//
//  MarvelDetailProductViewController.swift
//  marvels
//
//  Created by Tu Tran on 24/12/2023.
//

import UIKit

class MarvelCharacterDetailViewController<T: Codable>: UIViewController {
    typealias T = MarvelResponse

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var comicsStack: UIStackView!
    @IBOutlet weak var seriesStack: UIStackView!
    @IBOutlet weak var storiesStack: UIStackView!
    @IBOutlet weak var comicsTitle: UILabel!
    @IBOutlet weak var seriesTitle: UILabel!
    @IBOutlet weak var storiesTitle: UILabel!

    var characterDetailModel: CharacterDetailViewModel<T>?

    init() {
        super.init(nibName: "MarvelDetailProductViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        Task {
            startShriming()
            await characterDetailModel?.fetchData()
            let model: MarvelResponse? = characterDetailModel?.caseTypeData()
            guard let thumbnaiModel =  model?.data?.results?.first?.thumbnail else {return}
            let urlString = thumbnaiModel.path.unwrapped() + "." + thumbnaiModel.extension.unwrapped()
            stopShriming()
            thumbnail.loadImage(from: urlString)
            setUpDetailList(data: model)
        }
    }

    func startShriming() {
        thumbnail.startShimmering()
        comicsStack.startShimmering()
        seriesStack.startShimmering()
        storiesStack.startShimmering()
        comicsTitle.startShimmering()
        seriesTitle.startShimmering()
        storiesTitle.startShimmering()
    }

    func stopShriming() {
        thumbnail.stopShimmering()
        comicsStack.stopShimmering()
        seriesStack.stopShimmering()
        storiesStack.stopShimmering()
        comicsTitle.stopShimmering()
        seriesTitle.stopShimmering()
        storiesTitle.stopShimmering()
        comicsTitle.text = "Comics"
        storiesTitle.text = "Stories"
        seriesTitle.text = "Series"
    }

    func setUpDetailList(data: MarvelResponse?) {
        guard let model = data?.data?.results?.first else { return }
        addLabelsToStack(items: model.comics?.items, stack: comicsStack)
        addLabelsToStack(items: model.series?.items, stack: seriesStack)
        addLabelsToStack(items: model.stories?.items, stack: storiesStack)
    }

    func addLabelsToStack(items: [MarvelItem]?, stack: UIStackView) {
        items?.forEach { item in
            let label = UILabel()
            label.heightAnchor.constraint(equalToConstant: 42).isActive = true
            label.textAlignment = .center
            label.numberOfLines = 3
            label.text = item.name
            stack.addArrangedSubview(label)
        }
    }

}
