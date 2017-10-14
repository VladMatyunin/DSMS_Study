package ru.vladmatyunin;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Path;
import java.sql.SQLException;

public class Main {
    private static URL url1;
    private static URL url2;
    public void init(){
        url1 = getClass().getResource("../../Genome_1.txt");
        url2 = getClass().getResource("../../Genome_2.txt");

    }
    public static void main(String[] args) {
        new Main().init();

            try {
                DocumentLoader loader = new DocumentLoader();
                loader.initDb();
                loader.loadData(url1, 3);
                loader.loadData(url2, 3);
            }
            catch (IOException ignored){
                ignored.printStackTrace();
        }
    }
}
