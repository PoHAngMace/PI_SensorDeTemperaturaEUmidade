<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
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
            //Recebe o código da leitura a alterar
            int c;
            c = Integer.parseInt(request.getParameter("codigo"));
            //Fazer a conexão com o Banco de Dados
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/sensor", "root", "manape");
            //Buscar pelo c�digo recebido
            st = conecta.prepareStatement("SELECT * FROM leitura WHERE codigo = ?");
            st.setInt(1, c);
            ResultSet resultado = st.executeQuery(); //Executa o SELECT
            //Verifica se a leitura de código informada foi encontrada
            if (!resultado.next()) { //se não encontrou a leitura
                out.print("Esta leitura não foi encontrada");
            } else { //se encontrou a leitura
        %>
        <form method="post" action="alterar_leituras.jsp">
            <p>
                <label for="codigo">Código:</label>
                <input type="number" name="codigo" id="codigo" value="<%= resultado.getString("codigo") %>" readonly>
            </p>
            <p>
                <label for="hora">Hora da leitura:</label>
                <input type="text" name="hora" id="hora" size="70" value="<%= resultado.getString("hora") %>">
            </p>  
            <p>
                <label for="temperatura">Tmeperatura: </label>
                <input type="text" name="temperatura" id="temperatura" value="<%= resultado.getString("temperatura") %>">
            </p> 
            <p>
                <label for="umidade">Umidade:</label>
                <input type="number" step="0.1" name="umidade" id="umidade" value="<%= resultado.getString("umidade") %>">
            </p>              
            <p>
                <input type="submit" value="Salvar Alterações">   
            </p>
        </form>    
        <%
            }
        %>    
    </body>
</html>
