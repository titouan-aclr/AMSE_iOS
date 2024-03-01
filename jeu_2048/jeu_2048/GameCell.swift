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
        self.layer.cornerRadius = 10
        if texte == nil {
            texte = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            texte.numberOfLines = 1
            texte.textAlignment = .center
            texte.textColor = UIColor.init(rgb: 0x766E65)
            texte.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
        switch value {
        case let x where x ==  2:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xEDE4DA)
            texte.textColor = UIColor.init(rgb: 0x766E65)
        case let x where x ==  4:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xECE0C8)
            texte.textColor = UIColor.init(rgb: 0x766E65)
        case let x where x ==  8:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xEDB177)
            texte.textColor = UIColor.init(rgb: 0xF9F6F2)
        case let x where x ==  16:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xEE9560)
            texte.textColor = UIColor.init(rgb: 0xF9F6F2)
        case let x where x ==  32:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xEE7D5C)
            texte.textColor = UIColor.init(rgb: 0xF9F6F2)
        case let x where x ==  64:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xF65D3B)
            texte.textColor = UIColor.init(rgb: 0xF9F6F2)
        case let x where x ==  128:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xEDCE71)
            texte.textColor = UIColor.init(rgb: 0xF9F6F2)
        case let x where x ==  256:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xEDCC61)
            texte.textColor = UIColor.init(rgb: 0xF9F6F2)
        case let x where x ==  512:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xE4C02A)
            texte.textColor = UIColor.init(rgb: 0xF9F6F2)
        case let x where x ==  1024:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xE2BA13)
            texte.textColor = UIColor.init(rgb: 0xF9F6F2)
        case let x where x >=  2048:
            texte.text = "\(x)"
            self.backgroundColor = UIColor.init(rgb: 0xECC400)
            texte.textColor = UIColor.init(rgb: 0xF9F6F2)
        default :
            texte.text = ""
            self.backgroundColor = UIColor.init(red: 204/255, green: 193/255, blue: 180/255, alpha: 1)
        }
        
        self.contentView.addSubview(texte)
    }
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
