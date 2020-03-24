package com.qiniu.pili.droid.streaming.demo.utils;

import android.content.res.AssetManager;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;


public class FileUtils {

    /**
     * 递归拷贝 Asset 目录中的文件到 rootDir 中
     * @param assets
     * @param path
     * @param rootDir
     * @throws IOException
     */
    public static void copyAssets(AssetManager assets, String path, String rootDir) throws IOException {
        if (isAssetsDir(assets, path)) {
            File dir = new File(rootDir + File.separator + path);
            if (!dir.exists() && !dir.mkdirs()) {
                throw new IllegalStateException("mkdir failed");
            }
            for (String s : assets.list(path)) {
                copyAssets(assets, path + "/" + s, rootDir);
            }
        } else {
            InputStream input = assets.open(path);
            File dest = new File(rootDir, path);
            outputToFile(input, dest);
        }
    }

    /**
     * 判断是否为一个 assets 资源文件夹
     * @param assets AssetManager
     * @param path 路径
     * @return
     */
    public static boolean isAssetsDir(AssetManager assets, String path) {
        try {

            String[] files = assets.list(path);
            return files != null && files.length > 0;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 从输入流中输出到指定文件
     * @param inputStream 输入流
     * @param destFile 目标文件
     * @throws IOException
     */
    public static void outputToFile(InputStream inputStream, File destFile) throws IOException {
        if (destFile.exists()) {
            return;
        }
        File file = destFile.getParentFile();
        if (file != null && !file.exists()) {
            file.mkdirs();
        }
        FileOutputStream out = new FileOutputStream(destFile);
        try {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) >= 0) {
                out.write(buffer, 0, bytesRead);
            }
        } finally {
            out.flush();
            try {
                out.getFD().sync();
            } catch (IOException e) {
            }
            out.close();
        }
    }

    /**
     * 清空文件夹
     * @param dir 目标文件夹
     * @return 是否成功
     */
    public static boolean clearDir(File dir) {
        if (!dir.exists()) {
            return true;
        }
        File[] files = dir.listFiles();
        for (File file : files) {
            if (file.isDirectory()) {
                clearDir(file);
                file.delete();
            } else {
                if (file.exists()) {
                    file.delete();
                }
            }
        }
        return true;
    }

}
