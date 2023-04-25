
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';
import '../../components/intimation_dialogs.dart';
import '../../configurations/size_config.dart';
import 'brewery_vm.dart';
import 'brewr_detail.dart';

class BreweryMainView extends StatefulWidget {
  static const routeName = 'brewery_screen';
  const BreweryMainView({Key? key}) : super(key: key);

  @override
  State<BreweryMainView> createState() => _BreweryMainViewState();
}

class _BreweryMainViewState extends State<BreweryMainView> {


  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BreweryVm>(context,listen: false).fetchBreweryList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Consumer<BreweryVm>(
        builder: (context, vm, _) {
      switch (vm.breweryResponse.status) {
        case Status.LOADING:
          return  Center(child: UserIntimationWidgets.getProgressIndicator());
        case Status.ERROR:
          return Text(vm.breweryResponse.message.toString());
        case Status.COMPLETED:
          return ListView.builder(
               itemCount: vm.breweryList.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                   leading: Text(index.toString()),
                   title: Text(vm.breweryList[index].name.toString()),
                   subtitle: Text(vm.breweryList[index].phone.toString()),
                    onTap: (){
                      Navigator.pushNamed(context, BreweryDetailView.routeName, arguments: vm.breweryList[index]);
                    },
                  ),
                );
              });
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [],
      );
    },
    ));
  }
}
