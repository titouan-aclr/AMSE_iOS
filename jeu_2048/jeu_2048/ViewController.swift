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
        cells[2][0]!.value = 4
        cells[2][1]!.value = 0
        cells[2][2]!.value = 4
        cells[2][3]!.value = 4
        
    }
    
    //gestion des muovements
    @objc func mouvement(sender:UISwipeGestureRecognizer){
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.right:
            for j in 0...(nbRow-1) {
                for i in (0...(nbColumns-1)).reversed() {
                    moveToDirection(direction: 2, x: i, y: j)
                }
            }
            print("Droite")
        case UISwipeGestureRecognizer.Direction.left:
            for j in 0...(nbRow-1) {
                for i in 0...(nbColumns-1) {
                    moveToDirection(direction: 0, x: i, y: j)
                }
            }
            print("Gauche")
        case UISwipeGestureRecognizer.Direction.up:
            for j in 0...(nbColumns-1) {
                for i in 0...(nbRow-1) {
                    moveToDirection(direction: 1, x: j, y: i)
                }
            }
            print("Haut")
        case UISwipeGestureRecognizer.Direction.down:
            for j in (0...(nbColumns-1)).reversed() {
                for i in 0...(nbRow-1) {
                    moveToDirection(direction: 3, x: j, y: i)
                }
            }
            print(" Bas")
        default:
            break
        }
    }
    
    func moveToDirection(direction:Int, x:Int, y:Int) {
        if(direction == 0){
            if(x != 0){
                if(cells[y][x-1]!.value == 0) {
                    cells[y][x-1]!.value = cells[y][x]!.value
                    cells[y][x]!.value = 0
                    moveToDirection(direction: 0, x: x-1, y: y)
                } else if(cells[y][x-1]!.value == cells[y][x]!.value){
                    cells[y][x-1]!.value *= 2
                    cells[y][x]!.value = 0
                }
            }
        }
        
        if(direction == 1){
            if(y != 0){
                if(cells[y-1][x]!.value == 0) {
                    cells[y-1][x]!.value = cells[y][x]!.value
                    cells[y][x]!.value = 0
                    moveToDirection(direction: 1, x: x, y: y-1)
                } else if(cells[y-1][x]!.value == cells[y][x]!.value){
                    cells[y-1][x]!.value *= 2
                    cells[y][x]!.value = 0
                }
            }
        }
        
        if(direction == 2){
            if(x != nbColumns-1){
                if(cells[y][x+1]!.value == 0) {
                    cells[y][x+1]!.value = cells[y][x]!.value
                    cells[y][x]!.value = 0
                    moveToDirection(direction: 2, x: x+1, y: y)
                } else if(cells[y][x+1]!.value == cells[y][x]!.value){
                    cells[y][x+1]!.value *= 2
                    cells[y][x]!.value = 0
                }
            }
        }
        
        if(direction == 3){
            if(y != nbRow-1){
                if(cells[y+1][x]!.value == 0) {
                    cells[y+1][x]!.value = cells[y][x]!.value
                    cells[y][x]!.value = 0
                    moveToDirection(direction: 3, x: x, y: y+1)
                } else if(cells[y+1][x]!.value == cells[y][x]!.value){
                    cells[y+1][x]!.value *= 2
                    cells[y][x]!.value = 0
                }
            }
        }
    }
    

}

