package ru.vladmatyunin;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.*;
import java.util.Collections;

/**
 * Created by vladislav on 07.10.17.
 */

public class DocumentLoader {
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/tf_idf";

    //  Database credentials
    private static final String USER = "postgres";
    private static final String PASS = "sa";

    public DocumentLoader(){

        try {
            Class.forName("org.postgresql.Driver");
        }
        catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void initDb(){
        try (Connection connection = DriverManager.getConnection(DB_URL,USER,PASS)) {
            connection.prepareStatement("CREATE TABLE my_document(id SERIAL PRIMARY KEY , path VARCHAR(50))").execute();
            connection.prepareStatement("CREATE TABLE words(value VARCHAR(10), doc_id INTEGER REFERENCES my_document(id), size INTEGER)").execute();
        }
        catch (SQLException e){

        }
    }

    public void loadData(URL url, int shinglingSize) throws IOException {

        try (Connection connection = DriverManager.getConnection(DB_URL,USER,PASS)){
            PreparedStatement statementInsert = connection.prepareStatement("INSERT INTO my_document(path) VALUES (?)");
            String[] pathValues = url.getPath().split("/");
            statementInsert.setString(1, pathValues[pathValues.length-1]);
            statementInsert.execute();
            PreparedStatement statementSelectDoc = connection.prepareStatement("SELECT id FROM my_document WHERE path=?");
            statementSelectDoc.setString(1,pathValues[pathValues.length-1]);
            ResultSet resultSet = statementSelectDoc.executeQuery();
            resultSet.next();
            int documentId = resultSet.getInt(1);
            Files.lines(Paths.get(url.toURI())).forEachOrdered(s -> {
                for (int i =0; i < s.length()-shinglingSize; i++){
                    String shingling = s.substring(i, i+shinglingSize);

                    try(PreparedStatement insertWord = connection.prepareStatement("INSERT INTO words VALUES (?,?,?)")) {
                        insertWord.setString(1, shingling);
                        insertWord.setInt(2, documentId);
                        insertWord.setInt(3, shinglingSize);
                        insertWord.execute();
                    }catch (SQLException e){

                    }

                }
            });
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();

        }
    }


}
