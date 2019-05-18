package com.gifwebfront.Controller.MVC;

import com.gifwebfront.Form.FileForm;
import com.gifwebfront.Form.RequestForm;
import com.gifwebfront.Util.MediaUtil;
import com.gifwebfront.Util.RestUtil;
//import org.codehaus.jettison.json.JSONObject;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by NESOY on 2017-02-04.
 */
@Controller
@RequestMapping(value = "/")
public class MainController {
    private static final Logger logger = LoggerFactory.getLogger(MainController.class);
    //private static final String API_ADDRESS = "http://localhost:20000/api/";

    @Value("#{config['storedFilePath']}")
    private String storedFilePath;
    @Value("#{config['REST_URL']}")
    private String API_ADDRESS;

    @RequestMapping(value = {"", "index"}, method = RequestMethod.GET)
    public String indexGet(Model model, HttpSession session){
        return "index";
    }

    @RequestMapping(value = {"imgList"}, method = RequestMethod.GET)
    public @ResponseBody
    String imgListGet(Model model, HttpSession session){
        JsonObject retObj = new JsonObject();
        retObj.addProperty("listCount", 0);
        JsonArray imgList = new JsonArray();

        File dir = new File(storedFilePath);
        //File dir = new File("G:/Java/InteliJ/animated_gif_photoin/upload");
        File[] fileList = dir.listFiles();
        Integer listCount = 0;

        try{
            for(int i = 0 ; i < fileList.length ; i++){
                File file = fileList[i];
                if(file.isFile()){
                    JsonObject fileObj = new JsonObject();
                    fileObj.addProperty("fileName", file.getName());
                    imgList.add(fileObj);
                    listCount++;
                }
            }
        }catch(Exception e){
            return retObj.toString();
        }

        retObj.addProperty("listCount", listCount);
        retObj.add("imgList", imgList);
        return retObj.toString();
    }

    @RequestMapping(value = {"imgList"}, method = RequestMethod.DELETE)
    public @ResponseBody
    String imgListDelete(@RequestBody RequestForm requestForm){
        for(FileForm fileForm : requestForm.getFileList()) {
            String filePath = storedFilePath + fileForm.getFileName();
            File file = new File(filePath);
            file.delete();
        }

        return "ok";
    }

    @RequestMapping(value = {"display"}, method = RequestMethod.GET)
    public ResponseEntity<byte[]> displayGet(@RequestParam("name") String fileName){
        InputStream stream = null;
        ResponseEntity<byte[]> entity = null;
        try{
            String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
            MediaType mType = MediaUtil.getMediaType(formatName);
            HttpHeaders headers = new HttpHeaders();
            stream = new FileInputStream(storedFilePath + fileName);

            if(mType != null) {
                headers.setContentType(mType);
            } else {
                fileName = fileName.substring(fileName.indexOf("_")+1);
                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
                headers.add("Content-Disposition", "attachment; filename=\"" +
                        new String(fileName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1));
            }

            entity = new ResponseEntity<>(IOUtils.toByteArray(stream), headers, HttpStatus.CREATED);
            stream.close();
        } catch (Exception e) {
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        return entity;
    }

    @RequestMapping(value = {"makeGifRequest"}, method = RequestMethod.POST)
    public @ResponseBody
    String makeGifRequestPost(@RequestBody RequestForm requestForm){
        String requestId = "" + System.currentTimeMillis();
        requestForm.setRequestId(requestId);

        List<String[]> headers = new ArrayList<>();
        headers.add(new String[]{"Accept", "*/*"});
        headers.add(new String[]{"X-Requested-With", "XMLHttpRequest"});
        Gson gson = new Gson();
        String jsonString = gson.toJson(requestForm);
        String retString = RestUtil.requestPost(API_ADDRESS + "makeGif", headers, jsonString);

        JsonParser parser = new JsonParser();
        JsonObject retObj = parser.parse(retString).getAsJsonObject();

        return retObj.get("result").getAsJsonObject().toString();
    }

    @RequestMapping(value = {"uploadFile"}, method = RequestMethod.POST)
    public @ResponseBody
    String uploadFilePost(MultipartHttpServletRequest mtfRequest){
        List<MultipartFile> fileList = mtfRequest.getFiles("file");
        List<String> downloadedFileList = new ArrayList<>();
        String src = mtfRequest.getParameter("src");
        System.out.println("src value : " + src);

        for (MultipartFile mf : fileList) {
            String originFileName = mf.getOriginalFilename(); // 원본 파일 명
            long fileSize = mf.getSize(); // 파일 사이즈

            System.out.println("originFileName : " + originFileName);
            System.out.println("fileSize : " + fileSize);

            // 경로 생성
            File dir = new File(storedFilePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String safeFile = storedFilePath + System.currentTimeMillis() + "_" + originFileName;
            try {
                mf.transferTo(new File(safeFile));
                downloadedFileList.add(safeFile);
            } catch (IllegalStateException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

        // 파일 다운로드 후에 이미지 파일이 아닌게 있다면 삭제
        for(String filePath : downloadedFileList) {
            if(!MediaUtil.isImageFile(filePath)){
                System.out.println(filePath + " is not image file. deleting...");
                File file = new File(filePath);
                file.delete();
            }
        }

        return "ok";
    }
}