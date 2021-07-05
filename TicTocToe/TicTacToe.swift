//
//  TicTacToe.swift
//  TicTocToe
//
//  Created by DCS on 03/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class TicTacToe: UIViewController {
    
    private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                         2,2,2,2]
    
    private var p1 = 0
    private var p2 = 0
    private let win = [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],[0,5,10,15],[3,6,9,12],[0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15]]
    
    private var flag = false
    private let mycv: UICollectionView =    {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 150, left: 10, bottom: 20,right: 10)
        layout.itemSize = CGSize(width: 80, height: 80)
        
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        return cv
    }()

    private let mylbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Turn Of Player : "
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.red
        return lbl
    }()
    private let playerlbl : UILabel = {
        let lbl = UILabel()
        lbl.text = " X"
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.red
        return lbl
    }()
    
    private let lblPlayer1 : UILabel = {
        let lbl = UILabel()
        lbl.text = " PLAYER X : "
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.red
        return lbl
    }()
    private let lblPlayer2 : UILabel = {
        let lbl = UILabel()
        lbl.text = " PLAYER O : "
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.red
        return lbl
    }()
    
    private let lblScore1 : UILabel = {
        let lbl = UILabel()
        lbl.text = " "
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.red
        return lbl
    }()
    private let lblScore2 : UILabel = {
        let lbl = UILabel()
        lbl.text = " "
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.red
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mycv)
        view.addSubview(mylbl)
        view.addSubview(playerlbl)
        lblScore1.text = String(p1)
        lblScore2.text = String(p2)
        view.addSubview(lblScore2)
        view.addSubview(lblScore1)
        view.addSubview(lblPlayer1)
        view.addSubview(lblPlayer2)
        view.addSubview(playerlbl)
       
        mycv.backgroundColor = .white
        
        view.backgroundColor = .white
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        // bgimg.frame = CGRect(x:0, y: view.safeAreaInsets.top, width: view.width, height: 700)
        lblPlayer1.frame = CGRect(x:0,y:100,width: 120,height: 50)
        lblPlayer2.frame = CGRect(x:220,y:100,width:120,height: 50)
        lblScore1.frame = CGRect(x:100,y:100,width:50,height: 50)
        lblScore2.frame = CGRect(x:320,y:100,width:50,height: 50)
        mylbl.frame = CGRect(x: 10,y: 600,width: 300,height: 40)
        playerlbl.frame = CGRect(x: 110,y: 600,width: view.width-40,height: 40)
        mycv.frame = view.bounds
       
    }

}
extension TicTacToe : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.setupCell(with: state[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if state[indexPath.row] != 0 && state[indexPath.row] != 1{
            state.remove(at: indexPath.row)
            if flag{
                playerlbl.text = "X"
                state.insert(0, at: indexPath.row)
            }
            else{
                playerlbl.text = "O"
                state.insert(1, at: indexPath.row)
            }
            
            flag = !flag
            collectionView.reloadData()
            chkWin()
        }
    }
    
    private func setup(){
        mycv.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
        mycv.dataSource = self
        mycv.delegate  = self
        
    }
    private func chkWin(){
        if !state.contains(2) {
            let alert = UIAlertController(title: "Game Over!", message: "It's a Tie Replay !!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in self?.resetAll()}))
            DispatchQueue.main.async {
                self.present(alert,animated: true,completion: nil)
            }
            
        }
        for i in win{
            if state[i[0]] == state[i[1]] && state[i[1]] == state[i[2]] && state[i[2]] == state[i[3]] && state[i[0]] != 2{
                winner(player: state[i[0]] == 0 ? "0" : "X")
                break
            }
        }
    }
    
    private func winner(player: String){
        if player == "X"
        {
            p1 += 1
            lblScore1.text = String(p1)
            
            let  alert = UIAlertController(title: "Game Over!", message: "YUP!! Player : \(player) Won!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in self?.resetAll()}))
            DispatchQueue.main.async {
                self.present(alert,animated: true,completion: nil)
            }
            
        }
        else{
            p2 += 1
            lblScore2.text = String(p2)
            
            let  alert = UIAlertController(title: "Game Over!", message: "YUP!! Player : \(player) Won!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in self?.resetAll()}))
            DispatchQueue.main.async {
                self.present(alert,animated: true,completion: nil)
            }
        }
        
        
    }
    
    private func resetAll(){
        
        state = [2,2,2,2,
                 2,2,2,2,
                 2,2,2,2,
                 2,2,2,2]
        
        flag = false
        mycv.reloadData()
        
    }
}
