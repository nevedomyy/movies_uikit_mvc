import UIKit

class DetailsView: UIView{
    private let loader = UIActivityIndicatorView(style: .large)
    private let title = UILabel()
    private let raiting = UILabel()
    private let budget = UILabel()
    private let descript = UILabel()
    private let success = UIView()
    private let errorLabel = UILabel()
    
    let image = UIImageView()
    let errorButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false

        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 30)
        title.numberOfLines = 0
        
        raiting.translatesAutoresizingMaskIntoConstraints = false
        raiting.font = .boldSystemFont(ofSize: 18)
        
        budget.translatesAutoresizingMaskIntoConstraints = false
        budget.font = .boldSystemFont(ofSize: 18)
        
        descript.translatesAutoresizingMaskIntoConstraints = false
        descript.numberOfLines = 0
        
        success.addSubviews(image, title, raiting, budget, descript)
        success.frame = bounds
        
        errorButton.setTitle("Try again", for: .normal)
        errorButton.backgroundColor = .blue.withAlphaComponent(0.5)
        errorButton.translatesAutoresizingMaskIntoConstraints = false
        
        errorLabel.text = "Oops, something went wrong!"
        errorLabel.textColor = .secondaryLabel
        errorLabel.font = .systemFont(ofSize: 20)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(loader, success, errorLabel, errorButton)
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
            
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            image.leftAnchor.constraint(equalTo: leftAnchor),
            image.rightAnchor.constraint(equalTo: rightAnchor),
            image.heightAnchor.constraint(equalToConstant: 270),
            
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            
            raiting.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            raiting.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            
            budget.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            budget.topAnchor.constraint(equalTo: raiting.bottomAnchor),
            
            descript.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descript.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            descript.topAnchor.constraint(equalTo: budget.bottomAnchor, constant: 20),
        ])
    }
    
    func loaderView(){
        success.isHidden = true
        errorLabel.isHidden = true
        errorButton.isHidden = true
        loader.startAnimating()
        success.alpha = 0
        errorLabel.alpha = 0
        errorButton.alpha = 0
    }
    
    func successView(
        title: String,
        raiting: String,
        budget: String,
        descript: String
    ){
        self.title.text = title
        self.raiting.text = "Рейтинг: \(raiting)"
        self.budget.text = "Бюджет: \(budget)$"
        self.descript.text = descript
        success.isHidden = false
        loader.stopAnimating()
        UIView.animate(withDuration: 0.2){
            self.success.alpha = 1
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
