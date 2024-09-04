import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        coordinator = MainCoordinator(navigationController: UINavigationController())
        
        window = UIWindow(windowScene: windowScene)
        coordinator?.start()
        window?.makeKeyAndVisible()
        window?.rootViewController = coordinator?.navigationController
    }
}

