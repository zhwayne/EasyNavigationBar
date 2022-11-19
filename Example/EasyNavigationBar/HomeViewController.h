//
//  EASViewController.h
//  EasyNavigationBar
//
//  Created by iya on 11/18/2022.
//  Copyright (c) 2022 iya. All rights reserved.
//

@import UIKit;
@import EasyNavigationBar;

#define USE_EAS_NAVIGATIOB_BAR

#ifdef USE_EAS_NAVIGATIOB_BAR
@interface HomeViewController : EASViewController
#else
@interface HomeViewController : UIViewController
#endif
@end
