import Foundation
import os

protocol ApiProvider{
    func fetchMovies(completion: @escaping (Result<Movies, Error>) -> Void)
    func fetchDetails(id: Int, completion: @escaping (Result<Details, Error>) -> Void)
    func fetchImg(path: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class ApiProviderImpl: ApiProvider{
    private let logger: Logger
    
    init(logger: Logger) {
        self.logger = logger
    }
    
    func fetchMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
        self.execute(
            urlString: Endpoints.baseUrl + "now_playing",
            httpMethod: HttpMethods.GET,
            expectingType: Movies.self,
            completion: completion
        )
    }
    
    func fetchDetails(id: Int, completion: @escaping (Result<Details, Error>) -> Void) {
        self.execute(
            urlString: Endpoints.baseUrl + "\(id)",
            httpMethod: HttpMethods.GET,
            expectingType: Details.self,
            completion: completion
        )
    }
    
    func fetchImg(path: String, completion: @escaping (Result<Data, Error>) -> Void){
        guard let url = URL(string: Endpoints.imgPath + path) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let req = URLRequest(url: url)
        URLSession.shared.dataTask(with: req){ data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    private func execute<T:Codable>(
        urlString: String,
        httpMethod: HttpMethods,
        expectingType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiProviderError.failedToCreateURL))
            self.logger.fault("\(ApiProviderError.failedToCreateURL)")
            return
        }
        guard let req = self.request(url: url, httpMethod: httpMethod) else {
            completion(.failure(ApiProviderError.failedToCreateRequest))
            self.logger.fault("\(ApiProviderError.failedToCreateRequest)")
            return
        }
        self.logger.info("\(req)")
        URLSession.shared.dataTask(with: req){ data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiProviderError.failedToFetchData))
                self.logger.fault("\(error ?? ApiProviderError.failedToFetchData)")
                return
            }
            do{
                let result = try JSONDecoder().decode(expectingType, from: data)
                completion(.success(result))
//                self.logger.info("\(result)")
            }catch{
                completion(.failure(error))
                self.logger.fault("\(error)")
            }
        }.resume()
    }
    
    private func request(url: URL, httpMethod: HttpMethods) -> URLRequest?{
        let urlWithParam = url.appending(queryItems: [
            URLQueryItem(name: "language", value: "ru"),
            URLQueryItem(name: "api_key", value: apiKey)
        ])
        var req = URLRequest(url: urlWithParam)
        req.httpMethod = httpMethod.rawValue
        return req
    }
    
    private enum HttpMethods: String{
        case GET
        case POST
    }
}

enum ApiProviderError: Error{
    case failedToCreateRequest
    case failedToCreateURL
    case failedToFetchData
}
