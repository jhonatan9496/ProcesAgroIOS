//
//  JHOTramiteViewController.h
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 23/07/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOTramiteViewController : UIViewController{

IBOutlet UITextField *ica_numero;
IBOutlet UITextField *textTelefono;
IBOutlet UITextField *nombre_finca;
IBOutlet UITextField *nombre_propietario;
IBOutlet UITextField *cedula_propietario;
IBOutlet UITextField *telefono_fijo_propietario;
IBOutlet UITextField *celular_propietario;
    
}
// Telefono fijo
-(IBAction)guardarTecladoFijo:(id)sender;
-(IBAction)textDownMove:(id)sender;
//Celular
-(IBAction)ReturnKeyButton:(id)sender;
-(IBAction)subeTecladoCelular:(id)sender;
//CEdulaPropietario
-(IBAction)returnKeyCedula:(id)sender;
//nombrePropietario
- (IBAction)returnkKeyPropietario:(id)sender;
//nombreFinca
- (IBAction)fincaReturnKey:(id)sender;
//ica
- (IBAction)icaKey:(id)sender;
- (IBAction)icaSubeTeclado:(id)sender;


- (IBAction)avanzarTramite1:(id)sender;


@end
