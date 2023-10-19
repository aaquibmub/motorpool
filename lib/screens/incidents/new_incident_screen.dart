import 'package:flutter/material.dart';
import 'package:motorpool/providers/incident_provider.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/routes.dart';
import '../../helpers/common/utility.dart';
import '../../helpers/models/incidents/incident_model.dart';
import '../../widgets/incidents/new_incident_form.dart';
import '../loading_screen.dart';

class NewIncidentScreen extends StatefulWidget {
  const NewIncidentScreen({Key key}) : super(key: key);

  @override
  State<NewIncidentScreen> createState() => _NewIncidentScreenState();
}

class _NewIncidentScreenState extends State<NewIncidentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  IncidentModel _model;

  void _setModel(
    IncidentModel model,
  ) {
    _model = model;
  }

  void _showErrorDialogue(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('An error occured'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await Provider.of<IncidentProvider>(
        context,
        listen: false,
      ).createIncident(
        _model,
      );

      setState(() {
        _isLoading = false;
      });

      if (response.hasError) {
        _showErrorDialogue(context, response.msg);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      const errorMessage = 'Error';
      _showErrorDialogue(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Widget buildSubmitButton() {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor)),
        onPressed: () => _submit(context),
        child: Text(
          'REPORT INCIDENT',
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        // elevation: 0,
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Incident',
        ),
      ),
      drawer: Utility.buildDrawer(context),
      body: _isLoading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  height: deviceSize.height,
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Center(
                                    child: Text(
                                      'Report new Incident',
                                    ),
                                  ),
                                ),
                                NewIncidentForm(
                                  _formKey,
                                  _setModel,
                                  _submit,
                                  context,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (Utility.isPhone(deviceSize))
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: buildSubmitButton(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
