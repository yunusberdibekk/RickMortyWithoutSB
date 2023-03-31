//
//  RickyMortyViewModel.swift
//  RickMortyWithoutSB
//
//  Created by Yunus Emre Berdibek on 31.03.2023.
//

import Foundation

protocol IRickyMortyViewModel {
    
    func fetchItems()
    func changeLoading()
    
    var rickyMortyCharacters: [Result] {get set}
    var rickyMortyService: IRickyMortyService {get}
    
    var rickyMortyOutPut: IRickyMortyOutPut? {get}
    
    func setDelegate(output: IRickyMortyOutPut)
    
}

final class RickyMortyViewModel: IRickyMortyViewModel {
    
    var rickyMortyOutPut: IRickyMortyOutPut?
    
    func setDelegate(output: IRickyMortyOutPut) {
        self.rickyMortyOutPut = output
    }
    
    
    var rickyMortyCharacters: [Result] = []
    private var isLoading = false
    let rickyMortyService: IRickyMortyService
    
    init() {
        rickyMortyService = RickyMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        rickyMortyService.fetchAllDatas { [weak self] (response) in //weak self: değer kaybı veya sayfa öldüğünde değerin yok olmasını sağlar.
            self?.changeLoading()
            self?.rickyMortyCharacters = response ?? []
            self?.rickyMortyOutPut?.saveDatas(values: self?.rickyMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickyMortyOutPut?.changeLoading(isLoad: isLoading)
    }
    
    
    
    
}
