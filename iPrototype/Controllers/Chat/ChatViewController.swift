//
//  ChatViewController.swift
//  iPrototype
//
//  Created by Jack on 1/26/18.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    enum Section: Int {
        case Loading
        case Messages
        
        init?(indexPath: IndexPath) {
            self.init(rawValue: indexPath.section)
        }
        
        static var numberOfSections: Int { return 2 }
    }
    
    var pageNumber: Int = 0
    var isUpdating: Bool = false
    var isLastPage: Bool = false
    var isShowingFooterIndicator: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDefaults()
    }

}

// MARK: - Private functions.

extension ChatViewController {
    
    private func configureDefaults() {
        // Table view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib.init(nibName: ChatCell.className, bundle: nil), forCellReuseIdentifier: ChatCell.className)
        self.tableView.register(UINib.init(nibName: ChatLoadingCell.className, bundle: nil), forCellReuseIdentifier: ChatLoadingCell.className)
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        // Update data.
        self.updateData()
    }
    
    @objc private func updateData() {
        self.isLastPage = false
        self.isUpdating = false
        self.pageNumber = 0
        
        self.getMessages()
    }
    
    private func getMessages() {
        
        if self.isLastPage || self.isUpdating {
            return
        }
        
        self.pageNumber += 1
        
        ChatManager.sharedInstance.getMessages(pageNumber: self.pageNumber) { (success, result, message) -> () in
            if success {
                let resulstArray = result as! ArraySlice<Dictionary<String, Any>>
                self.isLastPage = resulstArray.count < 15 ? true : false
                self.isShowingFooterIndicator = !self.isLastPage
            } else {
                // Show error alert.
                self.isShowingFooterIndicator = false
                Constants.showAlert(title: NSLocalizedString("Error", comment: ""), message: message!)
            }
            if self.pageNumber == 1 {
                self.tableView.reloadData()
                self.scrollTableToBottom()
                self.isUpdating = false
                return
            }
            self.isUpdating = false
            self.tableView.reloadData()
        }
        self.isUpdating = true
    }
    
    private func scrollTableToBottom() {
        let lastIndex = ChatManager.sharedInstance.messages.count - 1
        self.tableView.scrollToRow(at: IndexPath.init(row: lastIndex, section: Section.Messages.rawValue), at: .bottom, animated: false)
    }
}

// MARK: - UITableViewDataSource.

extension ChatViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch Section.init(rawValue: section)! {
        case .Loading:
            return self.isLastPage ? 0 : 1
        case .Messages:
            return ChatManager.sharedInstance.messages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch Section.init(indexPath: indexPath)! {
        case .Loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatLoadingCell.className, for: indexPath) as! ChatLoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        case .Messages:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.className, for: indexPath) as! ChatCell
            cell.message = ChatManager.sharedInstance.getMessageAtIndex(indexPath.row)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate.

extension ChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == Section.Loading.rawValue {
            return
        }
        
        if indexPath.row == 0 {
            self.getMessages()
        }
    }
}
