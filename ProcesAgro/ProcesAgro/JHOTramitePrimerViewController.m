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


//----------------------------------------------------------
//           Pone el frame siempre en orientacion y 0
//----------------------------------------------------------
-(void) escondeTeclado:(NSNotification *)notification{
    
    NSDictionary *info = [notification userInfo];
    
    NSTimeInterval duracionAnimacion;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duracionAnimacion];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duracionAnimacion];
    [UIView setAnimationCurve:animationCurve];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x,0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    
}
//----------------------------------------------------------
//           Pone el frame siempre en orientacion y 0- alto teclado
//----------------------------------------------------------
-(void) muestraTeclado:(NSNotification *)notification{
    
    NSDictionary *info = [notification userInfo];
    
    NSTimeInterval duracionAnimacion;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duracionAnimacion];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duracionAnimacion];
    [UIView setAnimationCurve:animationCurve];
    
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, 0-keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    
}


- (IBAction)salirNombre:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)salirCedulaSolicitante:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)salirTelefonoFijo:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)salirCelularSolicitante:(id)sender {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(escondeTeclado:) name:UIKeyboardWillHideNotification object:nil];
    [sender resignFirstResponder];
}

- (IBAction)continuarTramitep2:(id)sender {
    
    
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    [appDelegate.tramiteVector addObject:nombre_solicitante.text];
    [appDelegate.tramiteVector addObject:cedula_solicitante.text];
    [appDelegate.tramiteVector addObject:fijo_solicitante.text];
    [appDelegate.tramiteVector addObject:celular_solicitante.text];
    
    
    NSLog(@" funciona %@",appDelegate.tramiteVector);
    
}

- (IBAction)iniciocelular:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(muestraTeclado:) name:UIKeyboardWillShowNotification object:nil];
}
@end
