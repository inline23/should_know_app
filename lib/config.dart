class Config {
  static String apiURL = "https://should-know.com/wp-json/wp/v2/";
  static String categoryURL = "categories";
  static String postsURL = "posts/?categories="; // must add Id
  static String postDetailURL = "https://should-know.com/wp-json/wp/v2/posts/";
  // call by post Id
  static String postImage = "https://should-know.com/wp-json/wp/v2/media?parent=";
  static String dateFormat = "dd-MMM-yy";
}
 