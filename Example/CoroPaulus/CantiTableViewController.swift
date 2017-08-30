//
//  CantiTableViewController.swift
//  CoroPaulus
//
//  Created by Riccardo Crippa on 8/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import CoroPaulus

class CantiTableViewController: UITableViewController {

    var canti = [Canto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coro Paulus"
        self.fetchCanti()
    }
    
    private func fetchCanti() {
        let request = CoroRequest()
        request.fetchCanti { [weak self] canti in
            DispatchQueue.main.async {
                self?.canti = canti
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.canti.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let canto = self.canti[indexPath.row]
        cell.textLabel?.text = canto.nome
        cell.detailTextLabel?.text = canto.url

        return cell
    }
}
