//
//  LocationViewController.m
//  NSCoderApp
//
//  Created by Daniel Vela on 12/04/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController
@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  [self setMapView];
  [self setConstraints];
  [self setPlacemarkInLocation];

  [self setTitle:@"Meeting point"];
}

- (void)setPlacemarkInLocation {
  CLLocationCoordinate2D coordinate = {self.location.latitude,
                                        self.location.longitude};

  MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
  point.coordinate = coordinate;
  point.title = self.location.address;

  [self.mapView addAnnotation:point];


  MKCoordinateRegion region;
  region.center = coordinate;
  region.span = MKCoordinateSpanMake(0.01,0.01);
  [self.mapView setRegion:region];
}

- (void)setConstraints {
  NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(mapView);

  NSArray* constraint1 = [NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:|[mapView]|"
                          options:0
                          metrics:nil
                          views:viewDictionary];
  NSArray* constraint2 = [NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"H:|[mapView]|"
                          options:0
                          metrics:nil
                          views:viewDictionary];
  [self.view addConstraints:constraint1];
  [self.view addConstraints:constraint2];

}
- (void)setMapView {
  if (self.mapView == nil) {
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.mapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    [self.view addSubview:self.mapView];
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
