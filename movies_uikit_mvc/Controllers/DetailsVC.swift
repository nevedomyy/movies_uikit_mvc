import UIKit

class DetailsVC: UIViewController {
    private let apiProvider: ApiProvider
    private let detailsView: DetailsView
    private let id: Int
    
    init(apiProvider: ApiProvider, detailsView: DetailsView, id: Int) {
        self.apiProvider = apiProvider
        self.detailsView = detailsView
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.errorButton.addTarget(self, action: #selector(fetchDetails), for: .touchUpInside)
        view = detailsView
        
        fetchDetails()
    }
    
    @objc private func fetchDetails(){
        detailsView.loaderView()
        apiProvider.fetchDetails(id: id){ [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.fetchImg(path: data.backdropPath)
                    self?.detailsView.successView(
                        title: data.title,
                        raiting: "\(data.voteAverage)",
                        budget: "\(data.budget)",
                        descript: data.overview
                    )
                case .failure(_):
                    self?.detailsView.errorView()
                }
            }
        }
    }
    
    private func fetchImg(path: String){
        apiProvider.fetchImg(path: path){ [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.detailsView.image.image = UIImage(data: data)
                case .failure(_):
                    self?.detailsView.image.image = UIImage(named: "not_found.png")
                }
            }
        }
    }
}
