//
//  ViewController.swift
//  CollectionDemo
//
//  Created by Kshama Saklecha on 17/02/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CollectionViewProtocol, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var popup: UIView!
    var displayData: [ResponseData] = [ResponseData]()
    var service: NetworkService = NetworkService()
    
    @IBOutlet weak var popupBodyData: UILabel!
    @IBOutlet weak var popupID: UILabel!
    @IBOutlet weak var popupTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.service.delegate = self
        self.service.apiCall()
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        self.collectionView.delegate = self
        self.popup.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.displayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 7
        cell.configure(data:self.displayData[indexPath.item])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell:CollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        self.popupID.text = cell.id.text
        self.popupTitle.text = cell.title.text
        self.popupBodyData.text = cell.bodyData.text
        self.popup.layer.borderWidth = 2
        self.popup.layer.cornerRadius = 7
        UIView.transition(with: self.popup, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.popup.isHidden = false
                          })
    }
    
    func didReceiveData(result: [ResponseData]?) {
        guard let result = result else{
            return
        }
        DispatchQueue.main.async {
            self.displayData = result
            self.collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.popup.isHidden = true
        if !decelerate {
            self.scrollToNearestVisibleCollectionViewCell()
        }
    }
    
    func scrollToNearestVisibleCollectionViewCell() {
        let visibleCenterPositionOfScrollView = Float(collectionView.contentOffset.x + (self.collectionView!.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<collectionView.visibleCells.count {
            let cell = collectionView.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2 )
            
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = collectionView.indexPath(for: cell)!.row
                
            }
        }
        if closestCellIndex != -1 {
            self.collectionView!.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}


