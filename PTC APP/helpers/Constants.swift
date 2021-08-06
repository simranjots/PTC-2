//
//  Constants.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-03.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import Foundation

struct Constants {
    
    //MARK: -  Storyboard IDs
    struct Storyboard {
        static let homeViewController = "HomeVC"
       
    }
    
    //MARK: -  TableView and CollectionView cell identifiers
    struct CellIdentifiers {
        static let homeScreenMainTableViewCell = "homeScreenMainTableViewCell"
        static let homeScreenMenuBarCell = "menubarTableViewCell"
        static let privacyPolicyTableViewCell = "privacyPolicyVCResudableCell"
        static let instructionCollectionViewCell = "instructionsScreenCollectionViewCell"
    }
    
    //MARK: - Segue identifiers
    struct Segues {
        static let homeToProfileSegue = "navigateToProfileScreen"
        static let homeToUseInstructionsSegue = "navigateToUseInstructionScreen"
        static let homeToAboutAuthor = "navigateToAboutAuthorScreen"
        static let homeToPrivacyPolicySegue = "navigateToPrivacyPolicyScreen"
        static let homeToContactUsSegue = "navigateToContactUsScreen"
    }
}
