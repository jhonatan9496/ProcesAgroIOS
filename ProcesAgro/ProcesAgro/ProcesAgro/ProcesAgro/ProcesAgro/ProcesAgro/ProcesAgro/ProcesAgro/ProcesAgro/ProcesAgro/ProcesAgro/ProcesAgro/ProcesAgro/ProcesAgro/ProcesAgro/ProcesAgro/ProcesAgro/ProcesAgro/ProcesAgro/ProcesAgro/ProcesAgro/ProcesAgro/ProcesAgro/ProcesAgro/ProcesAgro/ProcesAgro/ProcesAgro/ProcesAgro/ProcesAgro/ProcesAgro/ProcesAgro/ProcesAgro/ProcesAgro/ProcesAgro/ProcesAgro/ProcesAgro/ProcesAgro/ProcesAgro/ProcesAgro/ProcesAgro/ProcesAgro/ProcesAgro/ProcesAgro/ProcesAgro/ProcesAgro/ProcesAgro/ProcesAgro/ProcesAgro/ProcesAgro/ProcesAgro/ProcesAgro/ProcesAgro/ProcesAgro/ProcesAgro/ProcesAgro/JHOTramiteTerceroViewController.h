//
//  JHOTramiteTerceroViewController.h
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 2/08/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOTramiteTerceroViewController : UIViewController{
    
    IBOutlet UITextField *menor1bufalino;
    IBOutlet UITextField *entre12bufalino;
    IBOutlet UITextField *entre23bufalino;
    IBOutlet UITextField *mayor3bufalino;
    
}

- (IBAction)continuarBufalinos:(id)sender;

@end
