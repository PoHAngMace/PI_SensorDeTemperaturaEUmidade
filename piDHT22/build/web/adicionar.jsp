<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="entradaDados.css">
    </head>
    <body>
        <%
            //Receber os dados digitados no formulário adicionar.html
            int c;
            String h;
            double t, u;
            c = Integer.parseInt(request.getParameter("codigo"));
            h = request.getParameter("hora");
            t = Double.parseDouble(request.getParameter("temperatura"));
            u = Double.parseDouble(request.getParameter("umidade"));
            try {
                //Fazer a conexão com o Banco de Dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/sensor", "root", "manape");
                //Inserir os dados na tabela produto do banco de dados aberto
                st = conecta.prepareStatement("INSERT INTO leitura VALUES(?,?,?,?)");
                st.setInt(1, c);
                st.setString(2, h);
                st.setDouble(3, t);
                st.setDouble(4, u);
                st.executeUpdate(); //Executa o comando INSERT
                out.print("<p style='color:blue;font-size:15px'>Leitura cadastrada com sucesso</p>");
            } catch (Exception x) {
                String erro = x.getMessage();
                if (erro.contains("Duplicate entry")) {
                    out.print("<p style='color:blue;font-size:15px'>Esta leitura já está cadastrada</p>");
                } else {
                    out.print("<p style='color:blue;font-size:15px'>Mensagem de erro:" + erro + "</p>");
                }
            }
        %>
    </body>
</html>
