import UIKit

extension UIViewController {

    static var storyboard: UIStoryboard {

        return UIStoryboard(name: "\(self)", bundle: Bundle(for: self))
    }

    class func instantiate() -> Self {

        return viewController(viewControllerClass: self)
    }

    var navEmbedded: UINavigationController {

        return UINavigationController(rootViewController: self)
    }

    private static func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {

        guard let scene = storyboard.instantiateInitialViewController() as? T
        else { fatalError("Could not find storyboard named: \(self) with initial view controller set.") }

        return scene
    }
}
