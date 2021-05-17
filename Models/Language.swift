//
//  Language.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import Foundation

class LanguageModel : Codable {
    
    var data : Data?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(Data.self, forKey: .data)
    }
    
    init(){
        
    }
}

class Data : Codable {
    var languages : [Languages]?

    enum CodingKeys: String, CodingKey {

        case languages = "languages"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        languages = try values.decodeIfPresent([Languages].self, forKey: .languages)
    }

    init(){
        
    }
}
class Languages : Codable {
    var language : String?

    enum CodingKeys: String, CodingKey {

        case language = "language"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        language = try values.decodeIfPresent(String.self, forKey: .language)
    }
    
    init(){
        
    }
}
