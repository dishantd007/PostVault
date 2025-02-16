//
//  NetworkMonitor.swift
//  PostVault
//
//  Created by Dishant Choudhary on 16/02/25.
//

import Network
import RxSwift
import RxCocoa

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    /// Observable to detect internet status
    let isInternetAvailable = BehaviorRelay<Bool>(value: true)

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            self?.isInternetAvailable.accept(isConnected)
        }
        monitor.start(queue: queue)
    }
}
