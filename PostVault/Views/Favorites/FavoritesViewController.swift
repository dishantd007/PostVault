//
//  FavoritesViewController.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStatelabel: UILabel!
    
    // MARK: - Dependencies
    /// View model for posts
    private let viewModel = PostViewModel()
    /// Dispose bag for Memory management 
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableViewBinding()
        self.setupCommentsBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.refreshFavorites() // Reload favorites whenever the screen appears
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Register custom cell
        let nib = UINib(nibName: Constants.CellIdentifier.postTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.CellIdentifier.postTableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    // MARK: - Bindings Setup
    private func setupTableViewBinding() {
        // Bind favorites list to table view
        viewModel.favorites
            .bind(to: tableView.rx.items(cellIdentifier: Constants.CellIdentifier.postTableViewCell, cellType: PostTableViewCell.self)) { row, post, cell in
                cell.updateUI(with: post)
                
                // Subscribe to cell's commentTapped event
                cell.commentTapped.subscribe(onNext: { [weak self] postId in
                    self?.viewModel.fetchComments(for: postId)
                })
                .disposed(by: cell.disposeBag) // Dispose when cell is reused
            }
            .disposed(by: disposeBag)
        
        // Handle swipe-to-delete functionality
        tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            self.removeFavorite(at: indexPath)
        })
        .disposed(by: disposeBag)
        
        // handle empty state
        viewModel.favorites
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] posts in
                self?.updateEmptyState(posts.isEmpty)
            })
            .disposed(by: disposeBag)
    }
    
    /// Bind comments
    private func setupCommentsBinding() {
        // Observe comments relay to show comments popup
        viewModel.commentsRelay
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] comments in
                self?.showCommentsPopup(comments) // Display comments in popup
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helper Methods
    /// Removes a favorite post at the specified index path
    /// - Parameter indexPath: The index path of the post to be removed
    private func removeFavorite(at indexPath: IndexPath) {
        let favorites = viewModel.favorites.value
        let post = favorites[indexPath.row]
        
        viewModel.toggleFavorite(post: post) // Toggle favorite state in database
        viewModel.refreshFavorites() // Refresh list after removal
    }
    
    // MARK: - Empty State Handling
    private func updateEmptyState(_ isEmpty: Bool) {
        if isEmpty {
            tableView.setEmptyState(Constants.emptyStateMessage)
        } else {
            tableView.removeEmptyState()
        }
    }
}
