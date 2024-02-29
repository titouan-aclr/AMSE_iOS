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
        
        for i in 0...(nbRow-1){
            for j in 0...(nbColumns-1){
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
    @IBOutlet weak var scoreDisplay: UILabel!
    
    var nbRow : Int = 4
    var nbColumns : Int = 4
    var score : Int = 0 {
        didSet{
            scoreDisplay.text = score.codingKey.stringValue
        }
    }
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
    
    
    @IBAction func fill(){
        var x1 = 0, x2=0, y1=0, y2=0
        
        while(x1 == x2 && y1 == y2) {
            x1 = Int.random(in: 0..<(nbColumns-1))
            y1 = Int.random(in: 0..<(nbRow-1))
            x2 = Int.random(in: 0..<(nbColumns-1))
            y2 = Int.random(in: 0..<(nbRow-1))
        }
        
        cells[x1][y1]!.value = 2
        cells[x2][y2]!.value = 2
        
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
        case UISwipeGestureRecognizer.Direction.left:
            for j in 0...(nbRow-1) {
                for i in 0...(nbColumns-1) {
                    moveToDirection(direction: 0, x: i, y: j)
                }
            }
        case UISwipeGestureRecognizer.Direction.up:
            for j in 0...(nbColumns-1) {
                for i in 0...(nbRow-1) {
                    moveToDirection(direction: 1, x: j, y: i)
                }
            }
        case UISwipeGestureRecognizer.Direction.down:
            for j in (0...(nbColumns-1)).reversed() {
                for i in 0...(nbRow-1) {
                    moveToDirection(direction: 3, x: j, y: i)
                }
            }
        default:
            break
        }
        addRandCell()
    }
    
    func moveToDirection(direction:Int, x:Int, y:Int){
        var xNext:Int = x
        var yNext:Int = y
        var border:Bool
        
        switch direction {
        case 0:
            border = (x != 0)
            xNext = x-1
        case 1:
            border = (y != 0)
            yNext = y-1
        case 2:
            border = (x != nbColumns-1)
            xNext = x+1
        case 3:
            border = (y != nbRow-1)
            yNext = y+1
        default:
            border = false
            print("Error wrong direction case")
        }
        
        if(border){
            if(cells[yNext][xNext]!.value == 0) {
                cells[yNext][xNext]!.value = cells[y][x]!.value
                cells[y][x]!.value = 0
                moveToDirection(direction: direction, x: xNext, y: yNext)
            } else if(cells[yNext][xNext]!.value == cells[y][x]!.value){
                cells[yNext][xNext]!.value *= 2
                addToScore(toAdd: cells[yNext][xNext]!.value)
                cells[y][x]!.value = 0
            }
        }
    }
    
    func addRandCell(){
        var emptyCells:[(x: Int, y: Int)] = []
        
        for i in 0...(nbRow-1) {
            for j in 0...(nbColumns-1) {
                if(cells[i][j]!.value == 0){
                    emptyCells.append((x: j, y: i))
                }
            }
        }
        
        if(emptyCells.isEmpty){
            displayLosingAlert()
        } else {
            let index = Int.random(in: emptyCells.indices)
            cells[emptyCells[index].y][emptyCells[index].x]!.value = 2
        }
    }
    
    func addToScore(toAdd:Int) {
        score += toAdd
        
        if(toAdd == 2048){
            displaySuccessAlert()
        }
    }
    
    func resetGame() {
        for i in 0...(nbRow-1){
            for j in 0...(nbColumns-1){
                cells[i][j]!.value = 0
            }
        }
        score = 0
    }
    
    func displaySuccessAlert() {
        let controller = UIAlertController(title: "Félicitations !", message: "Vous avez réussi à créer une tuile de 2048\nSouhaitez-Vous continuer ?", preferredStyle : .alert)
                
        let action1 = UIAlertAction(title: "Continuer", style: .default) { ( action : UIAlertAction ) in
            
        }
        let action2 = UIAlertAction(title: "Recommencer", style: .destructive) { (action: UIAlertAction ) in
            self.resetGame()
        }
        
        controller.addAction(action1)
        controller.addAction(action2)
        
        self.present(controller, animated : true, completion : nil)
    }
    
    func displayLosingAlert() {
        let controller = UIAlertController(title: "Dommage !", message: "Toutes les cases sont remplies, vous avez perdu la partie.\n\nScore : \(self.score)", preferredStyle : .alert)
                
        let action = UIAlertAction(title: "Recommencer", style: .default) { (action: UIAlertAction ) in
            self.resetGame()
        }
        
        controller.addAction(action)
        
        self.present(controller, animated : true, completion : nil)
    }

}

