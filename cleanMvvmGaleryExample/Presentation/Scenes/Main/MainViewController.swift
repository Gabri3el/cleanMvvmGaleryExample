//
//  ViewController.swift
//  cleanMvvmGaleryExample
//
//  Created by Gabriel Merino Dos Santos - GMS on 24/10/22.
//

import UIKit

class MainViewController: UIViewController, BaseView {
    
    let viewModel = MainViewModel()
    var moreData = false
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = CGFloat(Numbers.minimumLineSpacing)
        layout.minimumInteritemSpacing = CGFloat(Numbers.minimumLineSpacing)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MainCell.self, forCellWithReuseIdentifier: MainCell.identifier)
        cv.backgroundColor = .white
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.viewModel.getPhotosList()
        DispatchQueue.main.async{
            self.buildHierarchy()
            self.buildConstraints()
        }
    }
    
    func buildHierarchy() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func buildConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imgUrl = viewModel.results[indexPath.row].urls.regular
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellsStrings.cellGalery, for: indexPath) as! MainCell
        cell.configure(with: imgUrl)
        self.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = collectionView.frame.width/CGFloat(Numbers.divisionWidthNormal) - CGFloat(Numbers.minimumLineSpacing)
        
        if UIDevice.current.orientation.isLandscape {
            width = collectionView.frame.width/CGFloat(Numbers.divisionWidthLandscape) - CGFloat(Numbers.minimumLineSpacing)
        }
        return CGSize(width: width, height: width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            if !moreData {
                fetchAgain()
            }
        }
    }
    
    func fetchAgain() {
        moreData = true
        DispatchQueue.main.asyncAfter(deadline: .now() + Numbers.oneSecond, execute: {
            let newPhotos = self.viewModel.results
            self.viewModel.results.append(contentsOf: newPhotos)
            self.moreData = false
            self.collectionView.reloadData()
        })
        
    }
}
