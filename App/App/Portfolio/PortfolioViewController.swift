
import UIKit
import Utils

class PortfolioViewController: UICollectionViewController {

    let eventHandler: PortfolioEventHandling
    init(eventHandler: PortfolioEventHandling){
        self.eventHandler = eventHandler
        super.init(collectionViewLayout: .init())
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    let refreshControl = UIRefreshControl()

    var imageUrls = [URL](){
        didSet{
            collectionView.reloadData()
        }
    }
}

// MARK: - Overrides
extension PortfolioViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        setupSubviews()
        title = "Rijksmuseum"
        collectionView.dataSource = self
        collectionView.delegate = self
        refreshControl.addTarget(self,
                                 action: #selector(didPullToRefresh),
                                 for: .valueChanged)
        eventHandler.didLoadView()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateCollectionViewLayout()
    }
}

// MARK: - UICollectionViewDataSource
extension PortfolioViewController {
    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = ImageViewCell.reuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId,
                                                      for: indexPath)
        guard let imageViewCell = cell as? ImageViewCell else {
            return cell
        }
        guard imageUrls.indices.contains(indexPath.row) else {
            return imageViewCell
        }
        imageViewCell.imageUrl = imageUrls[indexPath.row]
        return imageViewCell
    }
}

// MARK: - UICollectionViewDelegate
extension PortfolioViewController {
    override func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.5
    }

    override func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        eventHandler.didTapCell(atIndex: indexPath.row)
    }
}

extension PortfolioViewController: PortfolioDisplaying {
    func setIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading == true {
                self.refreshControl.beginRefreshingProgramatically()
            } else {
                self.refreshControl.endRefreshing()
            }
        }
    }

    func setImageUrls(_ imageUrls: [URL]) {
        DispatchQueue.main.async {
            self.imageUrls = imageUrls
        }
    }

    func displayErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true)
        }
    }
}

// MARK: - Private methods
private extension PortfolioViewController {

    func setupSubviews(){
        view.backgroundColor = UIColor(hex: "343537")
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        collectionView.alwaysBounceVertical = true
        collectionView.register(ImageViewCell.self,
                                forCellWithReuseIdentifier: ImageViewCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.edges(to: view)
    }

    func updateCollectionViewLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        let gutterSize = CGFloat(8)
        let cellSize = CGFloat(83.75)
        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
        flowLayout.minimumLineSpacing = CGFloat(gutterSize)
        flowLayout.minimumInteritemSpacing = CGFloat(gutterSize)
        flowLayout.sectionInset = UIEdgeInsets(top: gutterSize,
                                               left: gutterSize,
                                               bottom: gutterSize,
                                               right: gutterSize)
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
}

// MARK: - Selectors
@objc extension PortfolioViewController {
    func didPullToRefresh() {
        eventHandler.didPullToRefresh()
    }
}
