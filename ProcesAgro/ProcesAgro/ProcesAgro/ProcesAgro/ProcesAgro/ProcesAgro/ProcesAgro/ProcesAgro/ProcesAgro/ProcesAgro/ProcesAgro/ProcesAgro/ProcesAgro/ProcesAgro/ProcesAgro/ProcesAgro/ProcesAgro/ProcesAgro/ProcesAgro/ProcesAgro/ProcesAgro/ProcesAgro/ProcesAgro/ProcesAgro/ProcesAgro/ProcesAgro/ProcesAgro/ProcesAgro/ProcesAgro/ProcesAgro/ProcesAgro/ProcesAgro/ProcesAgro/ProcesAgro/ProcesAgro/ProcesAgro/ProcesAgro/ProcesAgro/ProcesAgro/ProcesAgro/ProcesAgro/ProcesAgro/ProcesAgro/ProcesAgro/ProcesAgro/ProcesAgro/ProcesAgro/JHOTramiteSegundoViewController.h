//
//  JHOTramiteSegundoViewController.h
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 2/08/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOTramiteSegundoViewController : UIViewController{
    
    IBOutlet UITextField *menor1;
    IBOutlet UITextField *entre1y2;
    IBOutlet UITextField *entre2y3;
    IBOutlet UITextField *masde3;
}

- (IBAction)continuarSegundo:(id)sender;
@end
