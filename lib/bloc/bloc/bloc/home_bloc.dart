import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/bloc/bloc/bloc/home_event.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore _firestore;

  HomeBloc({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(HomeInitial()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<SearchCategoriesEvent>(_onSearchCategories);
  }

  Future<void> _onFetchCategories(FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final categories = await _fetchCategories(event.serviceId);
      emit(HomeLoaded(categories: categories));
    } catch (e) {
      emit(HomeError('Failed to fetch categories: ${e.toString()}'));
    }
  }

  void _onSearchCategories(SearchCategoriesEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final loadedState = state as HomeLoaded;
      final filteredCategories = loadedState.categories
          .where((category) => category['name'].toString().toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(HomeLoaded(categories: filteredCategories, searchQuery: event.query));
    }
  }

  Future<List<Map<String, dynamic>>> _fetchCategories(String serviceId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Companycategory')
        .where('serviceId', isEqualTo: serviceId)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<dynamic> categoryData = data['categoryData'] ?? [];
      String imageUrl = categoryData.isNotEmpty ? categoryData[0]['imageUrl'] ?? '' : '';
      String id = doc.id;
      return {
        'id': id,
        'name': data['name'],
        'imageUrl': imageUrl,
      };
    }).toList();
  }
}
