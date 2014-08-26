//
//  JHOCeldaPasosOfertaTableViewCell.h
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 10/08/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHOCeldaPasosOfertaTableViewCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UILabel *tituloPaso;
@property (nonatomic,retain) IBOutlet UISwitch *check;
@property (weak, nonatomic) IBOutlet UILabel *desPaso;

@end
