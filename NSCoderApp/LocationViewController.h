//
//  LocationViewController.h
//  NSCoderApp
//
//  Created by Daniel Vela on 12/04/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController

@property (nonatomic, strong) BBLocation *location;
@property (nonatomic, strong) MKMapView *mapView;

@end
