//
//  MainCell.swift
//  cleanMvvmGaleryExample
//
//  Created by Gabriel Merino Dos Santos - GMS on 24/10/22.
//

import UIKit
import Kingfisher

class MainCell: UICollectionViewCell, BaseView {

    let viewModel = MainViewModel()
    static let identifier = CellsStrings.cellGalery
    
    fileprivate var img: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = true
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        img.image = nil
    }
    
    func buildHierarchy() {
        contentView.addSubview(img)
    }
    
    func buildConstraints() {
        img.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        img.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func configure(with url: String) {
        img.kf.setImage(with: URL(string: url))
    }
}
