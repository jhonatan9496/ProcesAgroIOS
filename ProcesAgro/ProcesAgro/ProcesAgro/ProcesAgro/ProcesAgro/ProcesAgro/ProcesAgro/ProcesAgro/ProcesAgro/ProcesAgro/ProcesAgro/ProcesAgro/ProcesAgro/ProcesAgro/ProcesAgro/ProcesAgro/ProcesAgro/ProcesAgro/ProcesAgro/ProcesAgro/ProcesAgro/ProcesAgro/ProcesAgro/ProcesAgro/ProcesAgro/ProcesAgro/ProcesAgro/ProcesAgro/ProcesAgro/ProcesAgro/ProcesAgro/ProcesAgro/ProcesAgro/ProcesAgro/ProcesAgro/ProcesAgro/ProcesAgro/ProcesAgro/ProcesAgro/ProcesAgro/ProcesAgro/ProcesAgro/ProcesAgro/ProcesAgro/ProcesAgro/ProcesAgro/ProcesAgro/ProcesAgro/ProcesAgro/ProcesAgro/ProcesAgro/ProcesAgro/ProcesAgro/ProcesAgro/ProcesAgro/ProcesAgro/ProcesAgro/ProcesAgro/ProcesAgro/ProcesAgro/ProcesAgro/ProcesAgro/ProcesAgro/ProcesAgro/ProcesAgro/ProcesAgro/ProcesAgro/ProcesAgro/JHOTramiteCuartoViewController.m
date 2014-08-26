//
//  JHOTramiteCuartoViewController.m
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 4/08/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import "JHOTramiteCuartoViewController.h"

#import "JHOAppDelegate.h"

@interface JHOTramiteCuartoViewController ()

@end

@implementation JHOTramiteCuartoViewController

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

- (IBAction)tramiteCuarto:(id)sender {
    
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    [appDelegate.tramiteVector addObject:primeraVez.text];
    [appDelegate.tramiteVector addObject:nacimiento.text];
    [appDelegate.tramiteVector addObject:compra.text];
    [appDelegate.tramiteVector addObject:perdidaDIN.text];
}
@end
