package com.ezen.spring.board.teampro.login;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class BookRecommender_GET 
{
   
   private static final String URL = "http://localhost:7878/fairy/fairybooks";
    private static final String GET = "GET";
    private static final String USER_AGENT = "Mozilla/5.0";

    public String getRecommendations(String userid) throws IOException {
        URL url = new URL(URL + "?userid=" + userid);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        connection.setRequestMethod(GET);
        connection.setRequestProperty("User-Agent", USER_AGENT);

        int responseCode = connection.getResponseCode();

        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuffer stringBuffer = new StringBuffer();
        String inputLine;

        while ((inputLine = bufferedReader.readLine()) != null) {
            stringBuffer.append(inputLine);
        }
        
   bufferedReader.close();
   
   return stringBuffer.toString();
    }
}

