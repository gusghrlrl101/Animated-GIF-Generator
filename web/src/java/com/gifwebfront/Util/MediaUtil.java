package com.gifwebfront.Util;

import org.springframework.http.MediaType;

import java.io.DataInputStream;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

public class MediaUtil {
    String resultcode    = "";
    String resultmessage   = "";
    private static Map<String, MediaType> mediaMap;

    //이미지 파일 체크 로직
    public static boolean isImageFile(String szFilePath){
        boolean isRst = false;
        String szFileHeader = "";
        String [] szArrImgHeader =
                {"47494638", "474946383761","474946383761","474946383761" //GIF Header
                        ,"89504E470D0A1A0A0000000D49484452" // PNG Header
                        , "FFD8FF" //JPG Header
                        , "424D" //BMP Header
                };
        try{
            if(szFilePath != null && !szFilePath.equals("")) {
                if(fileUploadCheckExt(szFilePath)){
                    szFileHeader = fileToByte(szFilePath); //업로드 하려는 파일 헤더 체크

                    if(szFileHeader != null && !szFileHeader.equals("")) {
                        for(int i=0;i<szArrImgHeader.length;i++) {
                            int len = szArrImgHeader[i].length();
                            if(szArrImgHeader[i].equals(szFileHeader.substring(0, len))) {
                                isRst = true;
                                break;
                            }
                        }
                    }
                }
            }

        }catch(Exception e){
            //log기록 필요
            e.printStackTrace();
        }

        return isRst;
    }

    //파일 헤더 체크
    public static String fileToByte(String szFilePath)throws Exception{
        byte [] b = new byte[16];
        String szFileHeader = "";
        DataInputStream in = null;
        try{
            //파일을 DataInputStream에 넣고 byte array로 읽어들임.(담기)
            in = new DataInputStream(new FileInputStream(szFilePath));
            in.read(b);
            for(int i=0;i<b.length;i++) {
                szFileHeader += byteToHex(b[i]);
            }

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(in != null){in.close();}
        }
        return szFileHeader;
    }


    //byte -> Hex(String)로 변경
    public static String byteToHex(byte in) {
        byte ch = 0x00;
        String pseudo[] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"};
        StringBuffer out = new StringBuffer();

        ch = (byte) (in & 0xF0);
        ch = (byte) (ch >>> 4);
        ch = (byte) (ch & 0x0F);

        out.append(pseudo[ (int) ch]);
        ch = (byte) (in & 0x0F);
        out.append(pseudo[ (int) ch]);

        String rslt = new String(out);
        return rslt;
    }


    //파일 확장자 체크
    public static boolean fileUploadCheckExt(String fileName){
        boolean result= false;
        String check = fileName.substring(fileName.lastIndexOf("."));
        if(check.equalsIgnoreCase(".jpg")||check.equalsIgnoreCase(".bmp")
                ||check.equalsIgnoreCase(".gif")||check.equalsIgnoreCase(".png")){
            result = true;
        }

        return result;
    }

    static{
        mediaMap = new HashMap<String, MediaType>();
        mediaMap.put("JPG", MediaType.IMAGE_JPEG);
        mediaMap.put("GIF", MediaType.IMAGE_GIF);
        mediaMap.put("PNG", MediaType.IMAGE_PNG);
    }

    public static MediaType getMediaType(String type){

        return mediaMap.get(type.toUpperCase());
    }
}
