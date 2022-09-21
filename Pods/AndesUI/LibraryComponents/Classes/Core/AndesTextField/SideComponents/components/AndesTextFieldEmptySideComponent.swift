//
//  AndesTextFieldEmptySideComponent.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 13/07/21.
//

import Foundation

class AndesTextFieldEmptySideComponent: AndesTextFieldRightComponent, AndesTextFieldLeftComponent {
    var visibility: AndesTextFieldComponentVisibility = .whenNotEmpty
    var reloadPolicy: AndesTextFieldComponentReloadPolicy = .onlyOneTime
}
