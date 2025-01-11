import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:renters_management_front_end/app/models/build_model.dart';
import 'package:renters_management_front_end/app/models/expens_model.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/models/statement_model.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';
import 'package:get/get.dart' as get_x;
import '../components/loading_card.dart';
import '../models/income_model.dart';
import 'http_provider/http_provider.dart';

class StatementServices {
  static Future<Result<Map<String, List<Statement>>>> fetchStatements(
      int buildId,
      {bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    if (res.data != null && res.data?.renters != null && !hardFetch) {
      return Result(
          data: res.data!.statements,
          statusCode: 200,
          hasError: false,
          message: "successful");
    }
    Response? response;
    try {
      response = await HttpProvider.get("/user/builds/$buildId/statements");
      if (response?.statusCode == 200) {
        Map<String, List<Statement>> statements = {};
        if ((response?.data["grouped_statements"] ?? []).isNotEmpty) {
          for (String key in response?.data["grouped_statements"].keys) {
            List<Statement> statementsList = [];
            for (Map<String, dynamic> item
                in response?.data["grouped_statements"][key]) {
              statementsList.add(Statement.fromJson(item));
            }
            statements[key] = statementsList;
          }
        }
        BuildServices.setBuildStatements(buildId, statements);
        return Result(
            data: statements,
            hasError: false,
            statusCode: response?.statusCode,
            message: "successful");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 661,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 706,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<List<Statement>>> fetchStatementsYearGroup(
      int buildId, String year,
      {bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    if (res.data != null && res.data?.renters != null && !hardFetch) {
      return Result(
          data: res.data!.statements?[year] ?? [],
          statusCode: 200,
          hasError: false,
          message: "successful");
    }
    Response? response;
    try {
      response = await HttpProvider.get("/user/builds/$buildId/statements");
      if (response?.statusCode == 200) {
        Map<String, List<Statement>> statements = {};
        if ((response?.data["grouped_statements"] ?? []).isNotEmpty) {
          for (String key in response?.data["grouped_statements"].keys) {
            List<Statement> statementsList = [];
            for (Map<String, dynamic> item
                in response?.data["grouped_statements"][key]) {
              statementsList.add(Statement.fromJson(item));
            }
            statements[key] = statementsList;
          }
        }
        BuildServices.setBuildStatements(buildId, statements);
        return Result(
            data: statements[year],
            hasError: false,
            statusCode: response?.statusCode,
            message: "successful");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 662,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 706,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<Statement>> fetchStatement(int buildId, int statementId,
      {bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    if (res.data != null && res.data?.renters != null && !hardFetch) {
      for (List<Statement> statementList
          in (res.data?.statements?.values ?? [])) {
        for (Statement statement in (statementList)) {
          if (statement.id.value == statementId) {
            return Result(
                data: statement,
                statusCode: 200,
                hasError: false,
                message: "successful");
          }
        }
      }
    }

    late Response? response;
    try {
      response =
          await HttpProvider.post("user/builds/$buildId/renters/$statementId");
      Map<String, dynamic> result = response?.data["Statement"];
      Map<String, List<Statement>> statements = res.data?.statements ?? {};
      Statement statement = Statement.fromJson(result);
      statements[statement.year?.value]?.add(statement);
      BuildServices.setBuildStatements(buildId, statements);
      return Result(
          data: statement,
          hasError: false,
          statusCode: response?.statusCode,
          message: "successful");
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Result(
          hasError: true,
          statusCode: 663,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 706,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<Statement>> fetchStatementsByMonth(
      int buildId, String year, String month,
      {bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    if (res.data != null && res.data?.renters != null && !hardFetch) {
      return Result(
          data: res.data!.statements?[year]
              ?.firstWhere((element) => (element.month?.value ?? "") == month),
          statusCode: 200,
          hasError: false,
          message: "successful");
    }
    Response? response;
    try {
      response = await HttpProvider.get("/user/builds/$buildId/statements");
      if (response?.statusCode == 200) {
        Map<String, List<Statement>> statements = {};
        if ((response?.data["grouped_statements"] ?? []).isNotEmpty) {
          for (String key in response?.data["grouped_statements"].keys) {
            List<Statement> statementsList = [];
            for (Map<String, dynamic> item
                in response?.data["grouped_statements"][key]) {
              statementsList.add(Statement.fromJson(item));
            }
            statements[key] = statementsList;
          }
        }
        BuildServices.setBuildStatements(buildId, statements);
        return Result(
            data: statements[year]?.firstWhere(
                (element) => (element.month?.value ?? "") == month),
            hasError: false,
            statusCode: response?.statusCode,
            message: "successful");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 664,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 706,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<List<Income>>> statementAddIncome(
      {required int buildId,
      required int statementId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      response = await HttpProvider.post(
          "/user/statements/$statementId/incomes",
          data: data);
      if (response?.statusCode == 200) {
        res.data?.statements?[response?.data["income"]["statement"]["year"]]
            ?.firstWhere((e) => e.id.value == statementId)
            .incomes
            ?.add(Income.fromJson(response?.data["income"]));
        res.data?.statements?[response?.data["income"]["statement"]["year"]]
            ?.firstWhere((e) => e.id.value == statementId)
            .totalIncomes
            ?.value += response?.data["income"]["amount"];
        return Result(
            hasError: true,
            statusCode: response?.statusCode,
            data: (res.data
                    ?.statements?[response?.data["income"]["statement"]["year"]]
                    ?.firstWhere((e) => e.id.value == statementId)
                    .incomes) ??
                []);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 626,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 623,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> statementDeleteIncome(
      {required int buildId,
      required int statementId,
      required int incomeId,
      Map<String, dynamic> data = const {},
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Statement> res = await fetchStatement(buildId,statementId);
    Response? response;
    try {
      response = await HttpProvider.delete(
          "/user/statements/$statementId/incomes/$incomeId",
          data: data);
      if (response?.statusCode == 200) {
        int? index = res.data?.incomes?.indexWhere((element)=>element.id.value == incomeId);
        if(index!=null){
          res.data?.totalIncomes?.value -= res.data?.incomes?[index].amount?.value??0;
          res.data?.incomes?.removeAt(index);
        }
        return Result(
            hasError: true,
            statusCode: response?.statusCode,
            data: true);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 626,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 623,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<List<Expens>>> statementAddExpens(
      {required int buildId,
      required int statementId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      response = await HttpProvider.post(
          "/user/statements/$statementId/expenses",
          data: data);
      if (response?.statusCode == 200) {
        res.data?.statements?[response?.data["expens"]["statement"]["year"]]
            ?.firstWhere((e) => e.id.value == statementId)
            .expenses
            ?.add(Expens.fromJson(response?.data["expens"]));
        res.data?.statements?[response?.data["expens"]["statement"]["year"]]
            ?.firstWhere((e) => e.id.value == statementId)
            .totalExpenses
            ?.value += response?.data["expens"]["amount"];
        return Result(
            hasError: true,
            statusCode: response?.statusCode,
            data: (res.data
                    ?.statements?[response?.data["expens"]["statement"]["year"]]
                    ?.firstWhere((e) => e.id.value == statementId)
                    .expenses) ??
                []);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 626,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 623,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> statementDeleteExpens(
      {required int buildId,
      required int statementId,
      required int expensId,
      Map<String, dynamic> data = const {},
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Statement> res = await fetchStatement(buildId,statementId);
    Response? response;
    try {
      response = await HttpProvider.delete(
          "/user/statements/$statementId/expenses/$expensId",
          data: data);
      if (response?.statusCode == 200) {
        int? index = res.data?.expenses?.indexWhere((element)=>element.id.value == expensId);
        if(index!=null){
          res.data?.totalExpenses?.value -= res.data?.expenses?[index].amount?.value??0;
          res.data?.expenses?.removeAt(index);
        }
        return Result(
            hasError: true,
            statusCode: response?.statusCode,
            data: true);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 626,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 623,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> statementUpdateIncome(
      {required int buildId,
        required int statementId,
        required int incomeId,
        Map<String, dynamic> data = const {},
        bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Statement> res = await fetchStatement(buildId,statementId);
    Response? response;
    try {
      response = await HttpProvider.patch(
          "/user/statements/$statementId/incomes/$incomeId",
          data: data);
      if (response?.statusCode == 200) {
        int? index = res.data?.incomes?.indexWhere((element)=>element.id.value == incomeId);
        if(index!=null){
          res.data?.incomes?[index] =  Income.fromJson(response?.data["income"]);
        }
        return Result(
            hasError: true,
            statusCode: response?.statusCode,
            data: true);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 626,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 623,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }


  static Future<Result<bool>> statementUpdateExpens(
      {required int buildId,
        required int statementId,
        required int expensId,
        Map<String, dynamic> data = const {},
        bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Statement> res = await fetchStatement(buildId,statementId);
    Response? response;
    try {
      response = await HttpProvider.patch(
          "/user/statements/$statementId/expenses/$expensId",
          data: data);
      if (response?.statusCode == 200) {
        int? index = res.data?.expenses?.indexWhere((element)=>element.id.value == expensId);
        if(index!=null){
          res.data?.expenses?[index] =  Expens.fromJson(response?.data["expens"]);
        }
        return Result(
            hasError: true,
            statusCode: response?.statusCode,
            data: true);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 626,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 623,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }
}
