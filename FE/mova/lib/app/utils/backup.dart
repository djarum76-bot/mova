// Future<void> getTop1Favorite(BuildContext context, int filmId)async{
//   final isConnect = await CheckUserConnection();
//   if(isConnect){
//     try{
//       final response = await dio.get("/auth/favorite/$filmId",
//           options: Dio.Options(
//               headers: {
//                 "Accept" : "application/json",
//                 "Authorization" : "bearer ${box.read(Constant.token)}"
//               }
//           )
//       );
//
//       final data = response.data;
//
//       if(response.statusCode == 200){
//         modelC.favorite(FavoriteModel.fromJson(data));
//         modelC.favorite.refresh();
//
//         favoriteLength.value = modelC.favorite.value.data!.length;
//         favoriteLength.refresh();
//       }
//     }on Dio.DioError catch(e){
//       ErrorMessageExit(context, e.message);
//     }catch(e){
//       ErrorMessageExit(context, e.toString());
//     }
//   }else{
//     ErrorMessage(context, "No Internet Connection");
//   }
// }
//
// Future<void> addFavorite(BuildContext context, int filmId, String thumbnail, String title, double rating, String category, String tipe)async{
//   try{
//     loadingFavorite.value = true;
//
//     Dio.FormData formData = Dio.FormData.fromMap({
//       "film_id" : filmId,
//       "thumbnail" : thumbnail,
//       "title" : title,
//       "rating" : rating,
//       "category" : category,
//       "tipe" : tipe,
//       "createdAt" : DateTime.now().toIso8601String()
//     });
//
//     final response = await dio.post('/auth/favorite',
//         data: formData,
//         options: Dio.Options(
//             headers: {
//               "Accept" : "application/json",
//               "Authorization" : "bearer ${box.read(Constant.token)}"
//             }
//         )
//     );
//
//     if(response.statusCode == 200){
//       await getTop1Favorite(context, filmId);
//     }else{
//       ErrorMessageExit(context, response.statusMessage!);
//     }
//
//     loadingFavorite.value = false;
//   }on Dio.DioError catch(e){
//     ErrorMessageExit(context, e.toString());
//   }
// }
//
// Future<void> deleteFavorite(BuildContext context, int id, int filmId)async{
//   final isConnect = await CheckUserConnection();
//   if(isConnect){
//     try{
//       loadingFavorite.value = true;
//
//       final response = await dio.delete("/auth/favorite/$id",
//           options: Dio.Options(
//               headers: {
//                 "Accept" : "application/json",
//                 "Authorization" : "bearer ${box.read(Constant.token)}"
//               }
//           )
//       );
//
//       final data = response.data;
//
//       if(response.statusCode == 200){
//         await getTop1Favorite(context, filmId);
//         print("1");
//       }else{
//         print("2");
//       }
//
//       loadingFavorite.value = false;
//     }on Dio.DioError catch(e){
//       ErrorMessageExit(context, e.message);
//     }catch(e){
//       ErrorMessageExit(context, e.toString());
//     }
//   }else{
//     ErrorMessage(context, "No Internet Connection");
//   }
// }