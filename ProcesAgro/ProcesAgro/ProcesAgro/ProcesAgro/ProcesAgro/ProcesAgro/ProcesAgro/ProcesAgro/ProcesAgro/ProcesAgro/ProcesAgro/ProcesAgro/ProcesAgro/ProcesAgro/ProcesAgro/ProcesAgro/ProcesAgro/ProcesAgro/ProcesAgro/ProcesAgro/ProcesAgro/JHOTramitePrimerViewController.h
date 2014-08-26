//
//  JHOTramitePrimerViewController.h
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 28/07/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOTramitePrimerViewController : UIViewController{
    
    IBOutlet UITextField *nombre_solicitante;
    IBOutlet UITextField *cedula_solicitante;
    IBOutlet UITextField *fijo_solicitante;
    IBOutlet UITextField *celular_solicitante;
    
}


- (IBAction)continuarTramitep2:(id)sender;

@end
