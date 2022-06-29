//
//  ViewController.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import UIKit
import Combine

class TranslatorViewController: UIViewController {

    //MARK:- Class Properties
    var isSource = false
    var sourceCode = "en"
    var targetCode = "es"
    
    var languagesVC: LanguagesViewController?
    var subscriptions = Set<AnyCancellable>()
    
    let languagesVM = LanguageViewModel()
    
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
    
    deinit {
        subscriptions.forEach({$0.cancel()})
    }
}

//MARK:- Class Methods
extension TranslatorViewController {
    
    fileprivate func initialSetup(){
        
        navigationItem.title = ScreenTitles.TranslatorScreen.rawValue
        languagesVC = self.storyboard?.instantiateViewController(identifier: ControllerIdentifiers.LanguagesViewController.rawValue) as? LanguagesViewController
        bindingLanguagesVCToTranslatorVC()
        bindViewToViewModel()
        bindingViewModelToView()
    }
    
    func presentLanguageSelectViewController(){
        let navController = UINavigationController(rootViewController: languagesVC ?? LanguagesViewController())
        present(navController, animated: true, completion: nil)
    }
    
    //Binddings
    func bindViewToViewModel() {
        translateTextField
            .textDidChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: languagesVM)
            .store(in: &subscriptions)
    }
    
    func bindingViewModelToView() {
        languagesVM.gotTranslation
            .sink { [unowned self] (translation) in
                translation.data?.translations?.forEach({ (translationData) in
                    self.translatedTextField.text! += translationData.translatedText ?? ""
                })
            }
            .store(in: &subscriptions)
    }
    
    func bindingLanguagesVCToTranslatorVC() {
        self.languagesVC?.gotLanguage
            .sink { [unowned self] language in
                self.setup(language)
            }
            .store(in: &subscriptions)
    }
    
    
    //Receive Selected language
    func setup(_ languageName: String) {
        let locale = NSLocale(localeIdentifier: languageName)
        let translated = locale.displayName(forKey: NSLocale.Key.identifier, value: languageName)
        
        if isSource {
            languagesVM.source = languageName
            firstLanguageButton.setTitle(translated, for: .normal)
            return
        }
        
        languagesVM.target = languageName
        secondLanguageButton.setTitle(translated, for: .normal)
    }
}

//MARK:- IBActions
extension TranslatorViewController {
    
    @IBAction func firstLanguageButtonPressed(_ sender: Any) {
        isSource = true
        presentLanguageSelectViewController()
    }
    
    @IBAction func secondLanguageButtonPressed(_ sender: Any) {
        isSource = false
        presentLanguageSelectViewController()
    }
    
    @IBAction func translateButtonPressed(_ sender: Any) {
        
        translatedTextField.text = ""
        languagesVM.translateText()
    }
}
