//
//  RickyMortyTableViewCell.swift
//  RickMortyWithoutSB
//
//  Created by Yunus Emre Berdibek on 31.03.2023.
//

import UIKit
import SnapKit
import AlamofireImage

class RickyMortyTableViewCell: UITableViewCell {
    
    private let customImage: UIImageView = UIImageView()
    private let tittle: UILabel = UILabel()
    private let customDescription: UILabel = UILabel()
    private let randomImage: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
        case  custom = "cell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(customImage)
        addSubview(tittle)
        addSubview(customDescription)
        tittle.font = .boldSystemFont(ofSize: 18)
        customDescription.font = .italicSystemFont(ofSize: 10)
        
        customImage.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.top.equalTo(contentView)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        tittle.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.right.left.equalTo(contentView)
        }
        
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(tittle).offset(5)
            make.right.left.equalTo(tittle)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model: Result) {
        tittle.text = model.name
        customDescription.text = model.status.rawValue
        customImage.af.setImage(withURL: URL(string: model.image ??  randomImage) ?? URL(string: randomImage)!)
        
    }
    
    
}
