import 'package:get/get.dart';

class LocalString extends Translations {
  Map<String, Map<String, String>> get keys => {
        'en_US': {'LOGIN': 'Login', 'Register': 'Register', 'Home': 'Home'},
        'amh_Amh': {'LOGIN': 'ግባ', 'Register': 'ይመዝገቡ', 'Home': 'መግቢያ'},
        'af_Af': {
          'LOGIN': 'Seensaa',
          'Register': 'Na Galmeessi',
          'Home': 'Galmee'
        },
        'tig_Tig': {'LOGIN': 'መእተዊ', 'Register': 'ምዝገባ'},
        'som_Som': {'LOGIN': 'gelid', 'Register': 'Is diwaangeli'}
      };
}
