//
//  ViewController.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import UIKit

class TranslatorViewController: UIViewController {

    //MARK:- Class Properties
    var isleft = false
    var sourceCode = "en"
    var targetCode = "en"
    
    //MARK:- IBOutlets
    @IBOutlet weak var firstLanguageButton: UIButton!
    @IBOutlet weak var secondLanguageButton: UIButton!
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var translatedTextField: UITextField!
    
    //MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK:- Class Methods
extension TranslatorViewController {
    
    fileprivate func initialSetup(){
        
        navigationItem.title = "Translate"
    }
    
    func presentLanguageSelectViewController(){
        let storyboard = self.storyboard?.instantiateViewController(identifier: "LanguagesViewController") as! LanguagesViewController
        let navController = UINavigationController(rootViewController: storyboard)
        storyboard.delegate = self
        present(navController, animated: true, completion: nil)
    }
}

//MARK:- LanguagesViewControllerDelegate
extension TranslatorViewController : LanguagesViewControllerDelegate {
    
    func sendValue(languageName: String) {
        
        let locale = NSLocale(localeIdentifier: languageName)
        let translated = locale.displayName(forKey: NSLocale.Key.identifier, value: languageName)
        
        if isleft {
            sourceCode = languageName
            firstLanguageButton.setTitle(translated, for: .normal)
            return
        }
        
        targetCode = languageName
        secondLanguageButton.setTitle(translated, for: .normal)
    }
}

//MARK:- IBActions
extension TranslatorViewController {
    
    @IBAction func firstLanguageButtonPressed(_ sender: Any) {
        isleft = true
        presentLanguageSelectViewController()
    }
    
    @IBAction func secondLanguageButtonPressed(_ sender: Any) {
        isleft = false
        presentLanguageSelectViewController()
    }
    
    @IBAction func translateButtonPressed(_ sender: Any) {
        
        translatedTextField.text = ""
         
        let languagesVM = LanguageViewModel()
        
        languagesVM.translateText(text: translateTextField.text ?? "", source: sourceCode, target: targetCode) { (translationData) in
            
            translationData.data?.translations?.forEach({ (translation) in
                self.translatedTextField.text! += translation.translatedText ?? ""
            })
        }
    }
}
