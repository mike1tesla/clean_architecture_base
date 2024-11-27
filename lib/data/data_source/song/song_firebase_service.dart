import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_iot/data/models/song/song.dart';
import 'package:smart_iot/domain/entities/song/song.dart';
import 'package:smart_iot/domain/usecase/song/is_favorite_song.dart';

import '../../../service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();

  Future<Either> getPlayList();

  Future<Either> addOrRemoveFavoriteSong(String songId);

  Future<bool> isFavoritesSong(String songId);

  Future<Either> getUserFavoriteSong();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data =
          await FirebaseFirestore.instance.collection('Songs').orderBy('releaseDate', descending: true).limit(3).get();
      // Chuyển đổi từ docs songJson -> songModel -> songEntity
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        // check Favorite Song tu Firebase thong qua isFavoritesSong() ben duoi -> gan variable Entity.isFavorite
        bool isFavorite = await sl<IsFavoritesSongUseCase>().call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;

        print("getNewsSongs ${songModel.title.toString()} ${songModel.isFavorite.toString()} ");
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      print(e);
      return const Left("An error occurred, Please try again");
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs').orderBy('releaseDate', descending: true).get();
      // Chuyển đổi từ docs songJson -> songModel -> songEntity
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        // check Favorite Song tu Firebase thong qua isFavoritesSong() ben duoi -> gan variable Entity.isFavorite
        bool isFavorite = await sl<IsFavoritesSongUseCase>().call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        print("getPlayList ${songModel.title.toString()} ${songModel.isFavorite.toString()} ");
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      print(e);
      return const Left("An error occurred, Please try again");
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorites;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      // Hàm truy vấn tìm kiếm đã có songId trong collection Favorites chưa
      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();
      // nếu đã có thì xóa đi, còn thì thêm vào Favorites
      if (favoriteSong.docs.isNotEmpty) {
        await favoriteSong.docs.first.reference.delete();
        isFavorites = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorites = true;
      }
      return Right(isFavorites);
    } catch (e) {
      print(e);
      return const Left('An error occurred');
    }
  }

  @override
  Future<bool> isFavoritesSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      // Hàm truy vấn tìm kiếm đã có songId trong collection Favorites chưa
      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();
      // Hàm check đã có favoriteSong trong collection chưa, true = yes, false = no
      if (favoriteSong.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSong() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      List<SongEntity> favoriteSongs = [];
      // Hàm truy vấn tìm kiếm đã có songId trong collection Favorites chưa
      QuerySnapshot favoriteSnapshot =
          await firebaseFirestore.collection('Users').doc(firebaseAuth.currentUser!.uid).collection('Favorites').get();
      for (var element in favoriteSnapshot.docs) {
        String songId = element['songId'];
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();

        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        SongEntity songEntity = songModel.toEntity();

        favoriteSongs.add(songEntity);
      }
      print(favoriteSongs.length);
      return Right(favoriteSongs);
    } catch (e) {
      print(e);
      return const Left("An error occurred");
    }
  }
}
