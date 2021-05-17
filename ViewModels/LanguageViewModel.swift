//
//  LanguageViewModel.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import Foundation

class LanguageViewModel {

    init(){
        
    }
    
    //MARK:- Class Methods
    func fetchLanguages(completion : @escaping ([LanguagesData])->Void){
        NetworkManager.shared.fetchData(method: .fetchLanguages) { (result: Result<LanguageModel,Swift.Error>) in
            switch result {
            case .success(let languagesData):
                AppManager.shared.languagesList = languagesData.data?.languages
                completion(languagesData.data?.languages ?? [LanguagesData]())
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func translateText(text : String, source: String, target: String, completion: @escaping (TranslationModel)->Void){
        NetworkManager.shared.fetchData(method: .translate(text: text, source: source, target: target)) { (result : Result<TranslationModel, Swift.Error>) in
            switch result {
            case .success(let translationData):
                completion(translationData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
