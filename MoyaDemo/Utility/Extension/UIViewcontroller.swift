//
//  UIViewcontroller.swift
//  MoyaDemo

import Foundation
import UIKit

extension UIViewController {
    
    static var activityIndicatorTag = 12345

    func startLoading() {
        stopLoading()
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.tag = UIViewController.activityIndicatorTag
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large

        DispatchQueue.main.async {
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }

    func stopLoading() {
        let activityIndicator = view.viewWithTag(UIViewController.activityIndicatorTag) as? UIActivityIndicatorView
        DispatchQueue.main.async {
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
        }
    }
}
