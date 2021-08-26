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
        static let instructionTableViewCell = "instructionsCell"
    }
    
    //MARK: - Segue identifiers
    struct Segues {
        static let signInToHomeSegue = "navigateToHome"
        static let signUpToHomeSegue = "navigateToHome"
        static let forgotPasswordSegue = "forgotPasswordSegue"
        static let signUpSegue = "signUpSegue"
        static let homeToProfileSegue = "navigateToProfileScreen"
        static let homeToUseInstructionsSegue = "navigateToUseInstructionScreen"
        static let homeToAboutAuthor = "navigateToAboutAuthorScreen"
        static let homeToPrivacyPolicySegue = "navigateToPrivacyPolicyScreen"
        static let homeToContactUsSegue = "navigateToContactUsScreen"
        static let homeToSituationSegue = "situationView"
    }
    
    struct Colors {
        static let brandBlueColor = "BrandBlueColor"
        static let brandPurpleColor = "BrandPurpleColor"
        static let brandRedColor = "BrandRedColor"
        static let brandColor = "BrandColor"
        static let purple = "purple"
        
    }
}
