//
//  ViewController.swift
//  UICollectionViewSetTopInsetDuringRefresh
//
//  Created by Ueeek on 2023/04/08.
//

import UIKit

class CollectionViewController: UICollectionViewController{

    private let reuseIdentifier = "reuseIdentifier"
    private lazy var refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        //default is .automatic
        collectionView.contentInsetAdjustmentBehavior = .never
        
        printInsetTop(message: "ViewDidAppear")
    }
    
    private func setup() {
        collectionView.backgroundColor = .white
        
        //Refresh Control
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        // set topInset so that we can see the 1st cell entirely
        self.setCollectionViewTopInset()
    }
    
    // MARK: - Debug
    private func printInsetTop(message: String) {
        print("# \(message)")
        print("+ contentInset:         \(collectionView.contentInset.top)")
        print("+ adjustedContentInset: \(collectionView.adjustedContentInset.top)")
        print("")
    }
    
    // MARK: - Pull To Refresh
    @objc func pullToRefresh() {
        startLoading()
        
        DispatchQueue.main.asyncAfter (deadline: .now() + 2) {
            self.endLoading()
        }
    }
    
    private func startLoading() {
        printInsetTop(message: "startLoading before modify inset")
        setCollectionViewTopInset()
        printInsetTop(message: "startLoading after modify inset")
    }
    
    private func endLoading() {
        printInsetTop(message: "startLoading before endRefreshing")
        refreshControl.endRefreshing()
        printInsetTop(message: "startLoading after endRefreshing")
    }
    
    
    //MARK: - CollectionView
    private func setCollectionViewTopInset() {
        collectionView.contentInset.top = 50
    }
        

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .purple
        } else {
            cell.backgroundColor = .red
        }
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        return CGSize(width: width, height: 100)
    }
}

class Cell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
