//
//  PostsViewController.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import UIKit
import RxSwift
import RxCocoa

class PostsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    // MARK: - Dependencies
    /// View model for fetching posts and performing other operations
    private var viewModel = PostViewModel()
    /// Dispose bag for memory management
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        // Fetch posts from network
        self.viewModel.fetchPosts()
        self.setupTableViewBinding()
        self.setupCommentsBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.refreshPosts()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.emptyStateLabel.text = Constants.emptyStateMessage
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Register custom cell
        let nib = UINib(nibName: Constants.CellIdentifier.postTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.CellIdentifier.postTableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    // MARK: - Bindings Setup
    /// Bind posts to table view
    private func setupTableViewBinding() {
        self.viewModel.posts
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: Constants.CellIdentifier.postTableViewCell, cellType: PostTableViewCell.self)) { row, post, cell in
                cell.updateUI(with: post)
                
                // Subscribe to cell's commentTapped event
                cell.commentTapped.subscribe(onNext: { [weak self] postId in
                    self?.viewModel.fetchComments(for: postId)
                })
                .disposed(by: cell.disposeBag) // Dispose when cell is reused
            }
            .disposed(by: disposeBag)
        
        // Handle post selection for toggling favorites
        self.tableView.rx.modelSelected(Post.self).subscribe(onNext: { [weak self] post in
            self?.viewModel.toggleFavorite(post: post)
        })
        .disposed(by: disposeBag)
        
        // handle empty state, If no posts available
        self.viewModel.posts
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] posts in
                self?.updateEmptyState(posts.isEmpty)
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    /// Bind comments
    private func setupCommentsBinding() {
        // Observe comments relay to show comments popup
        self.viewModel.commentsRelay
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] comments in
                self?.showCommentsPopup(comments) // Display comments in popup
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Empty State Handling
    private func updateEmptyState(_ isEmpty: Bool) {
        if isEmpty {
            self.tableView.setEmptyState(Constants.emptyStateMessage)
        } else {
            self.tableView.removeEmptyState()
        }
    }
}
