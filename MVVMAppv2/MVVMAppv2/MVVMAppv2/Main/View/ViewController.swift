//
//  ViewController.swift
//  MVVMAppv2
//
//  Created by usuario on 26/8/22.
//

// https://jsonplaceholder.tipycode.com/posts
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var largeActivity: UIActivityIndicatorView!

    var viewModel = ViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }

    private func configureView() {
        largeActivity.isHidden = false
        largeActivity.startAnimating()
        viewModel.retriveDataList()
    }

    func bind () {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.largeActivity.stopAnimating()
                self?.largeActivity.isHidden = true
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let object = viewModel.dataArray [indexPath.row]

        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.body

        return cell
    }
}

