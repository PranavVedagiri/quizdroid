//
// Copyright 2014-2018 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Amazon Software License (the "License").
// You may not use this file except in compliance with the
// License. A copy of the License is located at
//
//     http://aws.amazon.com/asl/
//
// or in the "license" file accompanying this file. This file is
// distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, express or implied. See the License
// for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import AWSCognitoIdentityProvider

let CognitoIdentityUserPoolRegion: AWSRegionType = .USWest2
let CognitoIdentityUserPoolId = "us-west-2_wi0oLAGG2"
let CognitoIdentityUserPoolAppClientId = "77vo86cedan1e4u10antufagr2"
let CognitoIdentityUserPoolAppClientSecret = "18oca9eo9qfm54n093bui89e8bomstdqph02j95v2n5uomo92f7q"

//let AWSCognitoUserPoolsSignInProviderKey = "UserPool"
let AWSCognitoUserPoolsSignInProviderKey = "Dev"


struct Constants {
    // MARK: TMDB Response Keys
    struct ResponseKeys {
        static let PlaceName = "PlaceName"
        static let PlaceId = "PlaceId"
        static let Types = "Types"
        static let Rating = "Rating"
        static let ImageLink = "s3Link"
        
    }
    
    struct GoogleAPI {
        static let GoogleAPIKey = "AIzaSyCwwd_oXx1E24055EtixaZmznFX3dv-cKQ"
    }
    struct URL {
        static let SearchPlacesTextURL = "https://jw81psa4qk.execute-api.us-west-2.amazonaws.com/testing/places-search-cache/"
        
        static let searchLocaitonTextURL = "https://jw81psa4qk.execute-api.us-west-2.amazonaws.com/testing/places/"
        static let searchInterestTextURl = "https://jw81psa4qk.execute-api.us-west-2.amazonaws.com/testing/places-search-cache/"
        
        static let searchPlaceTextURL = "https://jw81psa4qk.execute-api.us-west-2.amazonaws.com/testing/places/"
    }
    
    
}



