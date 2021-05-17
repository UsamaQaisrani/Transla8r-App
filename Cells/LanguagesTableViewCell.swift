//
//  LanguagesTableViewCell.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import Foundation
import UIKit

class LanguagesTableViewCell : UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var languageLabel: UILabel!
    
}

//MARK:- Class Methods
extension LanguagesTableViewCell {
    
    func configureCell(languageCode: String) {
        
        let locale = NSLocale(localeIdentifier: languageCode)
        let translated = locale.displayName(forKey: NSLocale.Key.identifier, value: languageCode)
        languageLabel.text = translated
    }
}
