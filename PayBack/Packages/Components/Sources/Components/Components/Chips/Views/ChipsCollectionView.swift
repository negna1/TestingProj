
import UIKit

class ChipsCollectionView: UICollectionView {
    
    // MARK: Initalizers
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        contentInset = ChipsViewConstants.contentInset
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
        delaysContentTouches = false
        register(StandartChipsCollectionCell.self, forCellWithReuseIdentifier: "StandartTabCollectionCell")
        register(CheckBoxChipsCollectionCell.self, forCellWithReuseIdentifier: "CheckBoxTabCollectionCell")
        register(IconedChipsCollectionViewCell.self, forCellWithReuseIdentifier: "IconedChipsCollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

class ChipsCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        minimumInteritemSpacing = ChipsViewConstants.minimumSpacing
        scrollDirection = .horizontal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
