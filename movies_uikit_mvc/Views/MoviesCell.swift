import UIKit

final class MoviesCell: UITableViewCell {
    let image = UIImageView()
    let title = UILabel()
    let descript = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false

        title.textColor = .label
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false

        descript.numberOfLines = 8
        descript.textColor = .secondaryLabel
        descript.font = .systemFont(ofSize: 14)
        descript.translatesAutoresizingMaskIntoConstraints = false
                
        addSubviews(image, title, descript)
        addLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addLayoutConstraint() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            image.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            image.widthAnchor.constraint(equalToConstant: 100),
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            title.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            descript.topAnchor.constraint(equalTo: title.bottomAnchor),
            descript.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            descript.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        title.text = nil
        descript.text = nil
    }
}
