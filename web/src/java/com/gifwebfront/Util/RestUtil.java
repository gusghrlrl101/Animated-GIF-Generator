package com.gifwebfront.Util;

//import org.codehaus.jettison.json.JSONObject;
import com.google.gson.*;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class RestUtil {
    static public String requestGet(String url, List<String[]> headers){
        JsonObject returnObj = new JsonObject();
        try{
            returnObj.addProperty("error", true);

            URL object=new URL(url);
            HttpURLConnection con = (HttpURLConnection) object.openConnection();

            con.setDoOutput(true);
            con.setDoInput(true);
            //con.setRequestProperty("Content-Type", "application/
            for(String[] header: headers) {
                if(header.length != 2)
                    continue;

                con.setRequestProperty(header[0], header[1]);
            }

            con.setRequestMethod("GET");

            StringBuilder sb = new StringBuilder();
            int HttpResult = con.getResponseCode();
            returnObj.addProperty("res_code", HttpResult);
            returnObj.addProperty("res_msg", con.getResponseMessage());
            if(HttpResult == HttpURLConnection.HTTP_OK){
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"utf-8"));
                String line = null;
                while ((line = br.readLine()) != null) {
                    sb.append(line + "\n");
                }

                br.close();

                JsonParser parser = new JsonParser();
                JsonElement result = parser.parse(sb.toString());
                JsonArray array = new JsonArray();
                array.add(result);
                returnObj.add("result", result);
                returnObj.addProperty("error", false);
                System.out.println(""+sb.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObj.toString();
    }

    static public String requestPost(String url, List<String[]> headers, Object data){
        JsonObject returnObj = new JsonObject();
        try{
            returnObj.addProperty("error", true);

            URL object=new URL(url);
            HttpURLConnection con = (HttpURLConnection) object.openConnection();

            con.setDoOutput(true);
            con.setDoInput(true);
            //con.setRequestProperty("Content-Type", "application/
            con.setRequestProperty("Content-Type", "application/json");
            for(String[] header: headers) {
                if(header.length != 2)
                    continue;

                con.setRequestProperty(header[0], header[1]);
            }

            con.setRequestMethod("POST");
            OutputStream os= con.getOutputStream();
            os.write(data.toString().getBytes("UTF-8"));
            os.flush();

            StringBuilder sb = new StringBuilder();
            int HttpResult = con.getResponseCode();
            returnObj.addProperty("res_code", HttpResult);
            returnObj.addProperty("res_msg", con.getResponseMessage());
            if(HttpResult == HttpURLConnection.HTTP_OK){
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"utf-8"));
                String line = null;
                while ((line = br.readLine()) != null) {
                    sb.append(line + "\n");
                }

                br.close();

                JsonParser parser = new JsonParser();
                JsonElement result = parser.parse(sb.toString());
                returnObj.add("result", result);
                returnObj.addProperty("error", false);
                System.out.println(""+sb.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObj.toString();
    }

    static public String requestPut(String url, List<String[]> headers){
        JsonObject returnObj = new JsonObject();
        try{
            returnObj.addProperty("error", true);

            URL object=new URL(url);
            HttpURLConnection con = (HttpURLConnection) object.openConnection();
            con.setRequestProperty("Content-Type", "application/json");
            con.setDoOutput(true);
            con.setDoInput(true);
            //con.setRequestProperty("Content-Type", "application/
            for(String[] header: headers) {
                if(header.length != 2)
                    continue;

                con.setRequestProperty(header[0], header[1]);
            }
            con.setRequestMethod("PUT");

            StringBuilder sb = new StringBuilder();
            int HttpResult = con.getResponseCode();
            returnObj.addProperty("res_code", HttpResult);
            returnObj.addProperty("res_msg", con.getResponseMessage());
            if(HttpResult == HttpURLConnection.HTTP_OK){
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"utf-8"));
                String line = null;
                while ((line = br.readLine()) != null) {
                    sb.append(line + "\n");
                }

                br.close();

                JsonParser parser = new JsonParser();
                JsonElement result = parser.parse(sb.toString());
                returnObj.add("result", result);
                returnObj.addProperty("error", false);
                System.out.println(""+sb.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObj.toString();
    }

    static public String requestPut(String url, List<String[]> headers, Object data){
        JsonObject returnObj = new JsonObject();
        try{
            returnObj.addProperty("error", true);

            URL object=new URL(url);
            HttpURLConnection con = (HttpURLConnection) object.openConnection();
            con.setRequestProperty("Content-Type", "application/json");
            con.setDoOutput(true);
            con.setDoInput(true);
            //con.setRequestProperty("Content-Type", "application/
            for(String[] header: headers) {
                if(header.length != 2)
                    continue;

                con.setRequestProperty(header[0], header[1]);
            }
            con.setRequestMethod("PUT");
            OutputStream os= con.getOutputStream();
            os.write(data.toString().getBytes("UTF-8"));
            os.flush();

            StringBuilder sb = new StringBuilder();
            int HttpResult = con.getResponseCode();
            returnObj.addProperty("res_code", HttpResult);
            returnObj.addProperty("res_msg", con.getResponseMessage());
            if(HttpResult == HttpURLConnection.HTTP_OK){
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"utf-8"));
                String line = null;
                while ((line = br.readLine()) != null) {
                    sb.append(line + "\n");
                }

                br.close();

                JsonParser parser = new JsonParser();
                JsonElement result = parser.parse(sb.toString());
                returnObj.add("result", result);
                returnObj.addProperty("error", false);
                System.out.println(""+sb.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObj.toString();
    }

    static public String requestDelete(String url, List<String[]> headers, Object data){
        JsonObject returnObj = new JsonObject();
        try{
            returnObj.addProperty("error", true);

            URL object=new URL(url);
            HttpURLConnection con = (HttpURLConnection) object.openConnection();

            con.setDoOutput(true);
            con.setDoInput(true);
            //con.setRequestProperty("Content-Type", "application/
            for(String[] header: headers) {
                if(header.length != 2)
                    continue;

                con.setRequestProperty(header[0], header[1]);
            }

            con.setRequestMethod("DELETE");
            OutputStream os= con.getOutputStream();
            os.write(data.toString().getBytes("UTF-8"));
            os.flush();

            StringBuilder sb = new StringBuilder();
            int HttpResult = con.getResponseCode();
            returnObj.addProperty("res_code", HttpResult);
            returnObj.addProperty("res_msg", con.getResponseMessage());
            if(HttpResult == HttpURLConnection.HTTP_OK){
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"utf-8"));
                String line = null;
                while ((line = br.readLine()) != null) {
                    sb.append(line + "\n");
                }

                br.close();

                JsonParser parser = new JsonParser();
                JsonElement result = parser.parse(sb.toString());
                returnObj.add("result", result);
                returnObj.addProperty("error", false);
                System.out.println(""+sb.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObj.toString();
    }
}
