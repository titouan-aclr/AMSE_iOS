//
//  ViewController.swift
//  jeu_2048
//
//  Created by admin on 20/02/2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
         
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets.init(top:0, left:CGFloat(cellsSpacing), bottom:0, right:CGFloat(cellsSpacing))
        layout.minimumLineSpacing = CGFloat(cellsSpacing)
        
        
        collectionView.setCollectionViewLayout(layout, animated:false)
        
        for i in 0...3{
            for j in 0...3{
                cells[i][j] = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2048", for: NSIndexPath(row: i, section: j)as IndexPath)as? GameCell
            }
        }
        collectionView.backgroundColor = UIColor.gray
        
        let detectionMouvementR: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementR.direction = .right
        view.addGestureRecognizer(detectionMouvementR)
        let detectionMouvementL: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementL.direction = .left
        view.addGestureRecognizer(detectionMouvementL)
        let detectionMouvementH: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementH.direction = .up
        view.addGestureRecognizer(detectionMouvementH)
        let detectionMouvementB: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementB.direction = .down
        view.addGestureRecognizer(detectionMouvementB)
        
    }

    /** VARIABLE DECLARATION   */
    @IBOutlet var collectionView : UICollectionView!
    
    var nbRow : Int = 4
    var nbColumns : Int = 4
    var cells:[[GameCell?]]
    let cellsSpacing = 10
    
    
    /** CONSTRUCTORS   */
    required init?(coder aDecoder: NSCoder){
        self.nbRow = 4
        self.nbColumns = 4
        cells = [[]]
        cells = ([[GameCell?]](repeating: [], count: nbRow))
        for j in 1...nbRow{
            let ligne = [GameCell?](repeating: nil, count: nbColumns)
            cells[j-1] = ligne
        }
        super.init(coder: aDecoder)
    }
    
    init?(coder aDecoder: NSCoder, nombreLignes:Int, nombreColonnes:Int){
        self.nbRow = nombreLignes
        self.nbColumns = nombreColonnes
        cells = [[]]
        cells = ([[GameCell?]](repeating: [], count: nombreLignes))
        for j in 1...nombreLignes{
            let ligne = [GameCell?](repeating: nil, count: nombreColonnes)
            cells[j-1] = ligne
        }
        super.init(coder: aDecoder)
    }
    
    
    /** FUNCTIONS  */
    // manage collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nbRow
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return nbColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cells[indexPath.section][indexPath.row]!.drawCell()
        return cells[indexPath.section][indexPath.row]!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:0, height: CGFloat(cellsSpacing))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - CGFloat(cellsSpacing * (nbColumns+2))) / CGFloat(nbColumns), height: (collectionView.frame.height - CGFloat(cellsSpacing * (nbRow + 2))) / CGFloat(nbColumns))
    }
    
    // test remplir le tableau
    @IBAction func fill(){
        /*for i in 0...3{
            for j in 0...3{
                cells[i][j]!.value = Int(pow(2,Double(j+i*j)))
            }
        }*/
        cells[2][2]!.value = 2
    }
    
    //gestion des muovements
    @objc func mouvement(sender:UISwipeGestureRecognizer){
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.right:
            for i in 0...(nbRow-1) {
                if(cells[i][2]!.value != 0){
                    if( cells[i+1][2]!.value != 0){
                        cells[i+1][2]!.value = cells[1][2]!.value
                        cells[i][2]!.value = 0
                    }
                }
            }
            print("Droite")
        case UISwipeGestureRecognizer.Direction.left:
            print("Gauche")
        case UISwipeGestureRecognizer.Direction.up:
            print("Haut")
        case UISwipeGestureRecognizer.Direction.down:
            print(" Bas")
        default:
            break
        }
    }
    

}

