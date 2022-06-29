//
//  LanguageViewModel.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import Foundation
import Combine

class LanguageViewModel {

    @Published var text: String = ""
    @Published var source: String = "en"
    @Published var target: String = "es"
    
    var gotLanguages = PassthroughSubject<[Languages], Never>()
    var gotTranslation = PassthroughSubject<TranslationModel, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        
    }
    
    deinit {
        //cancelling all subscriptions on deinit
        subscriptions.forEach({$0.cancel()})
    }
    
    //MARK:- Class Methods
    func fetchLanguages(){
        NetworkManager.shared.fetchData(method: .fetchLanguages) { (result: Result<LanguageModel,Swift.Error>) in
            switch result {
            case .success(let languagesData):
                AppManager.shared.languagesList = languagesData.data?.languages
                self.gotLanguages.send(languagesData.data?.languages ?? [Languages]())
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func translateText(){
        NetworkManager.shared.fetchData(method: .translate(text: text, source: source, target: target)) { (result : Result<TranslationModel, Swift.Error>) in
            switch result {
            case .success(let translationData):
                self.gotTranslation.send(translationData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
