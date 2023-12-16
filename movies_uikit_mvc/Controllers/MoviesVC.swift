import UIKit

class MoviesVC: UIViewController {
    private let apiProvider: ApiProvider
    private let moviesView: MoviesView
    private var movies: Movies?
    
    init(apiProvider: ApiProvider, moviesView: MoviesView) {
        self.apiProvider = apiProvider
        self.moviesView = moviesView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesView.tableView.dataSource = self
        moviesView.tableView.delegate = self
        moviesView.errorButton.addTarget(self, action: #selector(fetchMovies), for: .touchUpInside)
        view = moviesView
        
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = moviesView.tableView.indexPathForSelectedRow {
            moviesView.tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    @objc private func fetchMovies(){
        moviesView.loaderView()
        apiProvider.fetchMovies{ [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.movies = data
                    self?.moviesView.successView()
                case .failure(_):
                    self?.moviesView.errorView()
                }
            }
        }
    }
}
        
extension MoviesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: moviesView.identifier,
            for: indexPath) as? MoviesCell else {
            fatalError("Unsupported cell")
        }
        self.fetchImg(path: movies?.results[indexPath.row].posterPath ?? "", cell: cell)
        cell.title.text = movies?.results[indexPath.row].title ?? ""
        cell.descript.text = movies?.results[indexPath.row].overview ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = movies?.results[indexPath.row].id else { return }
        navigationController?.pushViewController(Dependencies.detailsVC(id: id), animated: true)
    }
    
    private func fetchImg(path: String, cell: MoviesCell){
        apiProvider.fetchImg(path: path){ [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    cell.image.image = UIImage(data: data)
                case .failure(_):
                    cell.image.image = UIImage(named: "not_found.png")
                }
            }
        }
    }
}
