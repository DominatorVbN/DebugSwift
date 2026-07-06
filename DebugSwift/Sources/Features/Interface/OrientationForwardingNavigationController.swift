//
//  OrientationForwardingNavigationController.swift
//  DebugSwift
//
//  Created by Samant, Amit on 6/7/26.
//


import UIKit

final class OrientationForwardingNavigationController: UINavigationController {

    private var appRootViewController: UIViewController? {
        let appWindows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .filter { window in
                let windowClassName = String(describing: type(of: window))
                return windowClassName != "UITextEffectsWindow"
                    && windowClassName != "UIRemoteKeyboardWindow"
                    && window.windowLevel < UIWindow.Level.alert
            }
        return (appWindows.first(where: \.isKeyWindow) ?? appWindows.first)?
            .rootViewController
    }

    override var shouldAutorotate: Bool {
        appRootViewController?.shouldAutorotate ?? super.shouldAutorotate
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        appRootViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        appRootViewController?.preferredInterfaceOrientationForPresentation
            ?? super.preferredInterfaceOrientationForPresentation
    }

    @available(iOS 26.0, *)
    override var prefersInterfaceOrientationLocked: Bool {
        appRootViewController?.prefersInterfaceOrientationLocked
            ?? super.prefersInterfaceOrientationLocked
    }
}
