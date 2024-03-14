import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_morty/error_screen.dart';
import 'package:rick_morty/list.dart';
import 'package:rick_morty/loading_screen.dart';
import 'package:rick_morty/response_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ResponseApi? _responses;

  bool _isLoading = true;
  String _onError = '';

  @override
  void initState(){
    _fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(254, 254, 255, 1),
        appBar: AppBar(
          title: Text("Home Screen"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: _isLoading ? const LoadingScreen() 
          : _onError.isNotEmpty ? ErrorScreen(message: _onError, onPressed: () => _fetchApi(),)
          : RefreshIndicator(
            onRefresh: () => _fetchApi(),
            child: ListScreen(results: _responses!.results),
          ),
        ));
  }
  _fetchApi() async {
    setState(() {
      _isLoading = true;
      _onError = '';
    });
    final options = BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api'
    );
    final dio = Dio(options);
    // dio.get('/character').then((value){
    //   final response = value.data;
    //   final responseApi = ResponseApi.fromJson(response);
    //   setState(() {
    //     _responses = responseApi;
    //   });
    // }).catchError(onError)
    try {
      final response = await dio.get('/character');
      final responseData = response.data;
      final responseApi = ResponseApi.fromJson(responseData);

      setState(() {
        _responses = responseApi;
        _isLoading = false;
      });
    } on DioException catch (e) {
      _isLoading = false;
      _onError = e.message ?? 'Something error';
    } catch (e) {
      _isLoading = false;
      _onError = e.toString();
    }

  }
}

