import UIKit

class ImageFetcher {
    private var currentTasks: [URL: URLSessionDataTask] = [:]
    static let shared = ImageFetcher()
    private var imageCache: NSCache<NSURL, UIImage> = NSCache()
    let session = URLSession.shared
    
    func fetch(url: URL, _ completionHandler: @escaping (Result<UIImage, ErrorMessages>) -> Void) {
        if let image = imageCache.object(forKey: url as NSURL) {
            completionHandler(.success(image))
        } else {
            let task = session.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    self?.imageCache.setObject(image, forKey: url as NSURL)
                    completionHandler(.success(image))
                } else {
                    completionHandler(.failure(.invalidData))
                }
            }
            currentTasks[url] = task
            task.resume()
        }
    }
    
    func cancel(url: URL) {
        currentTasks[url]?.cancel()
        currentTasks[url] = nil
    }
}
