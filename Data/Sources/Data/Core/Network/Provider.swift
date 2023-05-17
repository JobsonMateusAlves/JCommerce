//
//  Provider.swift
//  
//
//  Created by Jobson Mateus on 16/05/23.
//

import Foundation

public class Provider {
    
    func request<V: Codable>(
        target: API,
        responseType: V.Type,
        completion: ((Result<V, Error>) -> Void)?
    ) {
        var components: URLComponents? = URLComponents(string: target.url)
        components?.queryItems = target.parameters?.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        
        guard let url = components?.url else {
            DispatchQueue.main.async {
                completion?(.failure(APIError.invalidURL))
            }
            return
        }
        
        let encoder = JSONEncoder()
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        target.headers?.forEach{ key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        if let data = target.data {
            request.httpBody = try? encoder.encode(data)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                DispatchQueue.main.async {
                    completion?(.failure(APIError.requestFailed))
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion?(.failure(APIError.requestFailed))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(V.self, from: data)
                DispatchQueue.main.async {
                    completion?(.success(response))
                }
            } catch {
                DispatchQueue.main.async {
                    completion?(.failure(APIError.invalidResponse))
                }
            }
        }
        .resume()
    }
}
