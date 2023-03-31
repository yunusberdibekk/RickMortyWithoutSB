//
//  RickyMortyService.swift
//  RickMortyWithoutSB
//
//  Created by Yunus Emre Berdibek on 31.03.2023.
//

import Alamofire

enum RickyMortyServiceEndPoint: String {
    case BASEURL = "https://rickandmortyapi.com/api/"
    case PATH = "character"
    
    static func characterPath() -> String {
        return "\(BASEURL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickyMortyService {
    func fetchAllDatas(response: @escaping ([Result]?) -> (Void))
}

struct RickyMortyService: IRickyMortyService {
    func fetchAllDatas(response: @escaping ([Result]?) -> (Void)) {
        AF.request(RickyMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { model in
            guard let data = model.value else {
                //error
                response(nil)
                return
            }
            response(data.results)
        }
    }
}
