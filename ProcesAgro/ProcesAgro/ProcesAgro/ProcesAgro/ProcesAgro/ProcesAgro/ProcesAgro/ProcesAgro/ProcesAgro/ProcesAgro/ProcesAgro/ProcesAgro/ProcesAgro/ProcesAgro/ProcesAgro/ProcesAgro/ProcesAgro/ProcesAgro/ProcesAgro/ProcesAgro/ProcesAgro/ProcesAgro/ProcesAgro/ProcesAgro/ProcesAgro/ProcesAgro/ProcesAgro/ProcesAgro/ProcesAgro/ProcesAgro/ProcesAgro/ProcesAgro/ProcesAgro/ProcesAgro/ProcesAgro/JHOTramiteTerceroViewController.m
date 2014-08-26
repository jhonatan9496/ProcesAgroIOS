//
//  JHOTramiteTerceroViewController.m
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 2/08/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import "JHOTramiteTerceroViewController.h"

#import "JHOAppDelegate.h"

@interface JHOTramiteTerceroViewController ()

@end

@implementation JHOTramiteTerceroViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)continuarBufalinos:(id)sender {
    
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    [appDelegate.tramiteVector addObject:menor1bufalino.text];
    [appDelegate.tramiteVector addObject:entre12bufalino.text];
    [appDelegate.tramiteVector addObject:entre23bufalino.text];
    [appDelegate.tramiteVector addObject:mayor3bufalino.text];
    

    
}
@end
