//
//  FeedViewController.swift
//  iPrototype
//
//  Created by Jack on 1/28/18.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class FeedViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagesArray = [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image4"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image7")]
    let textArray = ["ПРАВИТЕЛЬСТВО США ХОЧЕТ ЗАСТАВИТЬ NASA ПРЕКРАТИТЬ ПОДДЕРЖКУ МКС К 2025 ГОДУ...", "Исследователи Национального сеульского института Южной Кореи создали простейших роботов, которым не требуется батареек и электричества для передвижения....", "Издание International Business Times проанализировало рентабельность майнинга в 115 странах и составила рейтинг, в котором на первом месте оказалась Венесуэла...", "Разработчики из калифорнийского стартапа Light Field Lab уже к концу 2018 года планируют выпустить первый рабочий прототип правдоподобной парящей в воздухе голограммы...", "Для большинства видов жизни во Вселенной кислород может быть смертельным ядом. Но, как ни странно, это может существенно упростить поиск таковой жизни...", "Как известно, есть на нашей планете существа, которые обладают невероятной способностью к регенерации, позволяющей отращивать потерянные конечности и восстанавливать органы. И многие ученые давно утверждают, что практически любой организм имеет такие же возможности — нужно лишь «включить» правильные гены. И недавно немецкие ученые из Института Макса Планка обнаружили такие гены...", "Глава компании SpaceX Илон Маск заявил через свою страничку в «Твиттере» о том, что первый запуск новой ракеты-носителя сверхтяжелого класса Falcon Heavy состоится 6 февраля..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDefaults()
    }

}

// MARK: - Private functions.

extension FeedViewController {
    
    private func configureDefaults() {
        // Collection view.
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: FeedCollectionCell.className, bundle: nil), forCellWithReuseIdentifier: FeedCollectionCell.className)
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
}

// MARK: - UICollectionViewDataSource.

extension FeedViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionCell.className, for: indexPath) as! FeedCollectionCell
        cell.text = self.textArray[indexPath.row]
        cell.image = self.imagesArray[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout.

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionViewLayout.finalizeCollectionViewUpdates()
        return FeedCollectionCell.cellSize(image: self.imagesArray[indexPath.row], text: self.textArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//MARK: - PINTEREST LAYOUT DELEGATE
extension FeedViewController : PinterestLayoutDelegate {
    
    // 1. Returns the photo height
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let cellSize = FeedCollectionCell.cellSize(image: self.imagesArray[indexPath.row], text: self.textArray[indexPath.row])
        return cellSize.height
    }
    
}
