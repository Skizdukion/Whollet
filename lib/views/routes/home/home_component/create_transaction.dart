import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/global/constant/error.dart';
import 'package:whollet/logic/bloc/new_transaction/new_transaction_bloc.dart';
import 'package:whollet/logic/bloc/new_transaction/new_transaction_event.dart';
import 'package:whollet/logic/bloc/new_transaction/new_transaction_state.dart';
import 'package:whollet/logic/repository/user_repository.dart';
import 'package:whollet/routing/routes.dart';
import 'package:whollet/widget/custom_button.dart';
import 'package:whollet/logic/utils/extensions/string_extension.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({ Key? key }) : super(key: key);

  @override
  _CreateTransactionState createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewTransBloc>(
      create: (_) => NewTransBloc(),
      child: CreateTransactionForm(),
    );
  }

}

class CreateTransactionForm extends StatefulWidget {
  const CreateTransactionForm({ Key? key }) : super(key: key);

  @override
  _CreateTransactionFormState createState() => _CreateTransactionFormState();
}

class _CreateTransactionFormState extends State<CreateTransactionForm> {

  TextEditingController _icxBalanceController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  ValueNotifier<String> error = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewTransBloc, NewTransState>(
      listener: (context, state) async{
        error.value = '';
        if (state is TransFailed){
          error.value = state.errorString;
        }
        if (state is VerifyPinTrans) {
          var result = await Navigator.pushNamed(context, Routes.verifyPinRoute);
          if(result == true)  BlocProvider.of<NewTransBloc>(context).add(Transfer(email: _emailController.text, icxBalance: double.parse(_icxBalanceController.text)));
        }
        if (state is TransSuccess){
          Navigator.pop(context, true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 300,
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                "Transfer ICX",
                style: TextStyle(fontSize: 25),
              ),
              Container(
                child: TextFormField(    
                  keyboardType: TextInputType.number,
                  controller: _icxBalanceController,
                  decoration: InputDecoration(
                      hintText: 'Enter ICX', labelText: 'Enter ICX'),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Enter email destination',
                      labelText: 'Enter email destination'),
                ),
              ),
              ValueListenableBuilder<String>(valueListenable: error, builder: (context, bool, child) {
                return Text(error.value, style: TextStyle(color: Colors.red),);
              }),
              SizedBox(height: 30),
              CustomButton(
                onPress: (){
                  createTrans();
                },
                text: 'Done',
                outline: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createTrans() async{
    NewTransBloc bloc = BlocProvider.of<NewTransBloc>(context);
    double? _icxBalance = double.tryParse(_icxBalanceController.text);
    if (_icxBalanceController.text.isEmpty){
      bloc.add(Failed(errorString: ErrorString.emptyBalance));
      return;
    }
    if (_emailController.text.isEmpty){
      bloc.add(Failed(errorString: ErrorString.emptyEmailAddress));
      return;
    }
    if (!_emailController.text.isValidEmail()){
      bloc.add(Failed(errorString: ErrorString.unvalidEmailAddress));
      return;
    }
    if (_emailController.text == FirebaseUserRepository.userId){
      bloc.add(Failed(errorString: ErrorString.sameEmailWithUser));
      return;
    }
    if (_icxBalance == null){
      bloc.add(Failed(errorString: ErrorString.unvalidFormatBalance));
      return;
    }
    bloc.add(VerifyTrans(email: _emailController.text, icxBalance: _icxBalance));
  }
}