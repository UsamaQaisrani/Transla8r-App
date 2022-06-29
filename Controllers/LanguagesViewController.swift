//
//  LanguagesViewController.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import UIKit
import Combine

class LanguagesViewController: UIViewController {

    //MARK:- Class Properties
    var languagesData = [Languages]()
    let languageVM = LanguageViewModel()
    var gotLanguage = PassthroughSubject<String, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    deinit {
        subscriptions.forEach({$0.cancel()})
    }
}

//MARK:- Class Methods
extension LanguagesViewController {
    
    fileprivate func initialSetup(){
        navigationItem.title = ScreenTitles.LanuageScreen.rawValue
        bindingViewModelToView()
        fetchLanguages()
    }
    
    func bindingViewModelToView() {
        self.languageVM.gotLanguages
            .sink { languagesList in
                self.languagesData = languagesList
                DispatchQueue.main.async {
                    self.tableVIew.reloadData()
                }
            }
            .store(in: &subscriptions)
    }
        
    func fetchLanguages() {
        //Check if languages already loaded and saved in App Manager
        if let languagesList = AppManager.shared.languagesList {
            languagesData = languagesList
            return
        }
        //If languages not loaded before fetch them from API
        languageVM.fetchLanguages()
    }
}

//MARK:- TableView DataSource & Delegate
extension LanguagesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.LanguagesTableViewCell.rawValue, for: indexPath) as! LanguagesTableViewCell
        cell.configureCell(languageCode: languagesData[indexPath.row].language ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            //sending back selected language
            self.gotLanguage.send(self.languagesData[indexPath.row].language ?? "")
        }
    }
}
