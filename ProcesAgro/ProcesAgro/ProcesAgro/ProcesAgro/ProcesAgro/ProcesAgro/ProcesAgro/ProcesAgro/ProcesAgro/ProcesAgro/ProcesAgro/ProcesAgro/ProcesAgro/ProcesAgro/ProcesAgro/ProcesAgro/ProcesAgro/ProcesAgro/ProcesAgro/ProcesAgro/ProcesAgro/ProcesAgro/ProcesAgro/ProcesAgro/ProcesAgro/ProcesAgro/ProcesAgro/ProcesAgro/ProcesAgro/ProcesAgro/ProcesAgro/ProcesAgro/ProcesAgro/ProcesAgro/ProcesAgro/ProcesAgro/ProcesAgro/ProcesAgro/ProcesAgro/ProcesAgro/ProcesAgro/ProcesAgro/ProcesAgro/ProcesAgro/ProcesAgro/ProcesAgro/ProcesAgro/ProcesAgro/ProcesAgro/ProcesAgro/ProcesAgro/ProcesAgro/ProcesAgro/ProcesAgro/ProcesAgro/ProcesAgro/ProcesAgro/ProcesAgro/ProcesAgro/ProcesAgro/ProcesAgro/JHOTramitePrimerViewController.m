//
//  JHOTramitePrimerViewController.m
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 28/07/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import "JHOTramitePrimerViewController.h"

#import "JHOAppDelegate.h"

@interface JHOTramitePrimerViewController ()

@end

@implementation JHOTramitePrimerViewController

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

- (IBAction)continuarTramitep2:(id)sender {
    
    
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    [appDelegate.tramiteVector addObject:nombre_solicitante.text];
    [appDelegate.tramiteVector addObject:cedula_solicitante.text];
    [appDelegate.tramiteVector addObject:fijo_solicitante.text];
    [appDelegate.tramiteVector addObject:celular_solicitante.text];
    
    
    NSLog(@" funciona %@",appDelegate.tramiteVector);
    
}
@end
