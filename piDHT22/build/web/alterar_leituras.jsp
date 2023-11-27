<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alteração de Leituras</title>
        <link rel="stylesheet" href="entradaDados.css">
    </head>
    <body>
        <%
            //Receber os dados ALTERADOS no formulário e_carregaRead.jsp
            int c;
            String h;
            double t, u;
            c = Integer.parseInt(request.getParameter("codigo"));
            h = request.getParameter("hora");
            t = Double.parseDouble(request.getParameter("temperatura"));
            u = Double.parseDouble(request.getParameter("umidade"));
           try{
            //Fazer a conexão com o Banco de Dados
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/sensor", "root", "manape");
            //Alterar o sdados na tabela produtos do BD
            st = conecta.prepareStatement("UPDATE leitura SET hora = ?, temperatura = ?, umidade = ? WHERE codigo = ?");
            st.setString(1, h);
            st.setDouble(2, t);
            st.setDouble(3, u);
            st.setInt(4, c);
            st.executeUpdate(); //Executa o UPDATE
            out.print("Os dados da leitura " + c + " foram alterados com sucesso");
       } catch (Exception erro){
          out.print ("Entre em contato com o suporte e informe o erro " + erro.getMessage());
       }
%>    
    </body>
</html>
