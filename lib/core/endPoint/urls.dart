class Urls {
  static const String baseUrl = 'https://dshadzbackend.onrender.com/api/v1';
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/users/createUser';
  static const String allMadels = '$baseUrl/medals/getAllMedals';
  static const String createPlan = "$baseUrl/meals/create-meal-plan";
  static const String allMealPlan = "$baseUrl/meals/all-meal-plans";
  static const String history = "$baseUrl/graph/getHistory";
  static const String thisWeek = "$baseUrl/graph/getHistoryOfEveryOne";
  static String suggestMealPlans = "$baseUrl/meals/suggest-meal-plans";
  static String getLeaderBoard = "$baseUrl/users/getLeaderBoard";
  static const String getprofile = "$baseUrl/users/getProfile";
  static const String updateprofile = "$baseUrl/users/updateProfileData";
  static const String selfdistuct = "$baseUrl/users/selfDistuct";
  static const String postFavotiteMeal = "$baseUrl/meals/fav-meal-plans";
  static const String getFavotiteMeal = "$baseUrl/meals/favourite-meals";
  static const String changepassword = "$baseUrl/auth/changePassword";
  static const String grothgraph = "$baseUrl/graph/personalGrothGraph";
  static const String removeFavotiteMeal =
      "$baseUrl/meals/remove-fav-meal-plans";
  static const String getalluser = "$baseUrl/users/getAlluser";
  static const String sharehistory = "$baseUrl/users/share-history";
  static const String previousRun = "$baseUrl/running/getPreviousRun";
  static const String leaderBoardPosition =
      '$baseUrl/users/leadarBoardPosition';
  static const String forgetPassword = '$baseUrl/auth/forgetPassword';
  static const String resetPassword = '$baseUrl/auth/resetPassword';
  static const String logOut = '$baseUrl/auth/logOut';
}
