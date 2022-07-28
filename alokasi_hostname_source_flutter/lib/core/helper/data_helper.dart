import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:meta/meta.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';
import 'helper.dart';

typedef Future<int> SingleIntReturn();
typedef Future<List<int>> ListIntReturn();

class DataHelper {
  static Iterable getIterableFromGraphqlResultMap({
    @required Map<String, dynamic> map,
    @required EnumDataManipulation dataManipulationType,
    @required String tableName,
    bool isSelectUsingView = false,
    String viewName = '',
  }) {
    if (isSelectUsingView == true && viewName == '') isSelectUsingView = false;

    final keyForSelect = isSelectUsingView ? viewName : tableName;
    final keyForInsert = 'insert_' + tableName;
    final keyForUpdate = 'update_' + tableName;
    final keyForDelete = 'delete_' + tableName;

    switch (dataManipulationType) {
      case EnumDataManipulation.select:
        {
          final Map<String, dynamic> extractedData = map['data'] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          final Iterable extractedField = extractedData[keyForSelect] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          // final Iterable extractedField = map['data'][keyForSelect] ?? null;
          return extractedField;
        }
      case EnumDataManipulation.insert:
        {
          // final Map<String, dynamic> returningMap = map['data'][keyForInsert];
          // final Iterable extractedField = returningMap['returning'];
          final Map<String, dynamic> extractedData = map['data'] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          final Map<String, dynamic> extractedKeyForInsert =
              extractedData[keyForInsert] ??
                  (throw ServerException(
                      message: 'Result is not expected format type'));
          final Iterable extractedField = extractedKeyForInsert['returning'] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          return extractedField;
        }
      case EnumDataManipulation.update:
        {
          // final Map<String, dynamic> returningMap = map['data'][keyForUpdate];
          // final Iterable extractedField = returningMap['returning'];
          final Map<String, dynamic> extractedData = map['data'] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          final Map<String, dynamic> extractedKeyForUpdate =
              extractedData[keyForUpdate] ??
                  (throw ServerException(
                      message: 'Result is not expected format type'));
          final Iterable extractedField = extractedKeyForUpdate['returning'] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          return extractedField;
        }
      case EnumDataManipulation.delete:
        {
          // final Map<String, dynamic> returningMap = map['data'][keyForDelete];
          // final Iterable extractedField = returningMap['returning'];
          final Map<String, dynamic> extractedData = map['data'] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          final Map<String, dynamic> extractedKeyForDelete =
              extractedData[keyForDelete] ??
                  (throw ServerException(
                      message: 'Result is not expected format type'));
          final Iterable extractedField = extractedKeyForDelete['returning'] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          return extractedField;
        }
      default:
        {
          final Map<String, dynamic> extractedData = map['data'] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          final Iterable extractedField = extractedData[keyForSelect] ??
              (throw ServerException(
                  message: 'Result is not expected format type'));
          return extractedField;
        }
    }
  }

  static Future<Map<String, dynamic>> executeGraphqlQuery({
    @required HasuraConnect graphqlClient,
    @required Map<String, dynamic> variables,
    @required String queryStatement,
  }) async {
    final holder =
        await graphqlClient.query(queryStatement, variables: variables);
    if (holder is String) {
      return json.decode(holder);
    } else {
      return holder;
    }
  }

  static Future<Map<String, dynamic>> executeGraphqlMutation({
    @required HasuraConnect graphqlClient,
    @required Map<String, dynamic> variables,
    @required String mutationStatement,
  }) async {
    return await graphqlClient.mutation(mutationStatement,
        variables: variables);
  }

  // static Future<Map<String, dynamic>> getHasuraQueryAndParameter(
  //   HasuraConnect hasuraConnect,
  //   Map<String, dynamic> variables,
  //   EnumHasuraFetchType hasuraFetchType,
  //   String queryString,
  //   EnumDataManipulation dataManipulation,
  // ) async {
  //   switch (hasuraFetchType) {
  //     case EnumHasuraFetchType.query:
  //       final holder =
  //           await hasuraConnect.query(queryString, variables: variables);
  //       // await hasuraConnect.query(queryString);
  //       if (holder is String) {
  //         return json.decode(holder);
  //       } else {
  //         return holder;
  //       }
  //       break;
  //     case EnumHasuraFetchType.mutation:
  //       return await hasuraConnect.mutation(queryString, variables: variables);
  //       // queryHasura = await json.decode(dataFetched);
  //       break;
  //     case EnumHasuraFetchType.subscription:
  //       // snapshot =
  //       //     hasuraConnect.subscription(queryString, variables: variables);

  //       break;
  //     default:
  //       {
  //         return await hasuraConnect.query(queryString, variables: variables);
  //         // queryHasura = json.decode(dataFetched);
  //       }
  //   }
  // }

  static String getPlainKeyTextFromMap(Map<String, dynamic> maps) {
    String s = '';
    maps.forEach((key, value) {
      s = s + ' ' + key;
    });
    return s;
  }

  static String getDefaultGraphqlVariable(Map<String, dynamic> maps) {
    String result = '';
    maps.forEach((key, value) {
      if (!(key == "id")) {
        // || key == "deleted" || key == "created")) {
        result = result + ' \$' + key + ': ' + value + ' = null, ';
      }
    });
    return result;
  }

  static String getGraphqlVariable(
    Map<String, dynamic> maps,
    Map<String, dynamic> objectMaps,
  ) {
    String result = '';
    maps.forEach((key, value) {
      if (!(key == "id")) {
        // || key == "deleted" || key == "created")) {
        if (!(objectMaps[key] == null)) {
          result = result + ' \$' + key + ': ' + value + ' = null, ';
        }
      }
    });
    return result;
  }

  static String getDefaultGraphqlArgument(Map<String, dynamic> maps) {
    String result = '';
    maps.forEach((key, value) {
      if (!(key == "id")) {
        // || key == "deleted" || key == "created")) {
        result = result + key + ': \$' + key + ', ';
      }
    });
    return result;
  }

  static String getGraphqlArgument(
    Map<String, dynamic> maps,
    Map<String, dynamic> objectMaps,
  ) {
    String result = '';
    maps.forEach((key, value) {
      if (!(key == "id")) {
        // || key == "deleted" || key == "created")) {
        if (!(objectMaps[key] == null)) {
          result = result + key + ': \$' + key + ', ';
        }
      }
    });
    return result;
  }

  static String getQueryLikeTextFrom(String s) {
    return s != null ? '%$s%' : null;
  }

  static Future<Either<Failure, List<int>>> getManiputaledIdsFrom(
    ListIntReturn actions,
  ) async {
    try {
      final manipulatedIds = await actions();
      return Right(manipulatedIds);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
