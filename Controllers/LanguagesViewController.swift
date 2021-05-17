//
//  LanguagesViewController.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import UIKit

protocol LanguagesViewControllerDelegate {
    func sendValue(languageName: String)
}

class LanguagesViewController: UIViewController {

    //MARK:- Class Properties
    var languagesData = [LanguagesData]()
    var delegate : LanguagesViewControllerDelegate!
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK:- Class Methods
extension LanguagesViewController {
    
    fileprivate func initialSetup(){
        
        navigationItem.title = "Select Language"
        
        tableVIew.delegate = self
        tableVIew.dataSource = self
        
        fetchLanguages()
    }
    
    func fetchLanguages() {
        
        if let languagesList = AppManager.shared.languagesList {
            languagesData = languagesList
            return
        }
        
        let languageVM = LanguageViewModel()
        languageVM.fetchLanguages { (languageResponseData) in
            
            let langs = languageResponseData
            self.languagesData = langs

            DispatchQueue.main.async {
                self.tableVIew.reloadData()
            }
        }
    }
}

//MARK:- TableView DataSource
extension LanguagesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesTableViewCell", for: indexPath) as! LanguagesTableViewCell
        cell.configureCell(languageCode: languagesData[indexPath.row].language ?? "")
        return cell
    }
}

//MARK:- TableView Delegate
extension LanguagesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true) {
            self.delegate.sendValue(languageName: self.languagesData[indexPath.row].language ?? "")
        }
    }
}
