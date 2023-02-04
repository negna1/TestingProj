
import UIKit

public protocol ChipsViewDelegate: AnyObject {
    func activeTabChanged(to index: Int)
}

public class ChipsView: UIView {

    private var presenter: ChipsViewPresenter!
    private weak var delegate: ChipsViewDelegate?
    private var shouldCenterSelectedItem: Bool = true
    private var indexChanged: ((Int) -> Void)?
    private let height: CGFloat = 50
    
    private lazy var collectionView: ChipsCollectionView = {
        let collection = ChipsCollectionView(frame: .zero, collectionViewLayout: ChipsCollectionViewLayout())
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    public init(model: ChipsViewModel) {
        super.init(frame: .zero)
        delegate = model.delegate
        shouldCenterSelectedItem = model.centerSelectedItem
        indexChanged = model.didChangeIndex
        setup()
        configurePresenter(with: model.dataSource)
    }
    
    public init(delegate: ChipsViewDelegate? = nil) {
        super.init(frame: .zero)
        self.delegate = delegate
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configurePresenter(with dataSource: [ChipsCellViewModel]) {
        presenter = ChipsViewPresenterImpl(dataSource: dataSource, view: self)
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        height(equalTo: self.height)
        addSubview(collectionView)
        collectionView.left(toView: self)
        collectionView.right(toView: self)
        collectionView.top(toView: self)
        collectionView.bottom(toView: self)
    }
    
}
// MARK: - Public Functions
extension ChipsView {
    @available(*, deprecated, message: "Use configure(viewModel: ) function instead")
    public func set(model: ChipsViewModel) {
        configurePresenter(with: model.dataSource)
        delegate = model.delegate
        setup()
    }
    
    public func configure(viewModel: ChipsViewModel) {
        configurePresenter(with: viewModel.dataSource)
        indexChanged = viewModel.didChangeIndex
        delegate = viewModel.delegate
        setup()
    }
    @available(*, deprecated, message: "Use configure(with dataSource: ) function instead")
    public func setDataSource(_ dataSource: [ChipsCellViewModel]) {
        self.configurePresenter(with: dataSource)
    }
    
    public func configure(with dataSource: [ChipsCellViewModel]) {
        self.configurePresenter(with: dataSource)
    }
}

// MARK: - TabComponentView
extension ChipsView: ChipsViewProtocol {
    func reloadData(from indexPath: IndexPath?) {
        collectionView.reloadData()
        guard let indexPath = indexPath,
              shouldCenterSelectedItem == true else { return }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func reloadItem(at indexPath: IndexPath) {
        if shouldCenterSelectedItem {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - CollectionView DataSource
extension ChipsView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = presenter.cellId(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChipsViewCollectionCell
        presenter.configure(cell: cell, at: indexPath)
        return cell
    }
}

// MARK: - CollectionView Delegate
extension ChipsView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.activeTabChanged(to: indexPath.row)
        indexChanged?(indexPath.row)
        presenter.didSelectItem(at: indexPath)
    }
}

// MARK: - Flow Layout Delegate Methods
extension ChipsView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_  : UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter.sizeForCell(at: indexPath)
    }
}
