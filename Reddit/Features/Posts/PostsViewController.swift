//
//  PostsViewController.swift
//  Reddit
//
//  Created by Sebastian on 25/09/24.
//

import UIKit
import Combine

class PostsViewController: UIViewController {
    
    // MARK: Properties
    
    private let tableView = UITableView()
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    
    private let viewModel: PostsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Popular posts"
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupLoadingView()
        setupErrorView()
        setupBindings()
        viewModel.handleAction(.loadPosts)
    }
    
    private func setupLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isHidden = true
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupErrorView() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.isHidden = true
        
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewState in
                self?.handleViewState(viewState)
            }
            .store(in: &cancellables)
    }
    
    private func handleViewState(_ viewState: PostsViewModel.ViewState) {
        switch viewState {
        case .loading:
            showLoadingState()
        case .error:
            showErrorState()
        case .loaded:
            showLoadedState()
        }
    }
    
    private func showLoadingState() {
        loadingView.startLoading()
        loadingView.isHidden = false
        tableView.isHidden = true
        errorView.isHidden = true
    }
    
    private func showErrorState() {
        loadingView.stopLoading()
        errorView.isHidden = false
        loadingView.isHidden = true
        tableView.isHidden = true
    }
    
    private func showLoadedState() {
        loadingView.stopLoading()
        tableView.isHidden = false
        loadingView.isHidden = true
        errorView.isHidden = true
        tableView.reloadData()
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case let .loaded(posts) = viewModel.viewState else {
            return 0
        }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let .loaded(posts) = viewModel.viewState, let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        
        let post = posts[indexPath.row]
        cell.configure(with: post) { [weak self] in
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.handleAction(.onPostSelected(indexPath.row))
    }
}
