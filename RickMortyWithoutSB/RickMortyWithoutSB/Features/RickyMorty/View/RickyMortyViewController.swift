//
//  RickyMortyViewController.swift
//  RickMortyWithoutSB
//
//  Created by Yunus Emre Berdibek on 31.03.2023.
//

import UIKit
import SnapKit

protocol IRickyMortyOutPut { //Dışarıya ne yapmak istediğimzi söylüyor.
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}

final class RickyMortyViewController: UIViewController {
    
    private let labelTittle: UILabel = UILabel()
    private let tableView:UITableView = UITableView()
    private let indicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var results:[Result] = []
    lazy var viewModel: IRickyMortyViewModel = RickyMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
        
    }
    
    private func configure() {
        view.addSubview(labelTittle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        drawDesign()
        makeLabel()
        makeIndicator()
        makeTableView()
        
    }
    
    private func drawDesign() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RickyMortyTableViewCell.self, forCellReuseIdentifier: RickyMortyTableViewCell.Identifier.custom.rawValue)
        
        tableView.rowHeight = 150
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelTittle.font = .boldSystemFont(ofSize: 25)
            self.labelTittle.text = "Ricky and  Morty"
            self.indicator.color = .blue
        }
        
        indicator.startAnimating()
    }
    
    
}

extension RickyMortyViewController {
    
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTittle.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTittle)
        }
    }
    
    private func makeLabel() {
        labelTittle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
            
        }
    }
    
    private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTittle)
            make.right.equalTo(labelTittle).offset(-5)
            make.top.equalTo(labelTittle)
        }
    }
}

extension RickyMortyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickyMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickyMortyTableViewCell.Identifier.custom.rawValue) as? RickyMortyTableViewCell else {
            
            return UITableViewCell()
        }
        
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
    
    
    
}

extension RickyMortyViewController: IRickyMortyOutPut {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
