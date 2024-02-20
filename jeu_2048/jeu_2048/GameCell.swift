//
//  GameCell.swift
//  jeu_2048
//
//  Created by admin on 20/02/2024.
//

import Foundation
import UIKit

class GameCell: UICollectionViewCell{
    var value:Int=0 {
        didSet{
            self.drawCell()
        }
    }
    var moved:Bool=false
    var texte:UILabel!=nil
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    func drawCell() {
        print(self.value)
        if texte == nil {
            print("coucou")
            texte = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            texte.numberOfLines = 1
            texte.textAlignment = .center
            texte.textColor = UIColor.white
        }
        
        switch value {
        case let x where x >= 2 && x <= 16 :
            texte.text = "\(x)"
            self.backgroundColor = UIColor.lightGray
        case let x where x >= 32 && x <= 256 :
            texte.text = "\(x)"
            self.backgroundColor = UIColor.yellow
        case let x where x >= 512 && x <= 2048 :
            texte.text = "\(x)"
            self.backgroundColor = UIColor.brown
        case let x where x > 2048:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.red
        default :
            texte.text = ""
            self.backgroundColor = UIColor.darkGray
        }
        
        self.contentView.addSubview(texte)
    }
    
}
