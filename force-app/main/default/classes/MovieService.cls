public with sharing class MovieService {
    private static final String API_KEY = 'eebd48a8'; 
    private static final String BASE_URL = 'https://www.omdbapi.com/';

    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> searchMoviesWithRating(String title) {
        List<Map<String, Object>> movieList = searchMovies(title);
        List<Map<String, Object>> moviesWithRating = new List<Map<String, Object>>();

        for (Map<String, Object> m : movieList) {
            String imdbId = (String) m.get('imdbID');
            Map<String, Object> detail = getMovieDetail(imdbId);
            m.put('imdbRating', detail.get('imdbRating'));
            moviesWithRating.add(m);
        }
        return moviesWithRating;
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> searchMovies(String title) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + '?s=' + EncodingUtil.urlEncode(title, 'UTF-8') + '&apikey=' + API_KEY);
        req.setMethod('GET');

        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            List<Object> movies = (List<Object>) results.get('Search');
            List<Map<String, Object>> movieList = new List<Map<String, Object>>();
            if (movies != null) {
                for (Object m : movies) {
                    movieList.add((Map<String, Object>) m);
                }
            }
            return movieList;
        }
        return new List<Map<String, Object>>();
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getMovieDetail(String imdbId) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + '?i=' + imdbId + '&apikey=' + API_KEY);
        req.setMethod('GET');

        HttpResponse res = http.send(req);

        if(res.getStatusCode() == 200) {
            return (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        }
        return new Map<String, Object>();
    }

    @AuraEnabled
    public static Id saveMovieDetail(Map<String, Object> md) {
        Movie__c movie = new Movie__c(
            Title__c = (String) md.get('Title'),
            Year__c = (String) md.get('Year'),
            Type__c = (String) md.get('Type'),
            PosterUrl__c = (String) md.get('Poster'),
            Director__c = (String) md.get('Director'),
            Actors__c = (String) md.get('Actors'),
            Genre__c = (String) md.get('Genre'),
            imdbRating__c = safeDecimal(md.get('imdbRating'))
        );
        insert movie;
        return movie.Id;
    }

    private static Decimal safeDecimal(Object val) {
        if (val == null) return null;
        try {
            return Decimal.valueOf((String) val);
        } catch (Exception e) {
            return null;
        }
    }
}
