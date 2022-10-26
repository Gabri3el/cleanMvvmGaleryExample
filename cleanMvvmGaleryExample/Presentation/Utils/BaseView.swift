//
//  baseView.swift
//  cleanMvvmGaleryExample
//
//  Created by Gabriel Merino Dos Santos - GMS on 24/10/22.
//

import Foundation

protocol BaseView: AnyObject {
    func buildHierarchy()
    func buildConstraints()
    func additionalSetup()
    func buildViewCode()
}

extension BaseView {
    func buildViewCode() {
        buildHierarchy()
        buildConstraints()
        additionalSetup()
    }

    func additionalSetup() {}
}
