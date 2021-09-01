//
//  GameViewController.swift
//  FindNumber
//
//  Created by Илья Бучнев on 08.08.2021.
//

import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var nextDigitLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    
    lazy var game = Game(countItems: buttons.count) {[weak self] (status, time) in
        guard let self = self else {return}
        self.timeLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
         // Do any additional setup after loading the view.
    }
    

    @IBAction func pressButon(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index: buttonIndex)
        updateUI()
    }
    
    private func setupScreen(){
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isEnabled = true
            buttons[index].alpha = 1
        }
        nextDigitLabel.text = game.nextItem?.title
    }
    
    private func updateUI(){
        for index in game.items.indices {
            //buttons[index].isHidden = game.items[index].isFound
            buttons[index].alpha = game.items[index].isFound ? 0:1
            buttons[index].isEnabled = !game.items[index].isFound
            if game.items[index].isError{
                UIView.animate(withDuration: 0.3){[weak self] in
                    self?.buttons[index].backgroundColor = .red
                }completion: {[weak self]  (_) in
                    self?.buttons[index].backgroundColor = .systemGray6
                    self?.game.items[index].isError = false
                }
            }
        }
        nextDigitLabel.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status:StatusGame){
        switch status {
        case .start:
            statusLabel.text = "Игра началась!"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Вы выиграли!"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
            if game.isNewRecord{
                showAlert()
            }else{
                showActionSheet()
            }
            
        case .lose:
            statusLabel.text = "Вы проиграли!"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            showActionSheet()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Congratulations!", message: "New recotd!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction);
        present(alert, animated: true, completion: nil)
        
        
    }
    
    private func showActionSheet(){
        let alert = UIAlertController(title: "What next?", message: nil, preferredStyle: .actionSheet)
        let newGameAction = UIAlertAction(title: "New Game", style: .default){ [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        let showRecord = UIAlertAction(title: "Show Record", style: .default) {[weak self] (_) in
            
            //TODO: - RECORD VIEW CONTROLLER
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
            
        }
        let menuAction = UIAlertAction(title: "Go to menu", style: .destructive) { [weak self](_) in
            self?.navigationController?.popViewController(animated: true)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        if let popover = alert.popoverPresentationController{
            popover.sourceView = statusLabel
            //popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            //popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        }
        present(alert, animated: true, completion: nil)
    }
    
    
}

