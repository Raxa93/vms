// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../data/models/brewry_model.dart';
import '../../configurations/size_config.dart';
import '../../constants/app_styles.dart';

class BreweryDetailView extends StatelessWidget {
  static const routeName = 'brewery_detail_screen';
  BreweryModel brewerModel;
   BreweryDetailView({Key? key,required this.brewerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
        Text('Brewery Detail',style: AppStyle.headline1,),
          Text('Name: ${brewerModel.name}',style: AppStyle.bodyText1),
          Text('Phone: ${brewerModel.phone}',style: AppStyle.bodyText1),
          Text('City: ${brewerModel.city}',style: AppStyle.bodyText1),
          Text('Address: ${brewerModel.address2}',style: AppStyle.bodyText1),
          Text('Province: ${brewerModel.countyProvince}',style: AppStyle.bodyText1),
          Text('State: ${brewerModel.state}',style: AppStyle.bodyText1),
          Text('Type: ${brewerModel.breweryType}',style: AppStyle.bodyText1),
        ],
      ),
    );
  }
}
