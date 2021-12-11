package com.cool.common;

import com.cool.entity.User;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;


/**
 * @Author 许俊青
 * @Date: 2021/7/29 15:38
 */
@Component
public class Utils {



    /**
     * 生成随机密码生成方式一
     * 密码字典 -> 随机获取字符
     *
     * @param len 生成密码长度（最短为4位）
     * @return 随机密码
     * @author 许俊青
     */
    public static String getPassWord(int len) {
        // 如果len 小于等于3
        if (len <= 3) {
            throw new RuntimeException("密码的位数不能小于3位！");
        }
        //生成的随机数
        int i;
        //生成的密码的长度
        int count = 0;
        // 密码字典
        char[] str = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
        // 大写字母密码字典
        List<Character> bigStrList = Arrays.asList('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
        Set<Character> bigStrSet = new HashSet<>(bigStrList);
        // 小写字母的密码字典
        List<Character> upperStrList = Arrays.asList('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');
        Set<Character> upperStrSet = new HashSet<>(upperStrList);
        // 数字的密码字典
        List<Character> numStrList = Arrays.asList('0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
        Set<Character> numStrSet = new HashSet<>(numStrList);

        StringBuilder builder = new StringBuilder();
        Random r = new Random();
        boolean isContainBigChar = false;
        boolean isContainUpperChar = false;
        boolean isContainNumChar = false;
        while (count < len - 3) {
            //生成 0 ~ 密码字典-1之间的随机数
            i = r.nextInt(str.length);
            builder.append(str[i]);
            count++;
            if (!isContainBigChar && bigStrSet.contains(str[i])) {
                isContainBigChar = true;
            }
            if (!isContainUpperChar && upperStrSet.contains(str[i])) {
                isContainUpperChar = true;
            }
            if (!isContainNumChar && numStrSet.contains(str[i])) {
                isContainNumChar = true;
            }
        }
        // 如果不存在的，则加，确保一定会存在数字，大写字母，小写字母
        if (!isContainBigChar) {
            builder.append(bigStrList.get(r.nextInt(bigStrList.size())));
        }
        if (!isContainUpperChar) {
            builder.append(upperStrList.get(r.nextInt(upperStrList.size())));
        }
        if (!isContainNumChar) {
            builder.append(numStrList.get(r.nextInt(numStrList.size())));
        }
        while (builder.length() < len) {
            builder.append(str[r.nextInt(str.length)]);
        }
        return builder.toString();
    }


    /**
     * 生成6位账号
     */
    public static String getGh() {
        String nanoTime = String.valueOf(System.nanoTime());
        return nanoTime.substring(nanoTime.length() - 6);

    }





    /**
     * @Description: 获取uuid
     * @Param:
     * @return: java.lang.String
     * @Author: 许俊青
     * @Date: 2021/8/28 23:13
     */
    public static String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }


    /**
     * @Description: 发送http请求
     * @Param: urlParam
     * @Param: requestType
     * @return: java.lang.String
     * @Author: 许俊青
     * @Date: 2021/9/27 13:41
     */
    public static String sendRequest(String urlParam, String requestType) {

        HttpURLConnection con = null;

        BufferedReader buffer = null;
        StringBuffer resultBuffer = null;

        try {
            URL url = new URL(urlParam);
            //得到连接对象
            con = (HttpURLConnection) url.openConnection();
            //设置请求类型
            con.setRequestMethod(requestType);
            //设置请求需要返回的数据类型和字符集类型
            con.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
            //允许写出
            con.setDoOutput(true);
            //允许读入
            con.setDoInput(true);
            //不使用缓存
            con.setUseCaches(false);
            //得到响应码
            int responseCode = con.getResponseCode();

            if (responseCode == HttpURLConnection.HTTP_OK) {
                //得到响应流
                InputStream inputStream = con.getInputStream();
                //将响应流转换成字符串
                resultBuffer = new StringBuffer();
                String line;
                buffer = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
                while ((line = buffer.readLine()) != null) {
                    resultBuffer.append(line);
                }
                return resultBuffer.toString();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }




  /*  public static void main(String[] args) {
        getDistrictData();
    }*/

    /**
     * @Description: 自动生成controller service dao
     * @Param: prefix
     * @Param: topPackagePath
     * @return: void
     * @Author: 许俊青
     * @Date: 2021/9/29 14:42
     */
    public static void makeCode(String prefix, String topPackagePath) throws Exception {
        File daoI=new File(topPackagePath + "/dao/" + prefix + "Mapper.java");
        if(daoI.exists()){
            throw new OAException(prefix + "Mapper.java已存在");
        }
        Writer writer = new BufferedWriter(new FileWriter(daoI));

        String packageStr = topPackagePath.substring(topPackagePath.indexOf("com")).replaceAll("/|\\\\", ".");
        if (!".".equals(packageStr.charAt(packageStr.length() - 1))) {
            packageStr += ".";
        }
        writer.write("package " + packageStr + "dao;\n\n");
        writer.write("import com.cool.entity."+prefix+";");
        writer.write("\n");
        writer.write("\n");

        writer.write("public interface " + prefix + "Mapper extends BaseMapper<"+prefix+">{");
        writer.write("\n}");
        writer.flush();
        writer.close();



        File serviceI=new File(topPackagePath + "/service/" + prefix + "Service.java");
        if(serviceI.exists()){
            throw new OAException(prefix + "Service.java已存在");
        }
        writer = new BufferedWriter(new FileWriter(serviceI));
        writer.write("package " + packageStr + "service;\n\n");
        writer.write("import com.cool.entity."+prefix+";");
        writer.write("\n");
        writer.write("\n");

        writer.write("public interface " + prefix + "Service extends BaseService<"+prefix+">{");
        writer.write("\n}");
        writer.flush();
        writer.close();

        File service=new File(topPackagePath + "/service/impl/" + prefix + "ServiceImpl.java");
        if(service.exists()){
            throw new OAException(prefix + "ServiceImpl.java已存在");
        }
        writer = new BufferedWriter(new FileWriter(service));
        writer.write("package " + packageStr + "service.impl;\n\n");
        writer.write("import com.cool.dao."+prefix+"Mapper;\n" +
                "import org.springframework.beans.factory.annotation.Autowired;\n" +
                "import com.cool.entity."+prefix+";\n" +
                "import com.cool.service."+prefix+"Service;\n" +
                "import org.springframework.stereotype.Service;");
        writer.write("\n");
        writer.write("\n");

        writer.write("@Service");
        writer.write("\n");
        writer.write("public class " + prefix + "ServiceImpl extends BaseServiceImpl<"+prefix+"> implements "+prefix+"Service{");
        writer.write("\n\n");
        writer.write("\t@Autowired\n");
        writer.write("\tprivate " + prefix + "Mapper " + String.valueOf(prefix.charAt(0)).toLowerCase() + prefix.substring(1) + "Mapper" + ";");
        writer.write("\n}");
        writer.flush();
        writer.close();

        File controller=new File(topPackagePath + "/controller/" + prefix + "Controller.java");
        if(controller.exists()){
            throw new OAException(prefix + "Controller.java已存在");
        }
        writer = new BufferedWriter(new FileWriter(controller));
        writer.write("package " + packageStr + "controller;\n\n");
        writer.write("import com.cool.service."+prefix+"Service;\n" +
                "import org.springframework.beans.factory.annotation.Autowired;\n" +
                "import org.springframework.web.bind.annotation.RequestMapping;\n"+
                "import org.springframework.stereotype.Controller;\n");
        writer.write("\n");
        writer.write("@Controller\n");
        writer.write("@RequestMapping(\""+String.valueOf(prefix.charAt(0)).toLowerCase() + prefix.substring(1)+"Controller\")");
        writer.write("\n");
        writer.write("public class " + prefix + "Controller{");
        writer.write("\n\n");
        writer.write("\t@Autowired\n");
        writer.write("\tprivate " + prefix + "Service " + String.valueOf(prefix.charAt(0)).toLowerCase() + prefix.substring(1) + "Service" + ";");
        writer.write("\n}");

        writer.flush();
        writer.close();
    }

    public static void main(String[] args) throws Exception {
        makeCode("Menu", "E:\\project\\oa\\src\\main\\java\\com\\cool");
    }

    public  static User getCurrentUser(){
        User user=new User();
        user.setUserId(108L);
        user.setUserName("wind_so_cool");
        return user;
    }
}
