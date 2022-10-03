Future<String> urlGeneratorSearch(String search, String category, String region, String genre, String release)async{
  String url = "/auth/explorefilter/${search}?";

  if(category != ""){
    if(url[url.length - 1] == "?"){
      url += "category=${category}";
    }else{
      url += "&category=${category}";
    }
  }

  if(region != ""){
    if(url[url.length - 1] == "?"){
      url += "region=${region}";
    }else{
      url += "&region=${region}";
    }
  }

  if(genre != ""){
    if(url[url.length - 1] == "?"){
      url += "genre=${genre}";
    }else{
      url += "&genre=${genre}";
    }
  }

  if(release != ""){
    if(url[url.length - 1] == "?"){
      url += "release=${release}";
    }else{
      url += "&release=${release}";
    }
  }

  return url;
}