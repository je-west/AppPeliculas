import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider{

  String _apiKey  = 'c74e5ad6b999e8b4bcb45697bdc686ec';
  String _url     = 'api.themoviedb.org';
  String _language= 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp= await http.get(url);
    final decodedData= json.decode(resp.body);

    final peliculas  = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key'   : _apiKey,
      'language'  : _language, 
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async{
    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key'   : _apiKey,
      'language'  :_language, 
      'page'      : '1'
    });

    return await _procesarRespuesta(url);
  }


}