//
//  NavigationView-PhoneOnly.swift
//  SnowResorts
//
//  Created by Theós on 04/07/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
