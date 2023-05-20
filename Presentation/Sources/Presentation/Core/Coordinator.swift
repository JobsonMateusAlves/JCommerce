//
//  File.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var finish: (() -> Void)? { get set }
    
    func start()
}
