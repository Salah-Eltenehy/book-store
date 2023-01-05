package com.example.demo.reports;

import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ReportService {
    public ReportService() throws SQLException, ClassNotFoundException {
    }
    public static Connection getDbaseConnection(String HOST_NAME, String DBASE_NAME, String USER_NAME, String USR_PASS) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        String CNTION_URL = "jdbc:mysql://" + HOST_NAME + "/" + DBASE_NAME;
        return DriverManager.getConnection(CNTION_URL, USER_NAME,USR_PASS);
    }
    String hostName = "localhost";
    String dbName = "bookstore";
    String userName = "root";
    String password = "root";
    String commonPath = "src/main/java/com/example/demo/reports/";
    Connection connection = getDbaseConnection(hostName,dbName,userName,password);
    public boolean viewTop5Customers() throws JRException {
        return viewReport("top5Customers");
    }
    public boolean viewTop10Books() throws JRException {
        return viewReport("top10Books");
    }
    public boolean viewTotalBookSales() throws JRException {
        return viewReport("totalBookSales");
    }

    private boolean viewReport(String fileName) throws JRException {
        JasperDesign design = JRXmlLoader.load(commonPath + fileName + ".jrxml");
//        JasperDesign design = JRXmlLoader.load(commonPath + "patient" + ".jrxml");
        JasperReport report = JasperCompileManager.compileReport(design);
        JasperPrint jasperPrint = JasperFillManager.fillReport(report, null, this.connection);
//        JasperViewer.viewReport(jasperPrint, false);
        JasperExportManager.exportReportToPdfFile(jasperPrint, commonPath + fileName +".pdf");
        return true;
    }
}
