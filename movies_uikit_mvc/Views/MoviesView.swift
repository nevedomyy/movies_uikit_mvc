import UIKit

class MoviesView: UIView{
    private let loader = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let errorButton = UIButton()
    let identifier = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(MoviesCell.self, forCellReuseIdentifier: identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 180
        
        errorButton.setTitle("Try again", for: .normal)
        errorButton.backgroundColor = .blue.withAlphaComponent(0.5)
        errorButton.translatesAutoresizingMaskIntoConstraints = false
        
        errorLabel.text = "Oops, something went wrong!"
        errorLabel.textColor = .secondaryLabel
        errorLabel.font = .systemFont(ofSize: 20)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(loader, tableView, errorLabel, errorButton)
        addLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addLayoutConstraint() {
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            errorButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            errorButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            errorButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 30),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func loaderView(){
        tableView.isHidden = true
        errorLabel.isHidden = true
        errorButton.isHidden = true
        tableView.alpha = 0
        errorLabel.alpha = 0
        errorButton.alpha = 0
        loader.startAnimating()
    }
    
    func successView(){
        tableView.reloadData()
        tableView.isHidden = false
        loader.stopAnimating()
        UIView.animate(withDuration: 0.2){
            self.tableView.alpha = 1
        }
    }
    
    func errorView(){
        errorLabel.isHidden = false
        errorButton.isHidden = false
        loader.stopAnimating()
        UIView.animate(withDuration: 0.2){
            self.errorLabel.alpha = 1
            self.errorButton.alpha = 1
        }
    }
}
