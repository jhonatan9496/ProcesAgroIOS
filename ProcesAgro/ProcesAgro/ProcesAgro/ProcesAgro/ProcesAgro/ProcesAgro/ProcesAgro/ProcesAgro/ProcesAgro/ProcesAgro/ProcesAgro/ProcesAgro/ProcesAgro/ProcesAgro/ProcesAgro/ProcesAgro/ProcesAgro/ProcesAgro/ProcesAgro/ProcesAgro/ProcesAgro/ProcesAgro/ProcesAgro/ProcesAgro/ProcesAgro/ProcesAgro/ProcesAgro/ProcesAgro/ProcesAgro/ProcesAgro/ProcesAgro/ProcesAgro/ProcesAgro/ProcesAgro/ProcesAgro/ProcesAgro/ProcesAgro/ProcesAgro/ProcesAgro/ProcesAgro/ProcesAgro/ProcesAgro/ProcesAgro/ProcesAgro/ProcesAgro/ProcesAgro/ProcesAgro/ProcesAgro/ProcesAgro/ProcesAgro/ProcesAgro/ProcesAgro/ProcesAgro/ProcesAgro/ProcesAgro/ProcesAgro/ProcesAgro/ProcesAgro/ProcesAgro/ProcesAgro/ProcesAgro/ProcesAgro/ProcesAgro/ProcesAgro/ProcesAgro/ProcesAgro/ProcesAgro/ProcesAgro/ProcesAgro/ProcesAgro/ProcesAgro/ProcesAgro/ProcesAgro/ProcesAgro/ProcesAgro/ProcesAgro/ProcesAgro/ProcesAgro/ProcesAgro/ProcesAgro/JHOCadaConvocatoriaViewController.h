//
//  JHOCadaConvocatoriaViewController.h
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 9/08/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOCadaConvocatoriaViewController : UIViewController{

}
//Retiene valores de la vista
@property (nonatomic, strong) NSString *textTituloConvocatoria;
@property (nonatomic, strong) NSString *textDeescripcionConvocatoria;
@property (nonatomic, strong) NSString *textLinkConvocatoria;
// Datos de la convocatoria para asignar valores
@property (weak, nonatomic) IBOutlet UILabel *tituloCadaConvocatoria;
@property (weak, nonatomic) IBOutlet UILabel *descripcionCadaConvocatoria;
@property (weak, nonatomic) IBOutlet UIButton *linkCadaConvocatoria;

@end
