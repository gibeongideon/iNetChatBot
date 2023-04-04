import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/main_model.dart';
import 'package:chatbot/services/api_service.dart';

class ModelsProvider with ChangeNotifier {
  // String currentModel = "text-davinci-003";
  String currentModel = "gpt-3.5-turbo-0301";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<MainModel> modelsList = [];

  List<MainModel> get getModelsList {
    return modelsList;
  }

  Future<List<MainModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }

//
  Future<void> webContact(String web) async {
    final uri = Uri.parse(web);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch browser';
    }
  }
}
