//
//  CollectionViewCell.swift
//  CollectionDemo
//
//  Created by Kshama Saklecha on 18/02/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bodyData: UILabel!
    
    public func configure(data:ResponseData){
        self.id.text = String(data.id ?? 0)
        self.title.text = data.title
        self.bodyData.text = data.body
    }
}
