import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'database13.db'),
      onCreate: (db, version) async {
        await db.execute(
            '''
        CREATE TABLE geocordinates (
          lat TEXT,
          long TEXT,
          distance TEXT,
          givenlat TEXT,
          givenlong TEXT,
          msg TEXT
        )
        '''
        );
        await db.execute(
            '''
  CREATE TABLE checkinrecord (
    checkintime TEXT,
    lat TEXT,
    long TEXT,
    date TEXT,
    time TEXT,
    target_lat TEXT,
    target_long TEXT
    
  )
  '''
        );

      },
      version: 1,
    );
  }
  Future<void> delete() async {
    final Database db = await database;
    await db.delete('checkinrecord',);
  }
  Future<void> insercheckin(String checkintime, String lat, String long, String date, String time, String targetlat, String targetlong) async {
    final Database db = await database;



    // Participant hasn't voted yet for this award, insert the vote
    await db.insert(
      'checkinrecord',
      {
        'checkintime': checkintime,
        'lat': lat,
        'long': long,
        'date':date,
        'time':time,
        'target_lat': targetlat,
        'target_long': targetlong,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore, // Ignore if entry already exists
    );
    print('Location saved successfully: checkintime=$checkintime lat=$lat, long=$long',  );

  }


  Future<bool> hasCheckedIn(String date) async {
    final Database db = await database;

    // Query to check if there is already an entry for the current date
    final List<Map<String, dynamic>> results = await db.query(
      'checkinrecord',
      where: 'date = ?',
      whereArgs: [date],
    );

    // Returns true if an entry exists (i.e., the user has checked in), false otherwise
    return results.isNotEmpty;
  }



  Future<void> insertVote(String lat, String long, String givenlat, String givenlong,String distance, String msg) async {
    final Database db = await database;



      // Participant hasn't voted yet for this award, insert the vote
      await db.insert(
        'geocordinates',
        {
          'lat': lat,
          'long': long,
          'distance': distance,
          'msg':msg,
          'givenlat':givenlat,
          'givenlong':givenlong,


        },
        conflictAlgorithm: ConflictAlgorithm.ignore, // Ignore if entry already exists
      );
      print('Location saved successfully: lat=$lat, long=$long, distance=$distance, msg=$msg',  );

    }
  Future<List<Map<String, dynamic>>> getcheckin() async {
    try {
      final Database db = await database; // Ensure your database is initialized
      final List<Map<String, dynamic>> feedbacks = await db.query('geocordinates');
      print('Feedbacks retrieved successfully: $feedbacks');
      return feedbacks;
    } catch (e) {
      print('Error retrieving feedbacks: ${e.toString()}');
      throw Exception('Error retrieving feedbacks: ${e.toString()}');
    }
  }



  Future<bool> hasVoted(String awardId, String nomineeId, String participantToken) async {
    final Database db = await database;

    // Check if the participant has already voted for this award and nominee
    List<Map<String, dynamic>> result = await db.query(
      'votes',
      where: 'award_id = ? AND nominee_id = ? AND participant_token = ?',
      whereArgs: [awardId, nomineeId, participantToken],
    );

    return result.isNotEmpty;
  }


  Future<void> insertFeedback(String code, String feedback, String rating) async {
    try {
      final Database db = await database;
      await db.insert(
        'feedbacks',
        {
          'code': code,
          'rating': rating,
          'feedback': feedback,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      print('Feedback saved successfully: code=$code, rating=$rating, feedback=$feedback');
    } catch (e) {
      print('Error inserting feedback: ${e.toString()}');
      throw Exception('Error inserting feedback: ${e.toString()}'); // Optional: Rethrow the exception for higher level handling
    }
  }


  Future<List<Map<String, dynamic>>> getlocation() async {
    try {
      final Database db = await database; // Ensure your database is initialized
      final List<Map<String, dynamic>> feedbacks = await db.query('checkinrecord');
      print('Feedbacks retrieved successfully: $feedbacks');
      return feedbacks;
    } catch (e) {
      print('Error retrieving feedbacks: ${e.toString()}');
      throw Exception('Error retrieving feedbacks: ${e.toString()}');
    }
  }






  Future<bool> hasFeedbacks() async {
    final Database db = await database;

    List<Map<String, dynamic>> result = await db.query('feedbacks');
    print(result);
    return result.isNotEmpty;
  }


  // Future<void> insertNotification(Notification_model model) async {
  //   try {
  //     final Database db = await database;
  //     await db.insert('notification', model.toJson());
  //     print("Inserted data successfully");
  //   } catch (e) {
  //     print("Failed to insert data: $e");
  //     throw Exception("Failed to insert notification into database");
  //   }
  // }
  //
  //
  //
  //
  //
  //
  // Future<List<Notification_model>> getnotification() async {
  //   try {
  //     final Database db = await database;
  //     final List<Map<String, dynamic>> list = await db.query('notification');
  //
  //     List<Notification_model> model = list.map((e) => Notification_model.fromJson(e)).toList();
  //
  //     return model;
  //   } catch (e) {
  //     print("Failed to retrieve notifications: $e");
  //     throw Exception("Failed to retrieve notifications from database");
  //   }
  // }
  Future<int> getNotificationCount() async {
    final Database db = await database;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM notification_counts')) ?? 0;
    return count;
  }

  Future<void> updateNotificationCount() async {
    final Database db = await database;
    await db.delete('notification_counts');
  }
  Future<void> insertNotificationCount(int count) async {
    final Database db = await database;
    await db.insert(
      'notification_counts',
      {'notifications_count': count},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<void> attendiesinsert(String roomNumber, String name) async {
    try {
      final Database db = await database;
      await db.insert('attendies',  {'Room_number': roomNumber, 'Name': name});
    } catch (e) {
      print("Failed to insert data: $e");
      throw Exception("Failed to insert notification into database");
    }
  }
  Future<List<String>> getnames(String room, String name) async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> map= await db.query('geocordinates' , columns: ['Name'], where: 'Room_number =?',
          whereArgs: [room]);
      List<String> names=[];
      for(var item in map){
        names.add(item['Name']);
      }
      if(name!=null) {
        names.remove(name);
      }
      return names;

    } catch (e) {

      throw Exception("Failed to insert notification into database");
    }

  }






}



