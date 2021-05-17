//
//  TranslationModel.swift
//  Transl8or
//
//  Created by Usama on 15/04/2021.
//

import Foundation

class TranslationModel : Codable {
    
    var data : TranslationData?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(TranslationData.self, forKey: .data)
    }
    
    init(){
        
    }
}

class TranslationData : Codable {
    var translations : [Translations]?

    enum CodingKeys: String, CodingKey {

        case translations = "translations"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        translations = try values.decodeIfPresent([Translations].self, forKey: .translations)
    }
    
    init(){
        
    }
}

class Translations : Codable {
    var translatedText : String?

    enum CodingKeys: String, CodingKey {

        case translatedText = "translatedText"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        translatedText = try values.decodeIfPresent(String.self, forKey: .translatedText)
    }
    
    init(){
        
    }
}
