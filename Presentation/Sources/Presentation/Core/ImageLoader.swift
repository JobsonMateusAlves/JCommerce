//
//  ImageLoader.swift
//  
//
//  Created by Jobson Mateus on 19/05/23.
//

import UIKit

class ImageLoader {
    
    private var task: URLSessionDataTask?
    
    func loadImage(with url: URL, placeholder: UIImage? = nil, completion: @escaping (UIImage?) -> Void) {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let imageData = cache.cachedResponse(for: request)?.data {
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
            return
        }
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("🏞️ ImageLoaderError: \(error.localizedDescription)")
                return
            }
            
            guard let imageData = data else { return }
            
            if let response = response {
                let cachedData = CachedURLResponse(response: response, data: imageData)
                cache.storeCachedResponse(cachedData, for: request)
            }
            
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
